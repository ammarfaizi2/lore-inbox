Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbTAKFFS>; Sat, 11 Jan 2003 00:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbTAKFFS>; Sat, 11 Jan 2003 00:05:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60888 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267166AbTAKFES>;
	Sat, 11 Jan 2003 00:04:18 -0500
Date: Fri, 10 Jan 2003 21:09:02 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.5x can't find my printer
In-Reply-To: <Pine.LNX.3.96.1030110220420.5655A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.33L2.0301102107420.19983-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Bill Davidsen wrote:

| On Fri, 10 Jan 2003, Randy.Dunlap wrote:
|
| > On Fri, 10 Jan 2003, Bill Davidsen wrote:
| >
| > | The 2.5.5x kernels can't find my printer. 2.4 kernels work fine. dmesg
| > | attached, I'll send config if anyone cares.
| > |
| > | Known problem, new problem, or just some config error? The modules load
| > | but don't find anything.
| > |
| > | lsmod:
| > | Module                  Size  Used by
| > | apm                    15140
| > | parport_pc             33320
| > | parport                34496
| >
| > I'm having trouble seeing the trouble.
|
| The lpr/lpq programs tell me /dev/lp0 "no such device", and catting a file
| to the device fails. It looks as if the driver isn't listening to the lp0
| major,minor or something.
|
| As noted, all works fine in 2.4.{18,20} when booted.
|
| > >From your dmesg:
| >
| > | pnp: the driver 'parport_pc' has been registered
| > | pnp: pnp: match found with the PnP device '00:12' and the driver 'parport_pc'
| > | pnp: the device '00:12' has been activated
| > | parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
| > | parport0: irq 7 detected
| > | parport0: cpp_mux: aa55f00f52ad51(80)
| > | parport0: cpp_daisy: aa5500ff(80)
| > | parport0: assign_addrs: aa5500ff(80)
| > | Module parport cannot be unloaded due to unsafe usage in include/linux/module.h:347
| > | Module parport_pc cannot be unloaded due to unsafe usage in include/linux/module.h:347
| > | parport0: cpp_mux: aa55f00f52ad51(80)
| > | parport0: cpp_daisy: aa5500ff(80)
| > | parport0: assign_addrs: aa5500ff(80)
| >
| > I'm not using PnP.  With 2.5.54, I see:
| > parport0: PC-style at 0x378 [PCSPP(,...)]
| > lp0: using parport0 (polling).
| >
| > Are you expecting to see the "lp0" line also?
|
| I'd settle for a usable device, that isn't happening. I'd believe I need
| to change config, but I'm at a loss for what.

Well, you could try disabling CONFIG_PNP to see if that works
for you.  It does for me, but that doesn't mean much on a different
system with different configs.

-- 
~Randy

