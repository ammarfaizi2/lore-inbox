Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268161AbTCFR1h>; Thu, 6 Mar 2003 12:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268163AbTCFR1g>; Thu, 6 Mar 2003 12:27:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25607 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268161AbTCFR1f>; Thu, 6 Mar 2003 12:27:35 -0500
Date: Thu, 6 Mar 2003 09:35:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       <rml@tech9.net>, <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <1046975159.17718.89.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303060931300.7206-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Mar 2003, Alan Cox wrote:
> 
> Not all X servers do that. X is not special in any way. Its just a
> daemon. It has the same timing properties as many other daemons doing
> time critical operations for many clients

I really think that this is the most important observation about the 
behaviour. X really isn't doing anything that other deamons don't do. It 
so happens that what X is doing is a lot more complex than most deamons 
do, so it's fairly easy to trigger X into using a fair amount of CPU time, 
but that only makes the breakdown case so much easier to see.

In all honesty, though, it's also obviously the case that the breakdown
case in the case of X is _really_ visible in a very very concrete way,
since X is the _only_ thing really "visible" unless you have Direct
Rendering clients. So even if the problem were to happen with another
deamon, it probably wouldn't stand out quite as badly. So in that sense X 
ends up having some special characteristics - "visibility".

		Linus

