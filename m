Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbULBMpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbULBMpP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 07:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbULBMpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 07:45:15 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:11919 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261598AbULBMpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 07:45:10 -0500
Date: Thu, 2 Dec 2004 13:44:57 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cosa.h ioctl numbers
Message-ID: <20041202124456.GF11992@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The following patch reverts the changes in ioctl() numbers
for COSA WAN card, makink the ioctl numbers the same as in 2.4, and thus
preserving the binary compatibility with user-space utils.

Signed-off-by: Jan "Yenya" Kasprzak <kas@fi.muni.cz>

--- linux-2.6.10-rc2/drivers/net/wan/cosa.h.orig	2004-12-02 13:34:24.142501564 +0100
+++ linux-2.6.10-rc2/drivers/net/wan/cosa.h	2004-12-02 13:35:59.770705004 +0100
@@ -76,10 +76,10 @@
 #define COSAIOSTRT	_IOW('C',0xf1, int)
 
 /* Read the block from the device memory */
-#define COSAIORMEM	_IOWR('C',0xf2, struct cosa_download)
+#define COSAIORMEM	_IOWR('C',0xf2, struct cosa_download *)
 
 /* Write the block to the device memory (i.e. download the microcode) */
-#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download)
+#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download *)
 
 /* Read the device type (one of "srp", "cosa", and "cosa8" for now) */
 #define COSAIORTYPE	_IOR('C',0xf3, char *)

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
