Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265336AbUATJyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 04:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbUATJyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 04:54:17 -0500
Received: from witte.sonytel.be ([80.88.33.193]:55970 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265336AbUATJyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 04:54:15 -0500
Date: Tue, 20 Jan 2004 10:53:40 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Pavel Machek <pavel@ucw.cz>, ncunningham@users.sourceforge.net,
       Hugang <hugang@soulinfo.com>, ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>
Subject: Re: Help port swsusp to ppc.
In-Reply-To: <1074555531.10595.89.camel@gaston>
Message-ID: <Pine.GSO.4.58.0401201052320.18625@waterleaf.sonytel.be>
References: <20040119105237.62a43f65@localhost>  <1074483354.10595.5.camel@gaston>
 <1074489645.2111.8.camel@laptop-linux>  <1074490463.10595.16.camel@gaston>
  <20040119204551.GB380@elf.ucw.cz> <1074555531.10595.89.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004, Benjamin Herrenschmidt wrote:
> > Well, then what you do is not swsusp.
> >
> > swsusp does assume same kernel during suspend and resume. Doing resume
> > within bootloader (and thus avoiding this) would be completely
> > different design.
>
> Wait... what the hell in swsusp requires this assumption ? It seems to
> me like a completely unnecessary design limitation.

Swsusp saves the data structures from the suspended kernel, so they have to
match the data structures of the resumed kernel, right?

I't s a bit like trying insmod -f on a module compiled for a completely
different kernel version... *bang*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
