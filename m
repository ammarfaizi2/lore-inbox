Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbTAKBHw>; Fri, 10 Jan 2003 20:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266989AbTAKBHw>; Fri, 10 Jan 2003 20:07:52 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18660 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266977AbTAKBHq>;
	Fri, 10 Jan 2003 20:07:46 -0500
Date: Fri, 10 Jan 2003 17:12:25 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.5x can't find my printer
In-Reply-To: <Pine.LNX.4.44.0301101719240.1476-200000@oddball.prodigy.com>
Message-ID: <Pine.LNX.4.33L2.0301101702410.19983-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Bill Davidsen wrote:

| The 2.5.5x kernels can't find my printer. 2.4 kernels work fine. dmesg
| attached, I'll send config if anyone cares.
|
| Known problem, new problem, or just some config error? The modules load
| but don't find anything.
|
| lsmod:
| Module                  Size  Used by
| apm                    15140
| parport_pc             33320
| parport                34496

I'm having trouble seeing the trouble.
>From your dmesg:

| pnp: the driver 'parport_pc' has been registered
| pnp: pnp: match found with the PnP device '00:12' and the driver 'parport_pc'
| pnp: the device '00:12' has been activated
| parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
| parport0: irq 7 detected
| parport0: cpp_mux: aa55f00f52ad51(80)
| parport0: cpp_daisy: aa5500ff(80)
| parport0: assign_addrs: aa5500ff(80)
| Module parport cannot be unloaded due to unsafe usage in include/linux/module.h:347
| Module parport_pc cannot be unloaded due to unsafe usage in include/linux/module.h:347
| parport0: cpp_mux: aa55f00f52ad51(80)
| parport0: cpp_daisy: aa5500ff(80)
| parport0: assign_addrs: aa5500ff(80)

I'm not using PnP.  With 2.5.54, I see:
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).

Are you expecting to see the "lp0" line also?

-- 
~Randy

