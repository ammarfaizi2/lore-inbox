Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132629AbRDKR4q>; Wed, 11 Apr 2001 13:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132673AbRDKR4h>; Wed, 11 Apr 2001 13:56:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:39185 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132629AbRDKR4a>; Wed, 11 Apr 2001 13:56:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: announce: PPSkit patch for Linux 2.4.2 (pre6)
Date: 11 Apr 2001 10:56:01 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9b25rh$rav$1@cesium.transmeta.com>
In-Reply-To: <3AC83FF1.27420.398B86@localhost> <3AD2CE98.28151.46E93A@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3AD2CE98.28151.46E93A@localhost>
By author:    "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
In newsgroup: linux.dev.kernel
>
> Hi,  Cycle Counters,
> 
> Linux currently tries to synchronize TSCs for consistent time in SMP 
> systems. One would not believe what combinations of hardware are tried, 
> especially for precision timing. Here's a short answer to my asking-
> back about a complaint (the kernel is reporting negative time warps).
> 
> As any problem, it can be solved with some overhead, but should it be 
> done?
> 
> Replies to me too, as I'm not subscribed, please.
> 
> > 
> > I have to tell you that I have one 533 MHz Celeron and one 433 MHz
> > Celeron.
> > 

Hi there,

We have talked about assymmetric multiprocessor configurations once or
twice around.  The easy way to deal with them is simply to use
"no-tsc" on the command line (and/or compile your kernel
appropriately.)  One could, at least theoretically, make them usable
in kernel space only (in user space there is no hope, since you can't
know which CPU's TSC you're reading), but these machines seem to be so
rare that hardly anyone technical enough to fix it cares.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
