Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315860AbSEWDS6>; Wed, 22 May 2002 23:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315878AbSEWDS5>; Wed, 22 May 2002 23:18:57 -0400
Received: from web14201.mail.yahoo.com ([216.136.172.143]:30323 "HELO
	web14201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315860AbSEWDS4>; Wed, 22 May 2002 23:18:56 -0400
Message-ID: <20020523031856.91458.qmail@web14201.mail.yahoo.com>
Date: Wed, 22 May 2002 20:18:56 -0700 (PDT)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: Re: 2.5 ext2fs as a module
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Here goes the patch to export the missing symbol so that ext2 works as a
module...

Please Apply ;)
Erik



# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.582   -> 1.583  
#	         fs/buffer.c	1.102   -> 1.103  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/22	root@camhanaich.local	1.583
# buffer.c:
#   This symbol appears to be needed by ext2fs as a module.  All the other
functions here seem to be exported. .
# --------------------------------------------
#
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Wed May 22 22:01:28 2002
+++ b/fs/buffer.c	Wed May 22 22:01:28 2002
@@ -847,6 +847,8 @@
 	return ret;
 }
 
+EXPORT_SYMBOL(write_mapping_buffers);
+
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 {
 	struct address_space *mapping = inode->i_mapping;



__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
