Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTIAIf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 04:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTIAIf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 04:35:28 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:28159 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263561AbTIAIfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 04:35:20 -0400
Date: Mon, 1 Sep 2003 10:34:47 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <20030901055804.GG748@mail.jlokier.co.uk>
Message-ID: <Pine.GSO.4.21.0309011027310.5048-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003, Jamie Lokier wrote:
> Geert Uytterhoeven wrote:
> > Are you also interested in m68k? ;-)
> > 
> > cassandra:/tmp# time ./test
> > Test separation: 4096 bytes: FAIL - store buffer not coherent
> 
> Especially!  I hadn't expected to see any machine that would print
> "store buffer not coherent".  It means that if there's an L1 cache, it
> is coherent, but any store-then-load bypass in the CPU pipeline is
> using the virtual address with no rollback after MMU translation.
> 
> I had thought it would only be the case with chips using an external
> MMU, but now that I think about it, the older simpler chips aren't
> going to bother with things like pipeline rollback wherever they can
> get away without it!

As you probably know the 68020 had an external MMU (68551, or Sun-3 or Apollo
MMU). Probably Motorola didn't bother to change the behavior when the MMU got
integrated in later generations (68030 and up).

BTW, probably you want us to run your test program on other m68k boxes? Mine
got a 68040, that leaves us with:
  - 68020+68551
  - 68020+Sun-3 MMU
  - 68030
  - 68060

For linux-m68k: You can find the test program source in Jamie's original
posting on lkml. For your convenience, I put a binary for m68k at
http://home.tvd.be/cr26864/Linux/m68k/jamie_test.gz. Just tell us the
program's output and give us a copy of your /proc/cpuinfo. Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

