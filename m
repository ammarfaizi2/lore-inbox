Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261569AbSJYTtD>; Fri, 25 Oct 2002 15:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbSJYTtD>; Fri, 25 Oct 2002 15:49:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:29056 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261569AbSJYTtC>; Fri, 25 Oct 2002 15:49:02 -0400
Date: Fri, 25 Oct 2002 15:56:25 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Hounschell <markh@compro.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OT]AMD/Intel interrupt latency (jitter) differences?
In-Reply-To: <3DB99E3D.798B9A5F@compro.net>
Message-ID: <Pine.LNX.3.95.1021025155330.3856A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2002, Mark Hounschell wrote:

>  We have a proprietary application that is an emulation of an old real-time os
> (MPX-32). We have a couple of pieces of hardware (pci cards) with soon to be GPL
> drivers that go along with the emulation package and the hardware. We are using
> a 2.4.18 kernel with the O(1) scheduler and a couple of other patches. One of

[SNIPPED....]
Please use the [Enter] key. Lines should have "\n" and not auto-wrap
in your mailer.

If you are measuring the interrupt latency jitter, you
must disconnect your Ethernet wire if you have a Bus Mastering
(read PCI) Ethernet board. You also have to make sure that
no other Bus Masters are able to run during the measurements.

This is because the Bus Masters will keep the CPU(s) off the bus
for variable lengths of time as they transfer variable lengths
of data. This gives you the jitter.

Even though  you may not have any connections to your machine,
M$ on LANs generate much broadcast traffic that your network
software has to read, then drop on the floor.

What this means, frankly, is that if interrupt latency is
in your specification, you can't use any Bus Mastering devices.
It's just that simple.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


