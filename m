Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbSLHENH>; Sat, 7 Dec 2002 23:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbSLHENH>; Sat, 7 Dec 2002 23:13:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26126 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265139AbSLHENG>; Sat, 7 Dec 2002 23:13:06 -0500
Date: Sat, 7 Dec 2002 20:21:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Patrick Mochel <mochel@osdl.org>
cc: Willy Tarreau <willy@w.ods.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       <linux-kernel@vger.kernel.org>, <jgarzik@pobox.com>
Subject: Re: /proc/pci deprecation?
In-Reply-To: <Pine.LNX.4.33.0212072046260.8470-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212072018480.1103-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Dec 2002, Patrick Mochel wrote:
>
> > I don't know if lspci gets that right these days, and the information does
> > exist in /sys, so there is certainly at least the _potential_ of dropping
> > /proc/pci.
>
> It appears to:
>
> [mochel@tina mochel]$ lspci -v | grep -B 2  IRQ | fgrep -v Subsystem
>
> 00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-765 [Viper] USB (rev 07) (prog-if 10 [OHCI])
>         Flags: bus master, medium devsel, latency 16, IRQ 19

Just out of interest, where _does_ it get the information? Does it try to
do its own irq routing (bad!) or does it do it from /proc/bus/pci/devices?

		Linus

