Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269131AbUIZAW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269131AbUIZAW5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269447AbUIZAW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:22:57 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:47806 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269131AbUIZAWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:22:49 -0400
Date: Sun, 26 Sep 2004 01:22:46 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 1/3] Re: [2.6-BK-URL] NTFS: Final sparse related cleanups.
In-Reply-To: <Pine.LNX.4.60.0409260119140.30504@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409260122170.30504@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409260119140.30504@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 1/3 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/26 1.1983.1.1)
   NTFS: Remove silly (__force le32) casts from __ntfs_is_magic{,p}
         helper functions.  Thanks to Al Viro for spotting them.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	2004-09-26 01:17:25 +01:00
+++ b/fs/ntfs/layout.h	2004-09-26 01:17:25 +01:00
@@ -143,13 +143,13 @@
 
 static inline BOOL __ntfs_is_magic(le32 x, NTFS_RECORD_TYPE r)
 {
-	return (x == (__force le32)r);
+	return (x == r);
 }
 #define ntfs_is_magic(x, m)	__ntfs_is_magic(x, magic_##m)
 
 static inline BOOL __ntfs_is_magicp(le32 *p, NTFS_RECORD_TYPE r)
 {
-	return (*p == (__force le32)r);
+	return (*p == r);
 }
 #define ntfs_is_magicp(p, m)	__ntfs_is_magicp(p, magic_##m)
 
