Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVJaOmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVJaOmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVJaOmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:42:39 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:58598 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932315AbVJaOmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:42:38 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:42:33 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 17/17] NTFS: Document extended attribute ($EA) NEED_EA flag.
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311441460.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Document extended attribute ($EA) NEED_EA flag.  (Based on libntfs
      patch by Yura Pakhuchiy.)

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    2 ++
 fs/ntfs/layout.h  |    4 +++-
 2 files changed, 5 insertions(+), 1 deletions(-)

applies-to: 27468ef642b1d6e7a8b3c7f7f9a842e5ad92456e
c9c2009a4e915db17f32701d1f0535b400e61b58
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index dea7424..50a7749 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -78,6 +78,8 @@ ToDo/Notes:
 	- $EA attributes can be both resident and non-resident.
 	- Use %z for size_t to fix compilation warnings.  (Andrew Morton)
 	- Fix compilation warnings with gcc-4.0.2 on SUSE 10.0.
+	- Document extended attribute ($EA) NEED_EA flag.  (Based on libntfs
+	  patch by Yura Pakhuchiy.)
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
index 71b25da..f5678d5 100644
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -2374,7 +2374,9 @@ typedef struct {
  * Extended attribute flags (8-bit).
  */
 enum {
-	NEED_EA	= 0x80
+	NEED_EA	= 0x80		/* If set the file to which the EA belongs
+				   cannot be interpreted without understanding
+				   the associates extended attributes. */
 } __attribute__ ((__packed__));
 
 typedef u8 EA_FLAGS;
---
0.99.9
