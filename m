Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbUKLLuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbUKLLuq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 06:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbUKLLuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 06:50:46 -0500
Received: from witte.sonytel.be ([80.88.33.193]:65493 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262510AbUKLLuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 06:50:40 -0500
Date: Fri, 12 Nov 2004 12:50:21 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] remove if !PARTITION_ADVANCED condition in defaults
In-Reply-To: <CB00AF16-344E-11D9-857E-000393ACC76E@mac.com>
Message-ID: <Pine.GSO.4.61.0411121242340.27077@waterleaf.sonytel.be>
References: <200411112302.iABN2Pu01711@apps.cwi.nl>
 <Pine.LNX.4.58.0411111507090.2301@ppc970.osdl.org> <CB00AF16-344E-11D9-857E-000393ACC76E@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2004, Kyle Moffett wrote:
> On Nov 11, 2004, at 18:11, Linus Torvalds wrote:
> > That's really what EMBEDDED means: ask about things that no sane person
> > would leave out. So how about just changing that "if PARTITION_ADVANCED"
> > into "if EMBEDDED" on MSDOS?
> 
> If you make this specific to x86, that _may_ be OK, but I suspect others who
> only have only BSD partitioning schemes may object.

Please do at least that! If a (non-ia32) machine doesn't have USB or FireWire,
it usually doesn't need MS-DOS partitioning. This patch makes it impossible for
people to leave out some stuff (BTW not limited to MS-DOS partitioning) they
don't want. I guess Matt will be happy to add the inverse patch to -tiny...

Andries wrote:
> Many people are being bitten by the fact that if they select
> CONFIG_PARTITION_ADVANCED in order to get some additional support,
> they suddenly lose support for the MSDOS_PARTITION type.

Are you sure Kconfig won't keep the old setting of MSDOS_PARTITION?
Ah IC, this is for people who start from a brand new empty config, willing to
solve the Kernel Quest with the 100000 Kconfig questions(TM) :-)

This looks like yet another fix for yet another PEBKAC problem...  Will (or
perhaps this has been done already as well) we hardcode IDE to yes (on ia32)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
