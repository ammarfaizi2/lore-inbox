Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbSIWOKS>; Mon, 23 Sep 2002 10:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbSIWOKR>; Mon, 23 Sep 2002 10:10:17 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:59142 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261509AbSIWOKQ>; Mon, 23 Sep 2002 10:10:16 -0400
Message-ID: <3D8F21FC.6070305@namesys.com>
Date: Mon, 23 Sep 2002 18:15:24 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [BK] [PATCH] ReiserFS bugfix for 2.5 (1 of 1)
Content-Type: multipart/mixed;
 boundary="------------080307080506090100000206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080307080506090100000206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------080307080506090100000206
Content-Type: message/rfc822;
 name="Fix for 2.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Fix for 2.5"

Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 9128 invoked from network); 20 Sep 2002 12:00:47 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 20 Sep 2002 12:00:47 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 7E5E71306C9; Fri, 20 Sep 2002 16:00:47 +0400 (MSD)
Date: Fri, 20 Sep 2002 16:00:47 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: Fix for 2.5
Message-ID: <20020920160047.A12840@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i

Hello!

   This changeset is to fix bug in alloc= mount option parser in reiserfs.
   It was only tested by me (and it works) since our testers still cannot
   get 2.5 kernel to work stably.

   You can pull it from bk://thebsh.namesys.com/bk/reiser3-linux-2.5

Diffstat:
 bitmap.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Plain text patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.570   -> 1.571  
#	fs/reiserfs/bitmap.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/20	green@angband.namesys.com	1.571
# Reiserfs: Fix alloc= mount option parser.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c	Fri Sep 20 15:56:10 2002
+++ b/fs/reiserfs/bitmap.c	Fri Sep 20 15:56:10 2002
@@ -395,7 +395,7 @@
 
     REISERFS_SB(s)->s_alloc_options.bits = 0; /* clear default settings */
 
-    for (this_char = strsep (&options, ":"); this_char != NULL; ) {
+    while ( (this_char = strsep (&options, ":")) != NULL ) {
 	if ((value = strchr (this_char, '=')) != NULL)
 	    *value++ = 0;
 



--------------080307080506090100000206--

