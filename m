Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVDBXME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVDBXME (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 18:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVDBXMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 18:12:03 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:49073 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261341AbVDBXJz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 18:09:55 -0500
Message-ID: <424F2502.9040308@tiscali.de>
Date: Sun, 03 Apr 2005 01:04:34 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Steve French <smfrench@austin.rr.com>, Steven French <sfrench@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/7] cifs: dir.c cleanup - spaces
References: <Pine.LNX.4.62.0504030052020.2525@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0504030052020.2525@dragon.hyggekrogen.localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl schrieb:

>Cleanup spacing and trailing whitespace in fs/cifs/dir.c
>
>Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
>
>
>--- linux-2.6.12-rc1-mm4/fs/cifs/dir.c.with_patch1	2005-04-02 23:31:27.000000000 +0200
>+++ linux-2.6.12-rc1-mm4/fs/cifs/dir.c	2005-04-02 23:47:39.000000000 +0200
>@@ -37,7 +37,7 @@ void renew_parental_timestamps(struct de
> 	do {
> 		direntry->d_time = jiffies;
> 		direntry = direntry->d_parent;
>-	} while (!IS_ROOT(direntry));	
>+	} while (!IS_ROOT(direntry));
> }
> 
> /* Note: caller must free return buffer */
>@@ -47,27 +47,27 @@ char *build_path_from_dentry(struct dent
> 	int namelen = 0;
> 	char *full_path;
> 
>-	if(direntry == NULL)
>-		return NULL;  /* not much we can do if dentry is freed and
>+	if (direntry == NULL)
>+		return NULL;	/* not much we can do if dentry is freed and
> 		we need to reopen the file after it was closed implicitly
> 		when the server crashed */
> 
> cifs_bp_rename_retry:
>-	for (temp = direntry; !IS_ROOT(temp);) {
>+	for (temp = direntry; !IS_ROOT(temp); ) {
> 		namelen += (1 + temp->d_name.len);
> 		temp = temp->d_parent;
>-		if(temp == NULL) {
>-			cERROR(1,("corrupt dentry"));
>+		if (temp == NULL) {
>+			cERROR(1, ("corrupt dentry"));
> 			return NULL;
> 		}
> 	}
> 
>-	full_path = kmalloc(namelen+1, GFP_KERNEL);
>-	if(full_path == NULL)
>+	full_path = kmalloc(namelen + 1, GFP_KERNEL);
>+	if (full_path == NULL)
> 		return full_path;
> 	full_path[namelen] = 0;	/* trailing null */
> 
>-	for (temp = direntry; !IS_ROOT(temp);) {
>+	for (temp = direntry; !IS_ROOT(temp); ) {
> 		namelen -= 1 + temp->d_name.len;
> 		if (namelen < 0) {
> 			break;
>@@ -78,16 +78,15 @@ cifs_bp_rename_retry:
> 			cFYI(0, (" name: %s ", full_path + namelen));
> 		}
> 		temp = temp->d_parent;
>-		if(temp == NULL) {
>-			cERROR(1,("corrupt dentry"));
>+		if (temp == NULL) {
>+			cERROR(1, ("corrupt dentry"));
> 			kfree(full_path);
> 			return NULL;
> 		}
> 	}
> 	if (namelen != 0) {
>-		cERROR(1,
>-		       ("We did not end path lookup where we expected namelen is %d",
>-			namelen));
>+		cERROR(1, ("We did not end path lookup where we expected "
>+			   "namelen is %d", namelen));
> 		/* presumably this is only possible if we were racing with a rename 
> 		of one of the parent directories  (we can not lock the dentries
> 		above us to prevent this, but retrying should be harmless) */
>@@ -106,30 +105,30 @@ char *build_wildcard_path_from_dentry(st
> 	int namelen = 0;
> 	char *full_path;
> 
>-	if(direntry == NULL)
>-		return NULL;  /* not much we can do if dentry is freed and
>+	if (direntry == NULL)
>+		return NULL;	/* not much we can do if dentry is freed and
> 		we need to reopen the file after it was closed implicitly
> 		when the server crashed */
> 
> cifs_bwp_rename_retry:
>-	for (temp = direntry; !IS_ROOT(temp);) {
>+	for (temp = direntry; !IS_ROOT(temp); ) {
> 		namelen += (1 + temp->d_name.len);
> 		temp = temp->d_parent;
>-		if(temp == NULL) {
>-			cERROR(1,("corrupt dentry"));
>+		if (temp == NULL) {
>+			cERROR(1, ("corrupt dentry"));
> 			return NULL;
> 		}
> 	}
> 
>-	full_path = kmalloc(namelen+3, GFP_KERNEL);
>-	if(full_path == NULL)
>+	full_path = kmalloc(namelen + 3, GFP_KERNEL);
>+	if (full_path == NULL)
> 		return full_path;
> 
> 	full_path[namelen] = '\\';
>-	full_path[namelen+1] = '*';
>-	full_path[namelen+2] = 0;  /* trailing null */
>+	full_path[namelen + 1] = '*';
>+	full_path[namelen + 2] = 0;	/* trailing null */
> 
>-	for (temp = direntry; !IS_ROOT(temp);) {
>+	for (temp = direntry; !IS_ROOT(temp); ) {
> 		namelen -= 1 + temp->d_name.len;
> 		if (namelen < 0) {
> 			break;
>@@ -140,16 +139,15 @@ cifs_bwp_rename_retry:
> 			cFYI(0, (" name: %s ", full_path + namelen));
> 		}
> 		temp = temp->d_parent;
>-		if(temp == NULL) {
>-			cERROR(1,("corrupt dentry"));
>+		if (temp == NULL) {
>+			cERROR(1, ("corrupt dentry"));
> 			kfree(full_path);
> 			return NULL;
> 		}
> 	}
> 	if (namelen != 0) {
>-		cERROR(1,
>-		       ("We did not end path lookup where we expected namelen is %d",
>-			namelen));
>+		cERROR(1, ("We did not end path lookup where we expected "
>+			   "namelen is %d", namelen));
> 		/* presumably this is only possible if we were racing with a rename 
> 		of one of the parent directories  (we can not lock the dentries
> 		above us to prevent this, but retrying should be harmless) */
>@@ -173,10 +171,10 @@ int cifs_create(struct inode *inode, str
> 	struct cifs_sb_info *cifs_sb;
> 	struct cifsTconInfo *pTcon;
> 	char *full_path = NULL;
>-	FILE_ALL_INFO * buf = NULL;
>+	FILE_ALL_INFO *buf = NULL;
> 	struct inode *newinode = NULL;
>-	struct cifsFileInfo * pCifsFile = NULL;
>-	struct cifsInodeInfo * pCifsInode;
>+	struct cifsFileInfo *pCifsFile = NULL;
>+	struct cifsInodeInfo *pCifsInode;
> 	int disposition = FILE_OVERWRITE_IF;
> 	int write_only = FALSE;
> 
>@@ -188,12 +186,12 @@ int cifs_create(struct inode *inode, str
> 	down(&direntry->d_sb->s_vfs_rename_sem);
> 	full_path = build_path_from_dentry(direntry);
> 	up(&direntry->d_sb->s_vfs_rename_sem);
>-	if(full_path == NULL) {
>+	if (full_path == NULL) {
> 		FreeXid(xid);
> 		return -ENOMEM;
> 	}
> 
>-	if(nd) {
>+	if (nd) {
> 		if ((nd->intent.open.flags & O_ACCMODE) == O_RDONLY)
> 			desiredAccess = GENERIC_READ;
> 		else if ((nd->intent.open.flags & O_ACCMODE) == O_WRONLY) {
>@@ -206,14 +204,14 @@ int cifs_create(struct inode *inode, str
> 			desiredAccess = GENERIC_READ | GENERIC_WRITE;
> 		}
> 
>-		if((nd->intent.open.flags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
>+		if ((nd->intent.open.flags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
> 			disposition = FILE_CREATE;
>-		else if((nd->intent.open.flags & (O_CREAT | O_TRUNC)) == (O_CREAT | O_TRUNC))
>+		else if ((nd->intent.open.flags & (O_CREAT | O_TRUNC)) == (O_CREAT | O_TRUNC))
> 			disposition = FILE_OVERWRITE_IF;
>-		else if((nd->intent.open.flags & O_CREAT) == O_CREAT)
>+		else if ((nd->intent.open.flags & O_CREAT) == O_CREAT)
> 			disposition = FILE_OPEN_IF;
> 		else {
>-			cFYI(1,("Create flag not set in create function"));
>+			cFYI(1, ("Create flag not set in create function"));
> 		}
> 	}
> 
>@@ -221,82 +219,82 @@ int cifs_create(struct inode *inode, str
> 	if (oplockEnabled)
> 		oplock = REQ_OPLOCK;
> 
>-	buf = kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);
>-	if(buf == NULL) {
>+	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
>+	if (buf == NULL) {
> 		kfree(full_path);
> 		FreeXid(xid);
> 		return -ENOMEM;
> 	}
> 
>-	rc = CIFSSMBOpen(xid, pTcon, full_path, disposition,
>-			 desiredAccess, CREATE_NOT_DIR,
>-			 &fileHandle, &oplock, buf, cifs_sb->local_nls);
>+	rc = CIFSSMBOpen(xid, pTcon, full_path, disposition, desiredAccess,
>+			 CREATE_NOT_DIR, &fileHandle, &oplock, buf,
>+			 cifs_sb->local_nls);
> 	if (rc) {
> 		cFYI(1, ("cifs_create returned 0x%x ", rc));
> 	} else {
> 		/* If Open reported that we actually created a file
> 		then we now have to set the mode if possible */
> 		if ((cifs_sb->tcon->ses->capabilities & CAP_UNIX) &&
>-			(oplock & CIFS_CREATE_ACTION))
>-			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID) {
>-				CIFSSMBUnixSetPerms(xid, pTcon, full_path, mode,
>-					(__u64)current->euid,
>-					(__u64)current->egid,
>-					0 /* dev */,
>-					cifs_sb->local_nls);
>+		    (oplock & CIFS_CREATE_ACTION)) {
>+			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID) {
>+				CIFSSMBUnixSetPerms(xid, pTcon, full_path,
>+						    mode, (__u64)current->euid,
>+						    (__u64)current->egid,
>+						    0 /* dev */,
>+						    cifs_sb->local_nls);
> 			} else {
>-				CIFSSMBUnixSetPerms(xid, pTcon, full_path, mode,
>-					(__u64)-1,
>-					(__u64)-1,
>-					0 /* dev */,
>-					cifs_sb->local_nls);
>+				CIFSSMBUnixSetPerms(xid, pTcon, full_path,
>+						    mode, (__u64)-1, (__u64)-1,
>+						    0 /* dev */,
>+						    cifs_sb->local_nls);
> 			}
>-		else {
>+		} else {
> 			/* BB implement via Windows security descriptors */
> 			/* eg CIFSSMBWinSetPerms(xid,pTcon,full_path,mode,-1,-1,local_nls);*/
> 			/* could set r/o dos attribute if mode & 0222 == 0 */
> 		}
> 
> 	/* BB server might mask mode so we have to query for Unix case*/
>-		if (pTcon->ses->capabilities & CAP_UNIX)
>+		if (pTcon->ses->capabilities & CAP_UNIX) {
> 			rc = cifs_get_inode_info_unix(&newinode, full_path,
>+						      inode->i_sb,xid);
>+		} else {
>+			rc = cifs_get_inode_info(&newinode, full_path, buf,
> 						 inode->i_sb,xid);
>-		else {
>-			rc = cifs_get_inode_info(&newinode, full_path,
>-						 buf, inode->i_sb,xid);
>-			if(newinode)
>+			if (newinode)
> 				newinode->i_mode = mode;
> 		}
> 
> 		if (rc != 0) {
>-			cFYI(1,("Create worked but get_inode_info failed with rc = %d",
>-			      rc));
>+			cFYI(1, ("Create worked but get_inode_info failed with"
>+				 " rc = %d", rc));
> 		} else {
> 			direntry->d_op = &cifs_dentry_ops;
> 			d_instantiate(direntry, newinode);
> 		}
>-		if((nd->flags & LOOKUP_OPEN) == FALSE) {
>+		if ((nd->flags & LOOKUP_OPEN) == FALSE) {
> 			/* mknod case - do not leave file open */
> 			CIFSSMBClose(xid, pTcon, fileHandle);
>-		} else if(newinode) {
>+		} else if (newinode) {
> 			pCifsFile = (struct cifsFileInfo *)
> 			   kmalloc(sizeof (struct cifsFileInfo), GFP_KERNEL);
>-		
>+
> 			if (pCifsFile) {
> 				memset((char *)pCifsFile, 0,
>-				       sizeof (struct cifsFileInfo));
>+				       sizeof(struct cifsFileInfo));
> 				pCifsFile->netfid = fileHandle;
> 				pCifsFile->pid = current->tgid;
> 				pCifsFile->pInode = newinode;
> 				pCifsFile->invalidHandle = FALSE;
>-				pCifsFile->closePend     = FALSE;
>+				pCifsFile->closePend = FALSE;
> 				init_MUTEX(&pCifsFile->fh_sem);
> 				/* put the following in at open now */
> 				/* pCifsFile->pfile = file; */ 
> 				write_lock(&GlobalSMBSeslock);
>-				list_add(&pCifsFile->tlist,&pTcon->openFileList);
>+				list_add(&pCifsFile->tlist,
>+					 &pTcon->openFileList);
> 				pCifsInode = CIFS_I(newinode);
>-				if(pCifsInode) {
>+				if (pCifsInode) {
> 				/* if readable file instance put first in list*/
> 					if (write_only == TRUE) {
>                                         	list_add_tail(&pCifsFile->flist,
>@@ -305,18 +303,18 @@ int cifs_create(struct inode *inode, str
> 						list_add(&pCifsFile->flist,
> 							&pCifsInode->openFileList);
> 					}
>-					if((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
>+					if ((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
> 						pCifsInode->clientCanCacheAll = TRUE;
> 						pCifsInode->clientCanCacheRead = TRUE;
>-						cFYI(1,("Exclusive Oplock granted on inode %p",
>+						cFYI(1, ("Exclusive Oplock granted on inode %p",
> 							newinode));
>-					} else if((oplock & 0xF) == OPLOCK_READ)
>+					} else if ((oplock & 0xF) == OPLOCK_READ)
> 						pCifsInode->clientCanCacheRead = TRUE;
> 				}
> 				write_unlock(&GlobalSMBSeslock);
> 			}
> 		}
>-	} 
>+	}
> 
> 	if (buf)
> 	    kfree(buf);
>@@ -328,14 +326,14 @@ int cifs_create(struct inode *inode, str
> }
> 
> int cifs_mknod(struct inode *inode, struct dentry *direntry, int mode,
>-	dev_t device_number) 
>+	dev_t device_number)
> {
> 	int rc = -EPERM;
> 	int xid;
> 	struct cifs_sb_info *cifs_sb;
> 	struct cifsTconInfo *pTcon;
> 	char *full_path = NULL;
>-	struct inode * newinode = NULL;
>+	struct inode *newinode = NULL;
> 
> 	if (!old_valid_dev(device_number))
> 		return -EINVAL;
>@@ -348,25 +346,28 @@ int cifs_mknod(struct inode *inode, stru
> 	down(&direntry->d_sb->s_vfs_rename_sem);
> 	full_path = build_path_from_dentry(direntry);
> 	up(&direntry->d_sb->s_vfs_rename_sem);
>-	if(full_path == NULL)
>+	if (full_path == NULL)
> 		rc = -ENOMEM;
>-	
>+
> 	if (full_path && (pTcon->ses->capabilities & CAP_UNIX)) {
>-		if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID) {
>-			rc = CIFSSMBUnixSetPerms(xid, pTcon, full_path,
>-				mode,(__u64)current->euid,(__u64)current->egid,
>-				device_number, cifs_sb->local_nls);
>+		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID) {
>+			rc = CIFSSMBUnixSetPerms(xid, pTcon, full_path, mode,
>+						 (__u64)current->euid,
>+						 (__u64)current->egid,
>+						 device_number,
>+						 cifs_sb->local_nls);
> 		} else {
>-			rc = CIFSSMBUnixSetPerms(xid, pTcon,
>-				full_path, mode, (__u64)-1, (__u64)-1,
>-				device_number, cifs_sb->local_nls);
>+			rc = CIFSSMBUnixSetPerms(xid, pTcon, full_path, mode,
>+						 (__u64)-1, (__u64)-1,
>+						 device_number,
>+						 cifs_sb->local_nls);
> 		}
> 
>-		if(!rc) {
>+		if (!rc) {
> 			rc = cifs_get_inode_info_unix(&newinode, full_path,
>-						inode->i_sb,xid);
>+						      inode->i_sb,xid);
> 			direntry->d_op = &cifs_dentry_ops;
>-			if(rc == 0)
>+			if (rc == 0)
> 				d_instantiate(direntry, newinode);
> 		}
> 	}
>@@ -390,9 +391,8 @@ struct dentry *cifs_lookup(struct inode 
> 
> 	xid = GetXid();
> 
>-	cFYI(1,
>-	     (" parent inode = 0x%p name is: %s and dentry = 0x%p",
>-	      parent_dir_inode, direntry->d_name.name, direntry));
>+	cFYI(1, (" parent inode = 0x%p name is: %s and dentry = 0x%p",
>+		 parent_dir_inode, direntry->d_name.name, direntry));
> 
> 	/* BB Add check of incoming data - e.g. frame not longer than maximum SMB - let server check the namelen BB */
> 
>@@ -405,7 +405,7 @@ struct dentry *cifs_lookup(struct inode 
> 	deadlock in the cases (beginning of sys_rename itself)
> 	in which we already have the sb rename sem */
> 	full_path = build_path_from_dentry(direntry);
>-	if(full_path == NULL) {
>+	if (full_path == NULL) {
> 		FreeXid(xid);
> 		return ERR_PTR(-ENOMEM);
> 	}
>@@ -415,8 +415,7 @@ struct dentry *cifs_lookup(struct inode 
> 	} else {
> 		cFYI(1, (" NULL inode in lookup"));
> 	}
>-	cFYI(1,
>-	     (" Full path: %s inode = 0x%p", full_path, direntry->d_inode));
>+	cFYI(1, (" Full path: %s inode = 0x%p", full_path, direntry->d_inode));
> 
> 	if (pTcon->ses->capabilities & CAP_UNIX)
> 		rc = cifs_get_inode_info_unix(&newInode, full_path,
>@@ -436,7 +435,8 @@ struct dentry *cifs_lookup(struct inode 
> 		rc = 0;
> 		d_add(direntry, NULL);
> 	} else {
>-		cERROR(1,("Error 0x%x or on cifs_get_inode_info in lookup",rc));
>+		cERROR(1, ("Error 0x%x or on cifs_get_inode_info in lookup",
>+			   rc));
> 		/* BB special case check for Access Denied - watch security 
> 		exposure of returning dir info implicitly via different rc 
> 		if file exists or not but no access BB */
>@@ -462,7 +462,7 @@ int cifs_dir_open(struct inode *inode, s
> 	cifs_sb = CIFS_SB(inode->i_sb);
> 	pTcon = cifs_sb->tcon;
> 
>-	if(file->f_dentry) {
>+	if (file->f_dentry) {
> 		down(&file->f_dentry->d_sb->s_vfs_rename_sem);
> 		full_path = build_wildcard_path_from_dentry(file->f_dentry);
> 		up(&file->f_dentry->d_sb->s_vfs_rename_sem);
>@@ -491,9 +491,8 @@ static int cifs_d_revalidate(struct dent
> 			return 0;
> 		}
> 	} else {
>-		cFYI(1,
>-		     ("In cifs_d_revalidate with no inode but name = %s and dentry 0x%p",
>-		      direntry->d_name.name, direntry));
>+		cFYI(1, ("In cifs_d_revalidate with no inode but name = %s "
>+			 "and dentry 0x%p", direntry->d_name.name, direntry));
> 	}
> 
> /*    unlock_kernel(); */
>@@ -511,7 +510,7 @@ static int cifs_d_revalidate(struct dent
> }     */
> 
> struct dentry_operations cifs_dentry_ops = {
>-	.d_revalidate = cifs_d_revalidate,
>-/* d_delete:       cifs_d_delete,       *//* not needed except for debugging */
>+	.d_revalidate	= cifs_d_revalidate,
>+/*	d_delete:	cifs_d_delete, */ /* not needed except for debugging */
> 	/* no need for d_hash, d_compare, d_release, d_iput ... yet. BB confirm this BB */
> };
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
The Subject is wrong it must be: "[PATCH][2/7] cifs: dir.c cleanup - spaces"

Matthias-Christian Ott
