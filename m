Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUKGL2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUKGL2V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 06:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUKGL2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 06:28:21 -0500
Received: from beholder.inittab.de ([195.226.163.101]:9917 "EHLO
	mail1.inittab.de") by vger.kernel.org with ESMTP id S261580AbUKGL2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 06:28:17 -0500
Date: Sun, 7 Nov 2004 12:28:12 +0100
From: Norbert Tretkowski <tretkowski@inittab.de>
To: linux-kernel@vger.kernel.org
Subject: fix for alpha framebuffer compile
Message-ID: <20041107112812.GA1443@rollcage.inittab.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

attached patch adds a line to include/asm-alpha/io.h which was
(accidentally?) removed between 2.6.8.1 and 2.6.9, but is required for
some framebuffer drivers on alpha.

Regards, Norbert

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alpha-framebuffer.dpatch"

--- kernel-source-2.6.9/include/asm-alpha/io.h~ 2004-10-18 23:55:07.000000000 +0200
+++ kernel-source-2.6.9/include/asm-alpha/io.h  2004-11-07 11:42:24.000000000 +0100
@@ -150,6 +150,8 @@
        alpha_mv.mv_##NAME(b, addr);                                    \
 }

+# define __ioremap(a,s) alpha_mv.mv_ioremap((unsigned long)(a),(s))
+
 REMAP1(unsigned int, ioread8, /**/)
 REMAP1(unsigned int, ioread16, /**/)
 REMAP1(unsigned int, ioread32, /**/)

--PEIAKu/WMn1b1Hv9--
