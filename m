Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbUKJOuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbUKJOuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUKJOsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:48:08 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:10626 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261917AbUKJNpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:35 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 14/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmX-0006QB-5l@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:05 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 14/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/01 1.2026.1.44)
   NTFS: Add MODULE_VERSION() to fs/ntfs/super.c.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-11-10 13:45:08 +00:00
+++ b/fs/ntfs/super.c	2004-11-10 13:45:08 +00:00
@@ -2754,6 +2754,7 @@
 
 MODULE_AUTHOR("Anton Altaparmakov <aia21@cantab.net>");
 MODULE_DESCRIPTION("NTFS 1.2/3.x driver - Copyright (c) 2001-2004 Anton Altaparmakov");
+MODULE_VERSION(NTFS_VERSION);
 MODULE_LICENSE("GPL");
 #ifdef DEBUG
 module_param(debug_msgs, bool, 0);
