Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUKJOlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUKJOlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUKJNpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:45:39 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:27776 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261886AbUKJNom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:44:42 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 3/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRslp-0006Mp-4N@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:44:21 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 3/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/25 1.2026.1.19)
   NTFS: Add fs/ntfs/aops.c to list of providers for ->b_end_io method in
         Documentation/filesystems/Locking.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
--- a/Documentation/filesystems/Locking	2004-11-10 13:44:24 +00:00
+++ b/Documentation/filesystems/Locking	2004-11-10 13:44:24 +00:00
@@ -317,8 +317,8 @@
 locking rules:
 	called from interrupts. In other words, extreme care is needed here.
 bh is locked, but that's all warranties we have here. Currently only RAID1,
-highmem and fs/buffer.c are providing these. Block devices call this method
-upon the IO completion.
+highmem, fs/buffer.c, and fs/ntfs/aops.c are providing these. Block devices
+call this method upon the IO completion.
 
 --------------------------- block_device_operations -----------------------
 prototypes:
