Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUHOUSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUHOUSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUHOUSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:18:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25801 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266880AbUHOUPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:15:22 -0400
Date: Sun, 15 Aug 2004 22:15:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
       Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com,
       "David S. Miller" <davem@redhat.com>, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, sparclinux@vger.kernel.org,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
Subject: Re: architectures with their own "config PCMCIA"
Message-ID: <20040815201509.GQ1387@fs.tum.de>
References: <20040807181051.A19250@infradead.org> <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de> <20040811201725.GJ26174@fs.tum.de> <20040811214032.GC7207@mars.ravnborg.org> <20040812001003.GV26174@fs.tum.de> <Pine.LNX.4.58.0408121056270.20634@scrub.home> <20040814204711.GD1387@fs.tum.de> <Pine.LNX.4.61.0408151928490.12687@scrub.home> <Pine.GSO.4.58.0408152136400.9281@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0408152136400.9281@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 09:37:30PM +0200, Geert Uytterhoeven wrote:
> On Sun, 15 Aug 2004, Roman Zippel wrote:
> > On Sat, 14 Aug 2004, Adrian Bunk wrote:
> > > > This is less a problem, as here it's clear that you want a boolean result,
> > > > but something like "FOO=n" is really a string compare and FOO could be of
> > > > any type (that 99% of all symbols are boolean/tristate symbols doesn't
> > > > really help).
> > >
> > > Wouldn't it be better to require a string or hex to always be quoted
> > > like "somestring"?
> >
> > What about normal numbers? I don't think requiring quotes everywhere for
> > this is a good idea.
> 
> And numbers (both decimal and hex) can easily be distinguished from y, n, and m
> anyway.

Sounds reasonable.

This leaves strings.

Could you point me to one single place in the kernel where a string 
constant is used in the dependencies of another symbol?
If it's that rare, requiring quotes shouuldn't be that much of a burden.

I see six places where quotes are used for y/n/m, but they should be 
trivial to fix.

> Gr{oetje,eeting}s,
> 
> 						Geert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

