Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSFRQyi>; Tue, 18 Jun 2002 12:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317491AbSFRQyh>; Tue, 18 Jun 2002 12:54:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:641 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317489AbSFRQyg>; Tue, 18 Jun 2002 12:54:36 -0400
Date: Tue, 18 Jun 2002 12:56:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: DevilKin <devilkin-lkml@blindguardian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: VMM - freeing up swap space
In-Reply-To: <200206181832.55655.devilkin-lkml@blindguardian.org>
Message-ID: <Pine.LNX.3.95.1020618125355.5056A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, DevilKin wrote:

> On Tuesday 18 June 2002 17:10, Richard B. Johnson wrote:
> > On Tue, 18 Jun 2002, Gregory Giguashvili wrote:
> > > Hello,
> > >
> > > Running an application allocating huge amounts of memory would push some
> > > data from RAM to swap area. After the application terminates, swap area
> > > is usually still occupied.
> > >
> > > Is there any way to clean up the swap area by pushing the data back to
> > > RAM?
> > >
> > > Thanks in advance
> > > Giga
> >
> > Sure. Execute `swapoff -a`, followed by `swapon -a`. This is no joke.
> 
> Hmm. Now if you happen to get out of memory during the swapoff part, you'll 
> get the OO killer on your tail? Or will the system just go freeze solid?
> 
> Just a small question.

I think `swapoff -a` will just fail to remove the swap device/file(s) if
it doesn't have the memory. I've done this with 16 Mb of RAM in the
'good-old-days', where VM was swap.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

