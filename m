Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUHWLAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUHWLAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 07:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUHWK6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:58:09 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:37769 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267730AbUHWKdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:33:23 -0400
Date: Mon, 23 Aug 2004 11:33:18 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 17/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231132500.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231133060.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129530.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130090.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130240.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130380.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231130510.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131070.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131200.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131390.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231131520.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231132080.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231132240.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231132500.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 17/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/08/17 1.1823)
   NTFS: Fix fs/ntfs/debug.c::ntfs_debug_dump_runlist() for the previous
   removal of LCN_EINVAL which was not used in the kernel NTFS driver.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/debug.c b/fs/ntfs/debug.c
--- a/fs/ntfs/debug.c	2004-08-18 20:50:41 +01:00
+++ b/fs/ntfs/debug.c	2004-08-18 20:50:41 +01:00
@@ -155,7 +155,7 @@
 			int index = -lcn - 1;
 
 			if (index > -LCN_ENOENT - 1)
-				index = 4;
+				index = 3;
 			printk(KERN_DEBUG "%-16Lx %s %-16Lx%s\n",
 				(rl + i)->vcn, lcn_str[index],
 				(rl + i)->length, (rl + i)->length ?
