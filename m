Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267807AbUI1Ui5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267807AbUI1Ui5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267866AbUI1Ui4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:38:56 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:25057 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267807AbUI1Uij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:38:39 -0400
Date: Tue, 28 Sep 2004 21:38:32 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Re: [2.6-BK-URL] NTFS: Final sparse annotation/fixes.
In-Reply-To: <Pine.LNX.4.60.0409282133290.4614@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409282137410.4614@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409282133290.4614@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RESEND: This is patch 1/4 in the series.  It contains the following 
ChangeSet:

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
--- a/fs/ntfs/layout.h	2004-09-28 21:32:31 +01:00
+++ b/fs/ntfs/layout.h	2004-09-28 21:32:31 +01:00
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
 
