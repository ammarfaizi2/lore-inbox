Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKOAHR>; Tue, 14 Nov 2000 19:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129873AbQKOAHH>; Tue, 14 Nov 2000 19:07:07 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:34829 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129045AbQKOAHC>; Tue, 14 Nov 2000 19:07:02 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200011142337.AAA18765@green.mif.pg.gda.pl>
Subject: Re: [PATCH] CONFIG_EISA note in Documentation/Configure.help
To: aeb@veritas.com
Date: Wed, 15 Nov 2000 00:37:09 +0100 (CET)
Cc: elenstev@mesatop.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Nov 13, 2000 at 05:07:22PM -0700, Steven Cole wrote:
> > +EISA support
> > +CONFIG_EISA
> > +  The Extended Industry Standard Architecture (EISA) bus was
> 
> (i) I am a bit unhappy about adding configuration options
> like this. It regularly happens that I want to compile some kernel

You are unhappy, I am happy.
Now I can disable some drivers, which I am sure I don't need setting a single
option instead of few.
Also it anables better separation of architecture specyfic drivers:
do you know of Amiga with EISA ?  Does my mips support it ?

# grep drivers/net/Config.in arch/*/config.in
arch/alpha/config.in:    source drivers/net/Config.in
arch/arm/config.in:      source drivers/net/Config.in
arch/i386/config.in:      source drivers/net/Config.in
arch/ia64/config.in:    source drivers/net/Config.in
arch/mips/config.in:     source drivers/net/Config.in
arch/mips64/config.in:      source drivers/net/Config.in
arch/ppc/config.in:    source drivers/net/Config.in
arch/sh/config.in:      source drivers/net/Config.in

> for some machine and have to grep the source and look at the config
> files how to enable something. A machine with RTL-8139? Let me see,
> that requires CONFIG_EXPERIMENTAL. (Not today, but until recently.)
> How do I get FireWire? Also requires CONFIG_EXPERIMENTAL. This
> CONFIG_EXPERIMENTAL is a very strange option. I know about my hardware,
> perhaps, but there is no reason to suppose that I know about the
> progress in development of Linux drivers for this hardware.
> Instead of having a global CONFIG_EXPERIMENTAL we should have
> a warning at each place that the driver is alpha.

Look at CML2 project. It supports a function showing all possible options,
if you choose... But it is project for Linux 2.5.

> If one does "make xconfig" then one sees a greyed out area,
> and the sometimes nontrivial puzzle is how to enable it.
> But with "make menuconfig" one never even sees the option,

But in "make config" you see much more than you want...

> (ii) In particular about this CONFIG_EISA and the given explanation.
> I have a computer, yes, several. But do I know whether it has
> an EISA bus? A week ago I hardly knew what EISA was, and would have
> been unable to answer. Today I know the answer for a handful of them
> but have not yet investigated the others.

OK. I tried to build an universal kernel, which supports every hardware &
software kernel drivers I ever needed on i386. It was much too big to
boot... (6 MB compressed)

> Now, if this knowledge was of major importance for the kernel
> then perhaps I had to learn about such details.
> However, CONFIG_EISA is almost completely superfluous, is not
> required at compile time, can easily be tested at run time,
> in other words adding such an option is a very stupid thing to do.

If you have too much memory, you can always choose CONFIG_EISA=y by default.
 
> [Steven, you understand that I would have written under CONFIG_EISA:
> say Y here - there is never any reason to say N, unless there exists
> hardware where the canonical probing hangs the machine.]
> 
> The number of configuration options should be minimized.
> That is good for the user - fewer questions to answer.

Note, that "number of configuration options should be minimized"
and "fewer questions to answer" are not equivalent.

BTW,  CONFIG_MCA needs some cleaning, also.

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
