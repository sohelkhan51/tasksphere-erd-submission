CREATE TABLE Users (
    user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Projects (
    project_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    owner_id INT NOT NULL,
    CONSTRAINT fk_projects_owner
        FOREIGN KEY (owner_id)
        REFERENCES Users(user_id)
);

CREATE TABLE UserProjects (
    user_id INT NOT NULL,
    project_id INT NOT NULL,
    PRIMARY KEY (user_id, project_id),
    CONSTRAINT fk_userprojects_user
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id),
    CONSTRAINT fk_userprojects_project
        FOREIGN KEY (project_id)
        REFERENCES Projects(project_id)
);

CREATE TABLE Tasks (
    task_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    task_name VARCHAR(100) NOT NULL,
    project_id INT NOT NULL,
    assigned_user_id INT,
    status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    CONSTRAINT fk_tasks_project
        FOREIGN KEY (project_id)
        REFERENCES Projects(project_id),
    CONSTRAINT fk_tasks_assigned_user
        FOREIGN KEY (assigned_user_id)
        REFERENCES Users(user_id)
);

CREATE INDEX idx_tasks_project_id ON Tasks(project_id);
CREATE INDEX idx_tasks_assigned_user_id ON Tasks(assigned_user_id);
