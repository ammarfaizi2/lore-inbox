Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbTBCWAS>; Mon, 3 Feb 2003 17:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTBCWAS>; Mon, 3 Feb 2003 17:00:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:58776 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266228AbTBCWAR>; Mon, 3 Feb 2003 17:00:17 -0500
Date: Mon, 3 Feb 2003 17:12:50 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Cameron Goble <cgoble@salud.unm.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: SIS900 module detects two transceivers, picks the wrong one
In-Reply-To: <se3e7fca.052@salud.unm.edu>
Message-ID: <Pine.LNX.3.95.1030203170639.7386A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2003, Cameron Goble wrote:

> Hello,
> 
> I am having trouble with the SIS900 driver module v1.08.04. The module
> installs correctly and does not return an error, but ... well... 
> 
> Perhaps dmesg will explain better:
> 
> eth0: AMD79C901 HomePNA PHY transceiver found at address 2.
> eth0: AMD79C901 10BASE-T PHY transceiver found at address 3.
> eth0: using transceiver found at address 2 as default
> eth0: SiS 900 PCI Fast Ethernet at 0xec400, IRQ 11, 00:30:67:09:53:81.
> 
> So the network interface is a multi-function device, built onto the
> motherboard. The driver picks the HomePNA transceiver, but I want to use
> the 10BASE-T transceiver. Is there an option I can pass, or some code I
> can edit that force the driver to pick the 10BASE-T transceiver at
> address 3?
> 

The HomePNA protocol usually uses the exact same kind of wire at
10BASE-T. It's just wired differently. I don't think you have two
such connectors on your board.

This looks as though your wire is just connected backwards, i.e.,
you have a reversed patch-cord.

Are you connected to a Hub? Does the LED on the hub show that
the wire is connected properly an does the LED on/near the connector on
your PC show that its connected correctly also?

If you really do have to such connectors, just use eth1 instead of
eth0, i.e., `ifconfig eth1 ip-address ...`

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


