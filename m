Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVIZNdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVIZNdv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 09:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVIZNdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 09:33:51 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:53128 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932126AbVIZNdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 09:33:50 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 26 Sep 2005 14:33:47 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 3/4] NTFS: Fix the definition of the CHKD ntfs record magic.
In-Reply-To: <Pine.LNX.4.60.0509261432170.32257@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509261433100.32257@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509261427520.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0509261431270.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0509261432170.32257@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix the definition of the CHKD ntfs record magic.  It had an off by
      two error causing it to be CHKB instead of CHKD.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/layout.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

838bf9675a3d1ede01408aa105357b9ab43faf1b
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -123,7 +123,7 @@ enum {
 	magic_RCRD = const_cpu_to_le32(0x44524352), /* Log record page. */
 
 	/* Found in $LogFile/$DATA.  (May be found in $MFT/$DATA, also?) */
-	magic_CHKD = const_cpu_to_le32(0x424b4843), /* Modified by chkdsk. */
+	magic_CHKD = const_cpu_to_le32(0x444b4843), /* Modified by chkdsk. */
 
 	/* Found in all ntfs record containing records. */
 	magic_BAAD = const_cpu_to_le32(0x44414142), /* Failed multi sector
