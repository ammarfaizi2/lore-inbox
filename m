Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288149AbSAHQWX>; Tue, 8 Jan 2002 11:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288148AbSAHQWO>; Tue, 8 Jan 2002 11:22:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:35381 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S288149AbSAHQWA>;
	Tue, 8 Jan 2002 11:22:00 -0500
Message-ID: <3C3B1C7F.6428E233@gmx.net>
Date: Tue, 08 Jan 2002 17:21:19 +0100
From: Mike <maneman@gmx.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: lcchang@sis.com.tw, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: SiS900 driver after v.1.07.11 (==Linux 2.4.5) won't allow connect.
In-Reply-To: <3C3B0007.5B1020B2@gmx.net> <3C3B130A.19A579E6@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darn, same problem as before; it gives me "Media Link ON 10mbps half-duplex"
but now atleast dhcpcd doesn't fail.
What's worse: I pinged my nameserver across the street and lost 10% of 19
pings. Dunno if "half-baked-duplex" is what does that...but I'm still forced
to use 2.4.5 for now. :'-(


I wrote:

> Heh, just read about the 2.4.18pre1 sis900 patch, I wonder if that'll be
> what it takes...I'm compiling it now.
> Will reply with results.
> Gtreets, Mike
>
> I wrote:
>
> > Hello,
> >
> > I've got this weird problem, I know the problem is mine 'cuz the latest
> > in 2.4.17 doesn't work either, and I don't think Linus would keep a bad
> > copy of widely-used code in his kernel, right?  ;-)
> > Anyway, the hardware in question is an ECS K7S5A motherboard with a
> > SiS735 chipset and on-board LAN. The only Realtek chip I see on the
> > mainboard is one marked "RTL8201L".
> >
> > WHAT HAPPENS WHEN IT WORKS (flawlessly):
> > With a modular kernel 2.4.5 I simply 'modprobe sis900' and presto...I
> > follow that with 'dhcpcd' and I'm on the 'net. Here's what syslog says:
> > SiS900.c: v.1.07.11 4/10/2001
> > PCI: Assigned IRQ3 for device 00:03.0
> > eth0: Unknown PHY transceiver found at address 1 <<<-------!!!!
> > eth0: Using transceiver found at address1 as default
> > eth0: SiS900 PCI Fast Ethernet at 0xdc00, IRQ3, <MAC-address here>
> > logger: (dhcpcd) IP changed to <IP-address here>
> >
> > WHAT HAPPENS WHEN IT FAILS:
> > With a modular kernel 2.4.6 or 2.4.13 or 2.4.17 I 'modprobe sis900' and
> > get:
> > SiS900.c: v.1.08.01 9/25/2001 <<<--------Some kernels differ accordingly
> > in version and date. All >=1.08 fail.
> > PCI: Assigned IRQ3 for device 00:03.0
> > eth0: Realtek RTL8201 PHY transceiver found at address 1
> > eth0: Using transceiver found at address1 as default
> > eth0: SiS900 PCI Fast Ethernet at 0xdc00, IRQ3, <MAC-address here>
> >
> > I follow this with 'dhcpcd' and syslog says:
> > Media Link ON 10mbps half-duplex
> > ....And my prompt hangs there until dhcpcd time-outs after 3 or 5
> > minutes...
> >
> > What am I missing here? Should I add some stuff to the 'modprobe sis900'
> > string now??
> > And yeah, I've read all the relevant (?!) docs in the kernel sources.
> > Also, linux-2.4.17/Documentation/networking/sis900.txt only goes up to
> > v.1.07, shouldn't it reflect the current revision (1.08.01)??
> >
> > I hope it's possible to just copy the old 2.4.5 source into the 2.4.17
> > dir (as you can tell: I've never done this) and compile.
> > TIA for any help and greets!
> > -Mike

