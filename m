Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUGRSuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUGRSuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 14:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUGRSuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 14:50:06 -0400
Received: from web53805.mail.yahoo.com ([206.190.36.200]:10411 "HELO
	web53805.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263784AbUGRSt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 14:49:59 -0400
Message-ID: <20040718184959.92312.qmail@web53805.mail.yahoo.com>
Date: Sun, 18 Jul 2004 11:49:59 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from fs/cifs files
To: linux-kernel@vger.kernel.org
Cc: sfrench@samba.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/fs/cifs/cifsfs.h linux-2.6.7-new/fs/cifs/cifsfs.h
--- linux-2.6.7-orig/fs/cifs/cifsfs.h   2004-06-15 22:19:01.000000000 -0700
+++ linux-2.6.7-new/fs/cifs/cifsfs.h    2004-07-18 08:43:49.000000000 -0700
@@ -32,14 +32,10 @@
 #define TRUE 1
 #endif

-extern int map_cifs_error(int error_class, int error_code,
-                         int status_codes_negotiated);
-
 extern struct address_space_operations cifs_addr_ops;

 /* Functions related to super block operations */
 extern struct super_operations cifs_super_ops;
-extern void cifs_put_inode(struct inode *);
 extern void cifs_read_inode(struct inode *);
 extern void cifs_delete_inode(struct inode *);
 /* extern void cifs_write_inode(struct inode *); *//* BB not needed yet */
diff -ru linux-2.6.7-orig/fs/cifs/cifsproto.h linux-2.6.7-new/fs/cifs/cifsproto.h
--- linux-2.6.7-orig/fs/cifs/cifsproto.h        2004-06-15 22:18:55.000000000 -0700
+++ linux-2.6.7-new/fs/cifs/cifsproto.h 2004-07-18 08:45:36.000000000 -0700
@@ -214,30 +214,6 @@
 extern void CalcNTLMv2_partial_mac_key(struct cifsSesInfo *, struct nls_table *);
 extern void CalcNTLMv2_response(const struct cifsSesInfo *,char * );

-extern int CIFSBuildServerList(int xid, char *serverBufferList,
-                       int recordlength, int *entries,
-                       int *totalEntries, int *topoChangedFlag);
-extern int CIFSSMBQueryShares(int xid, struct cifsTconInfo *tcon,
-                       struct shareInfo *shareList, int bufferLen,
-                       int *entries, int *totalEntries);
-extern int CIFSSMBQueryAlias(int xid, struct cifsTconInfo *tcon,
-                       struct aliasInfo *aliasList, int bufferLen,
-                       int *entries, int *totalEntries);
-extern int CIFSSMBAliasInfo(int xid, struct cifsTconInfo *tcon,
-                       char *aliasName, char *serverName,
-                       char *shareName, char *comment);
-extern int CIFSSMBGetShareInfo(int xid, struct cifsTconInfo *tcon,
-                       char *share, char *comment);
-extern int CIFSSMBGetUserPerms(int xid, struct cifsTconInfo *tcon,
-                       char *userName, char *searchName, int *perms);
-extern int CIFSSMBSync(int xid, struct cifsTconInfo *tcon, int netfid, int pid);
-
-extern int CIFSSMBSeek(int xid,
-                       struct cifsTconInfo *tcon,
-                       int netfid,
-                       int pid,
-                       int whence, unsigned long offset, long long *newoffset);
-
 extern int CIFSSMBCopy(int xid,
                        struct cifsTconInfo *source_tcon,
                        const char *fromName,
diff -ru linux-2.6.7-orig/fs/cifs/smbencrypt.c linux-2.6.7-new/fs/cifs/smbencrypt.c
--- linux-2.6.7-orig/fs/cifs/smbencrypt.c       2004-06-15 22:19:23.000000000 -0700
+++ linux-2.6.7-new/fs/cifs/smbencrypt.c        2004-07-18 08:46:05.000000000 -0700
@@ -70,8 +70,6 @@
 void NTLMSSPOWFencrypt(unsigned char passwd[8],
                       unsigned char *ntlmchalresp, unsigned char p24[24]);
 void SMBNTencrypt(unsigned char *passwd, unsigned char *c8, unsigned char *p24);
-int decode_pw_buffer(char in_buffer[516], char *new_pwrd,
-                    int new_pwrd_size, __u32 * new_pw_len);

 /*
    This implements the X/Open SMB password encryption

