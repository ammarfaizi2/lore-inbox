Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264029AbUD1Lhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbUD1Lhr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 07:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264752AbUD1Lhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 07:37:47 -0400
Received: from math.ut.ee ([193.40.5.125]:19842 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264029AbUD1Lhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 07:37:46 -0400
Date: Wed, 28 Apr 2004 14:37:36 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: modular vga16fb on PPC32
In-Reply-To: <Pine.GSO.4.58.0404231128120.11983@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.44.0404281432330.20595-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > *** Warning: "vgacon_remap_base" [drivers/video/vga16fb.ko] undefined!
> >
> > Do we need to export vgacon_remap_base?
>
> Yes. It's been a while ago I tried, but vga16fb used to work on the S3 in my
> LongTrail after I initialized that card using the video BIOS emulator.

This patch makes it not complain. Can't test because current 2.6 does
not boot on my PReP Powerstack.

===== arch/ppc/kernel/setup.c 1.53 vs edited =====
--- 1.53/arch/ppc/kernel/setup.c	Thu Feb 19 05:42:24 2004
+++ edited/arch/ppc/kernel/setup.c	Wed Apr 28 14:27:12 2004
@@ -83,6 +83,7 @@

 #ifdef CONFIG_VGA_CONSOLE
 unsigned long vgacon_remap_base;
+EXPORT_SYMBOL(vgacon_remap_base);
 #endif

 struct machdep_calls ppc_md;

-- 
Meelis Roos (mroos@linux.ee)



