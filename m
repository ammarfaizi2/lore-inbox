Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbUKJOpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbUKJOpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUKJNpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:45:20 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:47575 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261843AbUKJNoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:44:32 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 1/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRslg-0006MK-O7@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:44:12 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 1/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/20 1.2000.1.12)
   NTFS: Fix two typos in Documentation/filesystems/ntfs.txt.
   
   Thanks to Richard Russon for pointing them out.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2004-11-10 13:44:16 +00:00
+++ b/Documentation/filesystems/ntfs.txt	2004-11-10 13:44:16 +00:00
@@ -258,10 +258,10 @@
 $ ./ldminfo --dump /dev/hda
 
 This would dump the LDM database found on /dev/hda which describes all of your
-dinamic disks and all the volumes on them.  At the bottom you will see the
+dynamic disks and all the volumes on them.  At the bottom you will see the
 VOLUME DEFINITIONS section which is all you really need.  You may need to look
 further above to determine which of the disks in the volume definitions is
-which device in Linux.  Hint: Run ldminfo on each of your dinamic disks and
+which device in Linux.  Hint: Run ldminfo on each of your dynamic disks and
 look at the Disk Id close to the top of the output for each (the PRIVATE HEADER
 section).  You can then find these Disk Ids in the VBLK DATABASE section in the
 <Disk> components where you will get the LDM Name for the disk that is found in
