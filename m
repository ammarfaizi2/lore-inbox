Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275353AbRJARmM>; Mon, 1 Oct 2001 13:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275354AbRJARlw>; Mon, 1 Oct 2001 13:41:52 -0400
Received: from ps.ksky.ne.jp ([210.233.160.3]:34017 "EHLO ps.ksky.ne.jp")
	by vger.kernel.org with ESMTP id <S275353AbRJARln>;
	Mon, 1 Oct 2001 13:41:43 -0400
To: Alan.Cox@linux.org, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, hng@ps.ksky.ne.jp
Subject: Documentation/filesystems/fat_cvf.txt
X-Mailer: Mew version 1.94.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011002024001A.hng@ps.ksky.ne.jp>
Date: Tue, 02 Oct 2001 02:40:01 +0900
From: Hirokazu Nomoto <hng@ps.ksky.ne.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I made a patch for Documentation/filesystems/fat_cvf.txt.
Its 2.2 version is identical to its 2.4 version.
I don't know this maintainer, so I send you.

Best regards,
===
--- fat_cvf.txt	Mon Mar 26 01:31:56 2001
+++ fat_cvf.txt.new	Tue Oct  2 01:50:21 2001
@@ -112,7 +112,7 @@
   int (*mount_cvf) (struct super_block*sb,char*options);
   int (*unmount_cvf) (struct super_block*sb);
   [...]
-  void (*cvf_zero_cluster) (struct inode*inode,int clusternr);
+  void (*zero_out_cluster) (struct inode*, int clusternr);
 }
 
 This structure defines the capabilities of a CVF module. It must be filled
@@ -161,8 +161,8 @@
       functions. NULL means use the original FAT driver functions instead.
       If you really want "no action", write a function that does nothing and 
       hang it in instead.
-  - cvf_zero_cluster:
-      The cvf_zero_cluster function is called when the fat driver wants to
+  - zero_out_cluster:
+      The zero_out_cluster function is called when the fat driver wants to
       zero out a (new) cluster. This is important for directories (mkdir).
       If it is NULL, the FAT driver defaults to overwriting the whole
       cluster with zeros. Note that clusternr is absolute, not relative
===
Hirokazu Nomoto / JF Project
