Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279814AbRKRPOq>; Sun, 18 Nov 2001 10:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279838AbRKRPOh>; Sun, 18 Nov 2001 10:14:37 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:15047 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S279814AbRKRPOV>; Sun, 18 Nov 2001 10:14:21 -0500
Date: Sun, 18 Nov 2001 17:22:23 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] moving F0 0F bug check to bugs.h
In-Reply-To: <Pine.LNX.4.30.0111181541040.29315-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0111181709580.16977-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Dave Jones wrote:

> - (unmaintained?) SGI visws support.
> - bootmem allocator.
> - CPU identification.
> - CPU feature enabling/disabling.
> - CPU errata workarounds.
>
> Whilst you get to know your way around the 3000 or so lines after hacking
> there a few times, it's constantly growing with each new CPU we support.
> I think it's going to come to a point where this has to be split up to
> some extent to keep it maintainable.

Indeed the whole setup.c is a bit confusing, a cpusetup.c file or somesuch
would make things a bit simpler with maybe an exported function to setup.c
in the nature of cpu_detect(...). In your 2.5 todo, are you going
to move the errata/bugs to the same cpusetup file or a seperate one? Cause
now that i look at it, we got errata (e.g. AMD T13) in setup.c f00f etc,
then popad and friends in bugs.h.

Thanks,
	Zwane Mwaikambo




