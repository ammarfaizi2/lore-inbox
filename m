Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264662AbRF3CyI>; Fri, 29 Jun 2001 22:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264663AbRF3Cx6>; Fri, 29 Jun 2001 22:53:58 -0400
Received: from [203.36.158.121] ([203.36.158.121]:14866 "EHLO
	piro.kabuki.sfarc.net") by vger.kernel.org with ESMTP
	id <S264662AbRF3Cxw>; Fri, 29 Jun 2001 22:53:52 -0400
Date: Sat, 30 Jun 2001 12:52:11 +1000
From: Daniel Stone <daniel@sfarc.net>
To: Christoph Zens <czens@coactive.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, chuckw@altaserv.net,
        Aaron Lehmann <aaronl@vitelus.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Vipin Malik <vipin.malik@daniel.com>,
        David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
Message-ID: <20010630125211.C14891@sfarc.net>
Mail-Followup-To: Christoph Zens <czens@coactive.com>,
	Linus Torvalds <torvalds@transmeta.com>, chuckw@altaserv.net,
	Aaron Lehmann <aaronl@vitelus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Vipin Malik <vipin.malik@daniel.com>,
	David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0106281111490.19351-100000@rumba.coactive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0106281111490.19351-100000@rumba.coactive.com>
User-Agent: Mutt/1.3.18i
Organisation: Sadly lacking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2001 at 11:17:15AM -0700, Christoph Zens wrote:
> 
> > Also, in printk's, you waste run-time memory, and you bloat up the need
> > for the log size. Both of which are _technical_ reasons not to do it.
> > 
> > Small is beuatiful.
> 
> I totally agree. If you want to use Linux for a small and low cost
> embedded system, you can't afford loads of RAM and FLASH space.
> Small is the _key_ for those systems.

*For* *those* *systems*.

Until 99% of the Linux machines are Agendas, or whatever, and 1% PC's, as
opposed to the other way around, we should default to displaying basic[1]
info about the driver, unless told to with a "verbose" option or somesuch,
which would make it spew verbose stuff[2]. And then a "debug" option which
would make it spew lots and lots of stuff[3]. All of this specifiable on the
commandline. (Can you currently change the default loglevel on the kernel
commandline?).

I honestly feel that this is the best idea. Just because we do this by
default doesn't mean that the people who make embedded systems can't modify
the kernel, or hell, even just the bootflags, to do what they want.

:) d

[1]: <device name>: <hardware type> <irq, etc>, e.g.:
     eth0: Intel EtherExpress PRO/100, IRQ10, etc
[2]: <driver name>: <version> <maintainer>
     <device name>: <hardware type> <irq, etc>, e.g.:
     eepro100.c: v0.1, Daniel Stone <daniel@sfarc.net>
     eth0: Intel EtherExpress PRO/100, IRQ10, etc
[3]: <driver name>: <version> <maintainer>
     <other random init crap>
     <device name>: <hardware type> <irq, etc>
     <other random crap>, e.g.:
     eepro100.c: v0.1, Daniel Stone <daniel@sfarc.net>
     Loaded with no options, scanning all PCI bus by default.
     eth0: Intel EtherExpress PRO/100, IRQ10, etc
     Intel i82559 OEM card, with <x> bug.
     Enabling lock-up workaround bug, but you should get a Tulip.

-- 
Daniel Stone						     <daniel@sfarc.net>
<Nuke> "can NE1 help me aim nuclear weaponz????? /MSG ME!!"
