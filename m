Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267161AbUBMS1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267154AbUBMS1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:27:01 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:657 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267161AbUBMSZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:25:56 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Erik Mouw <erik@harddisk-recovery.nl>
Subject: Re: (was Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three())
Date: Fri, 13 Feb 2004 19:30:56 +0100
User-Agent: KMail/1.5.3
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <200402122106.41947.bzolnier@elka.pw.edu.pl> <200402131823.53939.bzolnier@elka.pw.edu.pl> <20040213174418.GA31694@bitwizard.nl>
In-Reply-To: <20040213174418.GA31694@bitwizard.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402131930.56015.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 of February 2004 18:44, Erik Mouw wrote:
> On Fri, Feb 13, 2004 at 06:23:53PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Great, but I wonder why cable bits are set incorrectly.
> > Probably it's a BIOS bug, maybe BIOS update will help?
>
> I think there is something wrong in the cable detection code. I've
> tried chasing the bug a couple of weeks ago, but got distracted by
> other work. On an AMD-768 based motherboard disks run in UDMA5 without
> problem using linux-2.4.20, but on 2.4.24 (or anything with the new IDE
> code), I can't get any further than UDMA2. At first glance it looks
> like the 80-pin bits in the chipset registers aren't set. When I
> manually force them, the driver has no problem running the disks in
> UDMA5.
>
> So far I've seen this behaviour with the following chipset:
>
>   Bus  0, device   7, function  1:
>     IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 4).
>       Master Capable.  Latency=32.
>       I/O at 0xd800 [0xd80f].

It might be also chipset specific bug:
2.4.20 - amd74xx.c driver by Andre Hedrick
2.4.21-2.4.24 - new amd74xx.c driver by Vojtech Pavlik

Please try narrow it down.

> But rumours are that even on Intel ICH2 it goes wrong (haven't
> confirmed this myself).

This tells us nothing about the problem.

