Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269447AbUIZAZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269447AbUIZAZj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269452AbUIZAZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:25:38 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:33154 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269447AbUIZAXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:23:21 -0400
Date: Sun, 26 Sep 2004 01:23:06 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 2/3] Re: [2.6-BK-URL] NTFS: Final sparse related cleanups.
In-Reply-To: <Pine.LNX.4.60.0409260122170.30504@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409260122490.30504@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409260119140.30504@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409260122170.30504@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 2/3 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/26 1.1990)
   NTFS: Convert final enum (fs/ntfs/logfile.h) to define to silence last
         bitwise sparse warning.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/logfile.h b/fs/ntfs/logfile.h
--- a/fs/ntfs/logfile.h	2004-09-26 01:17:28 +01:00
+++ b/fs/ntfs/logfile.h	2004-09-26 01:17:28 +01:00
@@ -111,10 +111,9 @@
  * These are the so far known RESTART_AREA_* flags (16-bit) which contain
  * information about the log file in which they are present.
  */
-typedef enum {
-	RESTART_VOLUME_IS_CLEAN	= const_cpu_to_le16(0x0002),
-	REST_AREA_SPACE_FILLER	= 0xffff	/* Just to make flags 16-bit. */
-} __attribute__ ((__packed__)) RESTART_AREA_FLAGS;
+#define RESTART_VOLUME_IS_CLEAN	const_cpu_to_le16(0x0002)
+
+typedef le16 RESTART_AREA_FLAGS;
 
 /*
  * Log file restart area record.  The offset of this record is found by adding
