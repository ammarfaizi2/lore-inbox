Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268483AbUIFTRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268483AbUIFTRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268480AbUIFTQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:16:42 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:45873 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S268483AbUIFTKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:10:20 -0400
Date: Mon, 6 Sep 2004 21:10:18 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: takata@linux-m32r.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] Re: EXPORT_SYMBOL_NOVERS (was: Re: 2.6.9-rc1-mm3)
In-Reply-To: <Pine.LNX.4.53.0409061129260.14053@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0409062110020.8377@anakin>
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903104239.A3077@infradead.org>
 <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com>
 <Pine.GSO.4.58.0409061539270.17329@waterleaf.sonytel.be>
 <Pine.LNX.4.53.0409061129260.14053@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove deprecated EXPORT_SYMBOL_NOVERS() support completely.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc1/include/linux/module.h	2004-07-12 09:48:32.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/include/linux/module.h	2004-09-06 20:47:25.000000000 +0200
@@ -192,10 +192,6 @@

 #endif

-/* We don't mangle the actual symbol anymore, so no need for
- * special casing EXPORT_SYMBOL_NOVERS.  FIXME: Deprecated */
-#define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
-
 struct module_ref
 {
 	local_t count;
@@ -448,7 +444,6 @@
 #else /* !CONFIG_MODULES... */
 #define EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym)
-#define EXPORT_SYMBOL_NOVERS(sym)

 /* Given an address, look for it in the exception tables. */
 static inline const struct exception_table_entry *

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
