Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267901AbUI1Uld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267901AbUI1Uld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267866AbUI1UjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:39:18 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:9155 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267856AbUI1Uiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:38:55 -0400
Date: Tue, 28 Sep 2004 21:38:50 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Re: [2.6-BK-URL] NTFS: Final sparse annotation/fixes.
In-Reply-To: <Pine.LNX.4.60.0409282137410.4614@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409282138350.4614@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409282133290.4614@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409282137410.4614@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RESEND: This is patch 2/4 in the series.  It contains the following 
ChangeSet:

<aia21@cantab.net> (04/09/26 1.1988.2.2)
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
--- a/fs/ntfs/logfile.h	2004-09-28 21:32:35 +01:00
+++ b/fs/ntfs/logfile.h	2004-09-28 21:32:35 +01:00
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
