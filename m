Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268472AbUIFTQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268472AbUIFTQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268486AbUIFTQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:16:27 -0400
Received: from nl-ams-slo-l4-01-pip-5.chellonetwork.com ([213.46.243.21]:31062
	"EHLO amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S268472AbUIFTJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:09:53 -0400
Date: Mon, 6 Sep 2004 21:09:47 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: takata@linux-m32r.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] Re: EXPORT_SYMBOL_NOVERS (was: Re: 2.6.9-rc1-mm3)
In-Reply-To: <Pine.LNX.4.53.0409061129260.14053@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0409062109290.8377@anakin>
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903104239.A3077@infradead.org>
 <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com>
 <Pine.GSO.4.58.0409061539270.17329@waterleaf.sonytel.be>
 <Pine.LNX.4.53.0409061129260.14053@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now all users of the deprecated EXPORT_SYMBOL_NOVERS are gone, ctags doesn't
have to care about it anymore.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc1/Makefile	2004-08-24 13:33:28.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/Makefile	2004-09-06 18:19:32.000000000 +0200
@@ -1093,7 +1093,7 @@
 quiet_cmd_tags = MAKE   $@
 define cmd_tags
 	rm -f $@; \
-	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
+	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL"`; \
 	$(all-sources) | xargs ctags $$CTAGSF -a
 endef


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
