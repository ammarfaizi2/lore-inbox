Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVCVUbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVCVUbU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVCVU3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:29:30 -0500
Received: from mail.dif.dk ([193.138.115.101]:5044 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261759AbVCVU1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:27:30 -0500
Date: Tue, 22 Mar 2005 21:29:12 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][6/6] cifs: readdir.c cleanup - whitespace final bits (aka
 part 4)
Message-ID: <Pine.LNX.4.62.0503222126500.2683@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch deals with a few remaining whitespace changes the first 3 
patches forgot. Primarily breaking up a few >80col lines were forgotten by 
the previous ones.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm1/fs/cifs/readdir.c.with_patch5	2005-03-22 20:46:41.000000000 +0100
+++ linux-2.6.12-rc1-mm1/fs/cifs/readdir.c	2005-03-22 20:51:10.000000000 +0100
@@ -472,7 +472,7 @@ static int find_cifs_entry(const int xid
 		kfree(cifsFile->search_resume_name);
 		cifsFile->search_resume_name = NULL;
 		if (cifsFile->srch_inf.ntwrk_buf_start) {
-			cFYI(1, ("freeing SMB ff cache buf on search rewind")); 
+			cFYI(1, ("freeing SMB ff cache buf on search rewind"));
 			cifs_buf_release(cifsFile->srch_inf.ntwrk_buf_start);
 		}
 		rc = initiate_cifs_search(xid, file);
@@ -497,10 +497,11 @@ static int find_cifs_entry(const int xid
 		int i;
 		char *current_entry;
 		char *end_of_smb = cifsFile->srch_inf.ntwrk_buf_start + 
-			smbCalcSize((struct smb_hdr *)cifsFile->srch_inf.ntwrk_buf_start);
+			smbCalcSize((struct smb_hdr *)
+				    cifsFile->srch_inf.ntwrk_buf_start);
 		/* dump_cifs_file_struct(file,"found entry in fce "); */
-		first_entry_in_buffer = cifsFile->srch_inf.index_of_last_entry -
-			cifsFile->srch_inf.entries_in_buffer;
+		first_entry_in_buffer = cifsFile->srch_inf.index_of_last_entry
+					- cifsFile->srch_inf.entries_in_buffer;
 		pos_in_buf = index_to_find - first_entry_in_buffer;
 		cFYI(1, ("found entry - pos_in_buf %d", pos_in_buf)); 
 		current_entry = cifsFile->srch_inf.srch_entries_start;
@@ -519,11 +520,12 @@ static int find_cifs_entry(const int xid
 				cFYI(1, ("Entry is ..")); /* BB removeme BB */
 				/* continue; */
 			}
-			current_entry = nxt_dir_entry(current_entry, end_of_smb);
+			current_entry = nxt_dir_entry(current_entry,
+						      end_of_smb);
 		}
 		if ((current_entry == NULL) && (i < pos_in_buf)) {
-   /* BB removeme BB */	cERROR(1, ("reached end of buf searching for pos in buf"
-				   " %d index to find %lld rc %d",
+   /* BB removeme BB */	cERROR(1, ("reached end of buf searching for pos in "
+				   "buf %d index to find %lld rc %d",
 				   pos_in_buf, index_to_find, rc));
 		}
 		rc = 0;
@@ -538,7 +540,8 @@ static int find_cifs_entry(const int xid
 			 "beyond last entry"));
 		*num_to_ret = 0;
 	} else
-		*num_to_ret = cifsFile->srch_inf.entries_in_buffer - pos_in_buf;
+		*num_to_ret = cifsFile->srch_inf.entries_in_buffer -
+			      pos_in_buf;
 	/* dump_cifs_file_struct(file, "end fce "); */
 
 	return rc;
@@ -828,12 +831,13 @@ int cifs_readdir(struct file *file, void
 		cFYI(1, ("loop through %d times filling dir for net buf %p",
 			 num_to_fill,cifsFile->srch_inf.ntwrk_buf_start));
 		end_of_smb = cifsFile->srch_inf.ntwrk_buf_start +
-			smbCalcSize((struct smb_hdr *)cifsFile->srch_inf.ntwrk_buf_start);
+			smbCalcSize((struct smb_hdr *)
+				    cifsFile->srch_inf.ntwrk_buf_start);
 		tmp_buf = kmalloc(NAME_MAX + 1, GFP_KERNEL);
 		for (i = 0; (i < num_to_fill) && (rc == 0); i++) {
 			if (current_entry == NULL) {
-	/* BB removeme BB */	cERROR(1, ("beyond end of smb with num to fill "
-					   "%d i %d", num_to_fill,i));
+	/* BB removeme BB */	cERROR(1, ("beyond end of smb with num to "
+					   "fill %d i %d", num_to_fill, i));
 				break;
 			}
 			/* if ((!(cifs_sb->mnt_cifs_flags &



