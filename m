Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTICGhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 02:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbTICGhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 02:37:20 -0400
Received: from mail.mediaways.net ([193.189.224.113]:51846 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S263587AbTICGhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 02:37:18 -0400
Subject: Re: Freeze with HPT370 2.4.22-rc2 and dxr3
From: Soeren Sonnenburg <kernel@nn7.de>
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.44.0308311734280.2953-100000@logos.cnet>
References: <Pine.LNX.4.44.0308311734280.2953-100000@logos.cnet>
Content-Type: text/plain
Message-Id: <1062570516.15713.16.camel@localhost>
Mime-Version: 1.0
Date: Wed, 03 Sep 2003 08:29:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-31 at 22:36, Marcelo Tosatti wrote:
> On Sun, 31 Aug 2003, Soeren Sonnenburg wrote:
> 
> > On Sat, 2003-08-30 at 22:25, Marcelo Tosatti wrote:
> > > > When I play a movie through the dxr3 (driver form dxr3.sf.net) it used
> > > > to work just fine for quite a long time.
> > > > However now that I use a software raid (one via ide on asus a7v8x and 2
> > > > hpt370) I can reproducably get the system to freeze when I mplayer -vo
> > > > dxr3 <file_on_sw_raid> after less than 10 minutes.
> > > 
> > > > Then the IDE lid is continuously on until I reset the machine.
> > > 
> > > > I found out that when I copy the file to a ram disk and then play it
> > > > through dxr3 it works just fine (no freeze). This happens even when I
> > > > boot with init=/bin/sh (so no nvidia or other binary only modules).
> > > 
> > > > Any ideas on what to try out ?
> > > 
> > > Does the same happen with 2.4.20 or 2.4.21? (try with no binary modules
> > > please)
> > 
> > Yes, happens with 2.4.21 and no binary modules. Shall I also try out
> > 2.4.20 ? I will if needed and it works with ide >137G / via chipset in
> > udma mode.
> 
> Please try 2.4.20.

Ok, I tried with 2.4.20 again in single user mode. Same freeze.
Numlock was still working... sysrq+t/k etc don't give anything but cause
a freeze such that numlock no longer works also.

One disk is on one HPT370 and one is on one VIA IDE controller. Please
note that when I swap the hpt370 controller with a promise ultra 100 tx2
(pdc 20268) I get a system freeze on raid reconstruction (kernel 2.4.20
to 22) as soon as I turn on DMA on the pdc's... raid reconstructions
works fine with the hpt370s and DMA on though...

Shall I go back even further i.e. to 2.4.19 ? I will happily try out
other stuff if it helps fixing that problem. I thought maybe the dxr3
driver occupies the bus for a too long time ... could setting the pci
latency to <addvaluehere> of <which cards> help ?

Regards,
Soeren.

