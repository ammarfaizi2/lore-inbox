Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269457AbRGaUUw>; Tue, 31 Jul 2001 16:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269463AbRGaUUo>; Tue, 31 Jul 2001 16:20:44 -0400
Received: from aboukir-101-1-1-maz.adsl.nerim.net ([62.4.18.26]:44442 "EHLO
	wild-wind.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S269457AbRGaUUf>; Tue, 31 Jul 2001 16:20:35 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Exporting ___raw_readw and friends on Alpha
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc ZYNGIER <mzyngier@freesurf.fr>
Date: 31 Jul 2001 22:20:41 +0200
Message-ID: <wrpn15k97fq.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi all,

I've been trying to use a NE2000 compatible PCMCIA card on my UDB,
using the pcnet_cs driver.

Two symbols were missing from the export list : ___raw_readw and
___raw_writew.

Once these symbols have been added to alpha_ksyms, everything is OK,
and I can enjoy my Multia with 4 ethernet interfaces :-).

Diging through the list archive, I've found the very same patch being
posted by Jan-Benedict Glaw (jbglaw@lug-owl.de) more than a year ago,
for framebuffer purposes.

Is there any reason why this patch hasn't been applied ? It should be
noted that arch/sh is exporting these symbols too.

Thanks for any comment.

        M.

--- /usr/src/linux/arch/alpha/kernel/alpha_ksyms.c	Tue Jul 31 19:32:18 2001
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Tue Jul 31 21:32:04 2001
@@ -71,6 +71,14 @@
 EXPORT_SYMBOL(_writeb);
 EXPORT_SYMBOL(_writew);
 EXPORT_SYMBOL(_writel);
+EXPORT_SYMBOL(___raw_readb); 
+EXPORT_SYMBOL(___raw_readw); 
+EXPORT_SYMBOL(___raw_readl); 
+EXPORT_SYMBOL(___raw_readq); 
+EXPORT_SYMBOL(___raw_writeb); 
+EXPORT_SYMBOL(___raw_writew); 
+EXPORT_SYMBOL(___raw_writel); 
+EXPORT_SYMBOL(___raw_writeq); 
 EXPORT_SYMBOL(_memcpy_fromio);
 EXPORT_SYMBOL(_memcpy_toio);
 EXPORT_SYMBOL(_memset_c_io);

-- 
Places change, faces change. Life is so very strange.
