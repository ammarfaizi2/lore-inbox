Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318945AbSICWAP>; Tue, 3 Sep 2002 18:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318948AbSICWAK>; Tue, 3 Sep 2002 18:00:10 -0400
Received: from [209.249.170.16] ([209.249.170.16]:47371 "EHLO dns1.nvidia.com")
	by vger.kernel.org with ESMTP id <S318945AbSICWAI>;
	Tue, 3 Sep 2002 18:00:08 -0400
From: Terence Ripperda <TRipperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Terence Ripperda <TRipperda@nvidia.com>, linux-kernel@vger.kernel.org
Date: Tue, 3 Sep 2002 17:04:24 -0500
Subject: Re: lockup on Athlon systems, kernel race condition?
Message-ID: <20020903220424.GL2343@hygelac>
References: <3D752DA3.6030000@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D752DA3.6030000@colorfullife.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 11:46:11PM +0200, manfred@colorfullife.com wrote:
> Which compiler to you use, and which kernel? Which additional patches?
> 
> With my 2.4.20-pre4-ac1 kernel, the lock_kernel is at offset +3a, 
> according to your dump it's at +6a.

I'm using gcc 2.95.4 (on debian). The kernel I'm currently using is 2.4.19, with the kdb patch and apic_routing patches applied. Neither of these is required to reproduce the problem, they're just to help debug the problem.

that reminds me. when I originally tried to use the nmi watchdog to break into the debugger when the hang occured, I got the following at bootup:

Sep  3 14:56:49 localhost kernel: activating NMI Watchdog ... done.
Sep  3 14:56:49 localhost kernel: testing NMI watchdog ... CPU#0: NMI appears to be stuck!


> Is it possible to display the cpu registers with kdb? Could you check 
> that the interrupts are enabled?

I don't have things caught in the debugger currently, but I did check the registers at the time. bit 9 of eflags was enabled on both cpus.

Terence
