Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268480AbUIFTRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268480AbUIFTRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268486AbUIFTQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:16:36 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:56912 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S268480AbUIFTKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:10:03 -0400
Date: Mon, 6 Sep 2004 21:10:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: takata@linux-m32r.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] Re: EXPORT_SYMBOL_NOVERS (was: Re: 2.6.9-rc1-mm3)
In-Reply-To: <Pine.LNX.4.53.0409061129260.14053@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0409062109490.8377@anakin>
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903104239.A3077@infradead.org>
 <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com>
 <Pine.GSO.4.58.0409061539270.17329@waterleaf.sonytel.be>
 <Pine.LNX.4.53.0409061129260.14053@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove deprecated EXPORT_SYMBOL_NOVERS() support from UML.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc1/arch/um/kernel/user_syms.c	2004-04-27 20:36:40.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/um/kernel/user_syms.c	2004-09-06 20:47:15.000000000 +0200
@@ -31,13 +31,11 @@

 #define __EXPORT_SYMBOL(sym,str)   error config_must_be_included_before_module
 #define EXPORT_SYMBOL(var)	   error config_must_be_included_before_module
-#define EXPORT_SYMBOL_NOVERS(var)  error config_must_be_included_before_module

 #elif !defined(UML_CONFIG_MODULES)

 #define __EXPORT_SYMBOL(sym,str)
 #define EXPORT_SYMBOL(var)
-#define EXPORT_SYMBOL_NOVERS(var)

 #else

@@ -54,8 +52,6 @@
 #define EXPORT_SYMBOL(var)  __EXPORT_SYMBOL(var, __MODULE_STRING(__VERSIONED_SYMBOL(var)))
 #endif

-#define EXPORT_SYMBOL_NOVERS(var)  __EXPORT_SYMBOL(var, __MODULE_STRING(var))
-
 #endif

 EXPORT_SYMBOL(__errno_location);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
