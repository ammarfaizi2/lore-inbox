Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVGZUfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVGZUfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVGZUdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:33:12 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:48808 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261883AbVGZUb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:31:56 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [SOLVED ?] VIA KT400 + Kernel 2.6.12 + IO-APIC + ehci_hcd = IRQ trouble
Date: Tue, 26 Jul 2005 21:39:26 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507261450160.4914-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507261450160.4914-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507262139.27150@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mardi 26 Juillet 2005 20:54, Alan Stern a écrit :
> >
> > ...and then, the system feels happy. I've played around with USB devices
> > of all speeds in all sockets, and there are no "irq 21: nobody cared!"
> > messages anymore...
>
> Not strange at all, since the EHCI controller actually _was_ using IRQ 21!
> The difference is that now Linux knows this.
[...]
> So long as it's working now, that's the important thing.

Yes, but it doesn't tell us why kernels 2.4x felt perfectly happy with the old 
BIOS...

Furthermore, I'm afraid I may have exchanged a problem for a worse one :-(
Besides this USB/IRQ issue, my system was completely stable and had been for 2 
years. Never experienced a system hang (except when I tried early 2.6 kernels 
up to 2.6.8...)

Alas, today it hanged completely 3 times :-(

When I say completely, I mean complete system hang, display frozen, keyboard 
dead (even the Magic SysRQ key doesn't respond), network dead (doen't ping 
back), no visible activity of any kind :-((

...and of course nothing got logged.

This happened 4 times. The 3 first times, I was running with IO-APIC enabled 
and the system was under high disk activity:

1/ 1st time, I was copying the complete contents of a loopback-mounted ISO 
image to a directory. The system hanged.

2/ 2nd time, I tried the same. The system hanged again.

3/ 3rd time, I was generating an ISO fs (mkisofs). The system hanged.

The 4th time, I was running the kernel booted with "noapic". The system was 
doing nothing and had gone to screen saver mode, then to screen off. When I 
moved the mouse nothing happened. I noticed the system had silently died :-(

Now I'm running with IO-APIC enabled, bus USB 2.0 adn ehci completely disabled 
(both in BIOS and modprobe.conf).

The system hasn't hanged again, but I haven't tried to play with on-disk ISO 
filesystems since...

Sigh. I never had any problem with this system for 2 years running kernel 2.4. 
I've had nothing but problems since running kernel 2.6 :-((

(Not to mention that EVMS snapshots don't work anymore in kernel 2.6 and badly 
corrupt filesystems [snapshots origins] spitting tons of :
totor kernel: attempt to access beyond end of device
totor kernel: dm-5: rw=0, want=990604112, limit=2031614
totor kernel: attempt to access beyond end of device
totor kernel: dm-5: rw=0, want=990604112, limit=2031614
...but this is yet another story...
I'm afraid I will end hating kernel 2.6 as much as I hate M$ things... )

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
