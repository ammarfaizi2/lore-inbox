Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSKSKQR>; Tue, 19 Nov 2002 05:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264888AbSKSKQR>; Tue, 19 Nov 2002 05:16:17 -0500
Received: from ifup.net ([217.160.130.191]:163 "HELO sit0.ifup.net")
	by vger.kernel.org with SMTP id <S264877AbSKSKQR>;
	Tue, 19 Nov 2002 05:16:17 -0500
Date: Tue, 19 Nov 2002 11:23:38 +0100
From: "Karsten 'soohrt' Desler" <linux-kernel@ml.soohrt.org>
To: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1-ac4 HPT374 doesn't find connected ide drives
Message-ID: <20021119102338.GA24510@sit0.ifup.net>
References: <20021119105955.A23008@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119105955.A23008@pc9391.uni-regensburg.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have the same board, and the controller works fine for me in 2.5.4*, as 
> 2.4-ac doesn't contain xfs suport. I only have one drive attached, but as I 
> remember I first had to configure the (raid) controller' BIOS (Ctrl-H at boot 
> time) (even for just a bunch of disks) before using the drives. But I'm not 
> 100%ly sure.

I've "been in" the controller BIOS a few times, but never configured
anything because I'm using the linux md driver.

> I don't think there's any need for your patch, cause the hpt374 only has two 
> channels, but there are two controllers on that board.

This patch was just a desperate attempt since it wasn't working before.
I reverted the patch right after I sent the mail to the lkml.

> ANother QUestion: Did you ever get the onboard via-rhine NIC working with 
> IO-APIC (both BIOS and kernel) enabled?

No I didn't.
via-rhine.c:v1.10-LK1.1.14  May-3-2002  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth1: VIA VT6102 Rhine-II at 0xcc00, 00:04:61:43:88:d9, IRQ 16.
eth1: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
...
eth1: Transmit timed out, status 0003, PHY status 786d, resetting...
eth1: reset did not complete in 10 ms.
NETDEV WATCHDOG: eth1: transmit timed out
