Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318275AbSIBKna>; Mon, 2 Sep 2002 06:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318277AbSIBKna>; Mon, 2 Sep 2002 06:43:30 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23270 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318275AbSIBKn3>; Mon, 2 Sep 2002 06:43:29 -0400
Date: Mon, 2 Sep 2002 12:47:53 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Bjoern Krombholz <bjkro@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops while accessing /proc/stat (2.4.19)
In-Reply-To: <20020829085615.GB3684@wh8043.stw.uni-rostock.de>
Message-ID: <Pine.NEB.4.44.0209021242220.147-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002, Bjoern Krombholz wrote:

>...
> > which binary-only modules (e.g. NVidia) are loaded on your computer? Is
> > the problem reproducible without them ever loaded since the last reboot?
> >
>
> Actually it happened after the decission of not using NVidia drivers any
> longer. I didn't insmod them in this session and at the time of the crash
> I was happy to reach 10 days uptime (the system crashed quite often
> before, every 3 to 7 days, and completely locked, so I had no chance to
> get to know what these crashes were caused by).
>
> So, NVidia wasn't the problem, but maybe VMWare. I shut VMware down a few
> hours before the first Oops occured.

It would be interesting to see whether this appears again without the
VMware module loaded before.

> Bjoern
>
>
> PS:
> One of the `crash|lock types' that happened most often is when the system/pci
> bus is on high load, e.g. copying some big files from one partition to
> another one while watching TV with xawtv (standard bttv driver); or while
> using "transcode" (converting video files) and whatching TV or whatching
> movies. It's always the same that the system locks while reading/writing
> (might be only one of those operations) to the hard disk; the HD LED keeps
> on.
>
> Maybe this is related to VIAs hardware in some way, I don't know but'd
> like to. :)


It might be:
1. a hardware problem
2. a bug in a non-free module
3. a bug in the kernel a non-free module suffers from
4. a bug in the kernel that is not related to non-free modules

If your problem is 1. or 4. there are people who can help you, in the case
of 2. or 3. it's impossible for everyone except the vendor of these moduls
to help you if these are binary-only modules (even in the case 3. where
it's a kernel bug because it's impossible to debug it).


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


