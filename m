Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbTAKDBn>; Fri, 10 Jan 2003 22:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267132AbTAKDBn>; Fri, 10 Jan 2003 22:01:43 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46091 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267128AbTAKDBl>; Fri, 10 Jan 2003 22:01:41 -0500
Date: Fri, 10 Jan 2003 22:08:00 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.5x can't find my printer
In-Reply-To: <Pine.LNX.4.33L2.0301101702410.19983-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1030110220420.5655A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Randy.Dunlap wrote:

> On Fri, 10 Jan 2003, Bill Davidsen wrote:
> 
> | The 2.5.5x kernels can't find my printer. 2.4 kernels work fine. dmesg
> | attached, I'll send config if anyone cares.
> |
> | Known problem, new problem, or just some config error? The modules load
> | but don't find anything.
> |
> | lsmod:
> | Module                  Size  Used by
> | apm                    15140
> | parport_pc             33320
> | parport                34496
> 
> I'm having trouble seeing the trouble.

The lpr/lpq programs tell me /dev/lp0 "no such device", and catting a file
to the device fails. It looks as if the driver isn't listening to the lp0
major,minor or something.

As noted, all works fine in 2.4.{18,20} when booted.

> >From your dmesg:
> 
> | pnp: the driver 'parport_pc' has been registered
> | pnp: pnp: match found with the PnP device '00:12' and the driver 'parport_pc'
> | pnp: the device '00:12' has been activated
> | parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> | parport0: irq 7 detected
> | parport0: cpp_mux: aa55f00f52ad51(80)
> | parport0: cpp_daisy: aa5500ff(80)
> | parport0: assign_addrs: aa5500ff(80)
> | Module parport cannot be unloaded due to unsafe usage in include/linux/module.h:347
> | Module parport_pc cannot be unloaded due to unsafe usage in include/linux/module.h:347
> | parport0: cpp_mux: aa55f00f52ad51(80)
> | parport0: cpp_daisy: aa5500ff(80)
> | parport0: assign_addrs: aa5500ff(80)
> 
> I'm not using PnP.  With 2.5.54, I see:
> parport0: PC-style at 0x378 [PCSPP(,...)]
> lp0: using parport0 (polling).
> 
> Are you expecting to see the "lp0" line also?

I'd settle for a usable device, that isn't happening. I'd believe I need
to change config, but I'm at a loss for what.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

