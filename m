Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUHWKsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUHWKsD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUHWKq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:46:56 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:40659 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267651AbUHWKcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:32:07 -0400
Date: Mon, 23 Aug 2004 11:31:37 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231131070.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231131200.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130090.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130240.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130380.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130510.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131070.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 11/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/22 1.1814)
   NTFS: Move a NULL check to before the first use of the pointer.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
--- a/fs/ntfs/bitmap.c	2004-08-18 20:50:20 +01:00
+++ b/fs/ntfs/bitmap.c	2004-08-18 20:50:20 +01:00
@@ -54,10 +54,10 @@
 	int pos, len;
 	u8 bit;
 
+	BUG_ON(!vi);
 	ntfs_debug("Entering for i_ino 0x%lx, start_bit 0x%llx, count 0x%llx, "
 			"value %u.", vi->i_ino, (unsigned long long)start_bit,
 			(unsigned long long)cnt, (unsigned int)value);
-	BUG_ON(!vi);
 	BUG_ON(start_bit < 0);
 	BUG_ON(cnt < 0);
 	BUG_ON(value > 1);
