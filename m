Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWDGAak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWDGAak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 20:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWDGAak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 20:30:40 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55303 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932235AbWDGAak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 20:30:40 -0400
Date: Fri, 7 Apr 2006 02:30:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@HansenPartnership.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/mach-voyager/voyager_cat.c: named initializers
Message-ID: <20060407003037.GE7118@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches arch/i386/mach-voyager/voyager_cat.c to using named 
initializers for struct resource.

Besides a fixing compile error in -mm, it makes the code better 
readable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/mach-voyager/voyager_cat.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc1-mm1-voyager/arch/i386/mach-voyager/voyager_cat.c.old	2006-04-07 00:18:01.000000000 +0200
+++ linux-2.6.17-rc1-mm1-voyager/arch/i386/mach-voyager/voyager_cat.c	2006-04-07 00:19:31.000000000 +0200
@@ -106,9 +106,15 @@
 
 /* the I/O port assignments for the VIC and QIC */
 static struct resource vic_res = {
-	"Voyager Interrupt Controller", 0xFC00, 0xFC6F };
+	.name	= "Voyager Interrupt Controller",
+	.start	= 0xFC00,
+	.end	= 0xFC6F 
+};
 static struct resource qic_res = {
-	"Quad Interrupt Controller", 0xFC70, 0xFCFF };
+	.name	= "Quad Interrupt Controller",
+	.start	= 0xFC70,
+	.end	= 0xFCFF 
+};
 
 /* This function is used to pack a data bit stream inside a message.
  * It writes num_bits of the data buffer in msg starting at start_bit.

