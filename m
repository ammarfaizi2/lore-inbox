Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTKLLEE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 06:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTKLLEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 06:04:04 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:55713 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262009AbTKLLD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 06:03:59 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Wed, 12 Nov 2003 22:03:56 +1100
Cc: benh@kernel.crashing.org
Subject: [PATCH] Fix compliation with iBook (750FX) 2.6.0-test9
Message-ID: <20031112110356.GA11929@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This change

http://ppc.bkbits.net:8080/linuxppc-2.5-benh/cset@1.1213?nav=index.html

gave me an error 

Error: unsupported relocation against SPRN_HID2

Google tells me this was hit in 2.4 as well when some changes were made.
Attached patch makes it work for me.

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ppc-reg.h.diff"

===== include/asm-ppc/reg.h 1.8 vs edited =====
--- 1.8/include/asm-ppc/reg.h	Thu Oct 30 14:25:31 2003
+++ edited/include/asm-ppc/reg.h	Wed Nov 12 21:55:26 2003
@@ -177,6 +177,7 @@
 #define HID0_NOPTI	(1<<0)		/* No-op dcbt and dcbst instr. */
 
 #define SPRN_HID1	0x3F1		/* Hardware Implementation Register 1 */
+#define SPRN_HID2	0x3F8		/* Hardware Implementation Register 2 */
 #define HID1_EMCP	(1<<31)		/* 7450 Machine Check Pin Enable */
 #define HID1_PC0	(1<<16)		/* 7450 PLL_CFG[0] */
 #define HID1_PC1	(1<<15)		/* 7450 PLL_CFG[1] */

--UlVJffcvxoiEqYs2--
