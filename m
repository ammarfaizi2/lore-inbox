Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317916AbSGKVpF>; Thu, 11 Jul 2002 17:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317915AbSGKVpE>; Thu, 11 Jul 2002 17:45:04 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:35849
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317918AbSGKVpD>; Thu, 11 Jul 2002 17:45:03 -0400
Date: Thu, 11 Jul 2002 14:44:52 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: James Stevenson <mistral@stev.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ATAPI + cdwriter problem
In-Reply-To: <E17Sldb-0001d4-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10207111431260.20499-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The basics are this for ATAPI.
Look in the PDC driver for the 48-bit operations.
You see a second DMA engine registered at an offset much further into
BAR4.  Until the PRD is generated for "DUAL" engines ATAPI will suck.

This is the kind of detailed information I do not publish.

Now you have to deal with mixed ATA and ATAPI on the same channel and the
driver to deal with such switch modes will explode.

The amount of code need (aka the crappy bloat that works) is what people
bawked (sp) at and why everyone calls my coding "CRAPPY".   I find no need
to spend a lot of time developing an extened API to permit switch back PRD
and DMA engines for the short amount of time I have left.

If somebody wants it they can pay for it.

Also for a lot of people, the can not read.

I have clearly stated that most of the add-on cards do not support ATAPI.
You want ATAPI put it on the mainboard.  You got a cheap crappy mainboard
like VIA which rudely squashes PCI add-on performance tough.  Comupters
are like sports cars, "Speed Costs Money, How Fast Do You Want To Go ?"

As far as alphas are concerned ask Bryce.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Thu, 11 Jul 2002, Alan Cox wrote:

> > You just broke every system that is not x86 wanting to use the pci card.
> 
> I want to find out if Promise stuff fixes the problems people are having. 
> Dealing with a bit of non x86 portability is something to worry about 
> later. Right now both the rc1 and the rc1-ac2 promise IDE suck completely
> for a lot of people. Probably more than own alphas
> 
> Alan

