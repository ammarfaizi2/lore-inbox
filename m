Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTIGNKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 09:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTIGNKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 09:10:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49825 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263189AbTIGNKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 09:10:13 -0400
Date: Sun, 7 Sep 2003 15:10:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nagendra_tomar@adaptec.com, Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030907131010.GB18067@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0309032134040.25093-100000@localhost.localdomain> <1062674382.21667.32.camel@dhcp23.swansea.linux.org.uk> <20030905212420.GD220@elf.ucw.cz> <20030906230911.GA12392@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030906230911.GA12392@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > x86 gives you coherency and store ordering (barring errata and special
> > > CPU modes)
> > 
> > Special CPU modes? You mean some special SSE stores?
> 
> Take a look at arch/i386/kernel/cpu/centaur.c, and CONFIG_X86_OOSTORE.
> 
> You can change the memory settings to weakly ordered writes, which
> means that a plain write isn't suitable for spin_unlock.  Presumably
> this mode is faster (though I don't see why, if Intel, AMD et al. can
> manage good memory performance without weak writes).

Wow, seems interesting, how much performance does it buy? [Maybe AMD
and Intel just threw a lot of silicon at the problem and it went
away. Centaur solution might be nicer, through -- spin_unlock is so
uncommon that this seems like nice optimalization.]

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
