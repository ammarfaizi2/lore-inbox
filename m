Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313068AbSDJNyE>; Wed, 10 Apr 2002 09:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSDJNyD>; Wed, 10 Apr 2002 09:54:03 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:61450 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313068AbSDJNyC>; Wed, 10 Apr 2002 09:54:02 -0400
Message-ID: <3CB442E0.5020305@namesys.com>
Date: Wed, 10 Apr 2002 17:49:20 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS, please apply 1 of 13
Content-Type: multipart/mixed;
 boundary="------------090206000805070803030107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090206000805070803030107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------090206000805070803030107
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 1 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 1 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13231 invoked from network); 10 Apr 2002 11:21:50 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:50 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id A492C3AFF05; Wed, 10 Apr 2002 15:21:50 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:50 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 1 of 13
Message-ID: <20020410152150.A20859@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i

This patch is to fix a problem when directory's atime was not updated on
readdir(). Patch is written by Chris Mason.

--- linux-2.5.8-pre2.o/fs/reiserfs/dir.c Thu, 13 Dec 2001 11:06:51 -0500
+++ linux-2.5.8-pre2/fs/reiserfs/dir.c Tue, 29 Jan 2002 17:56:04 -0500
@@ -180,6 +180,7 @@
     filp->f_pos = next_pos;
     pathrelse (&path_to_entry);
     reiserfs_check_path(&path_to_entry) ;
+    UPDATE_ATIME(inode) ;
     return 0;
 }
 




--------------090206000805070803030107--

