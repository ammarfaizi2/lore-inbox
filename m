Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268453AbUIFTJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268453AbUIFTJW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268479AbUIFTJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:09:22 -0400
Received: from nl-ams-slo-l4-01-pip-6.chellonetwork.com ([213.46.243.23]:63555
	"EHLO amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S268453AbUIFTJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:09:09 -0400
Date: Mon, 6 Sep 2004 21:09:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: takata@linux-m32r.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Re: EXPORT_SYMBOL_NOVERS (was: Re: 2.6.9-rc1-mm3)
In-Reply-To: <Pine.LNX.4.53.0409061129260.14053@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0409062105430.8377@anakin>
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903104239.A3077@infradead.org>
 <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com>
 <Pine.GSO.4.58.0409061539270.17329@waterleaf.sonytel.be>
 <Pine.LNX.4.53.0409061129260.14053@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2004, Zwane Mwaikambo wrote:
> On Mon, 6 Sep 2004, Geert Uytterhoeven wrote:
> > On Fri, 3 Sep 2004, Zwane Mwaikambo wrote:
> > > - arch/m32r/kernel/m32r_ksyms, EXPORT_SYMBOL_NOVERS is deprecated, use
> > >   EXPORT_SYMBOL.
> >
> > Hint for the kernel janitors? I've just counted +300 of them...
>
> Thats a good idea, could you get it on the janitor todo list?

No need to bug the janitors, I created a few patches myself:
  1. Convert all in-kernel users of the deprecated EXPORT_SYMBOL_NOVERS() to
     EXPORT_SYMBOL().
  2. Now all users of the deprecated EXPORT_SYMBOL_NOVERS are gone, ctags
     doesn't have to care about it anymore.
  3. Remove deprecated EXPORT_SYMBOL_NOVERS() support from UML.
  4. Remove deprecated EXPORT_SYMBOL_NOVERS() support completely.

The last patch may be delayed until 2.7 because of backwards compatibility
reasons for out-of-tree drivers.

All patches are untested, but Obviously Correct(TM).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
