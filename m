Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbTBTTcl>; Thu, 20 Feb 2003 14:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTBTTcl>; Thu, 20 Feb 2003 14:32:41 -0500
Received: from node-c-067b.a2000.nl ([62.194.6.123]:36224 "EHLO
	dinkie.pipsworld.sara.nl") by vger.kernel.org with ESMTP
	id <S266809AbTBTTcj>; Thu, 20 Feb 2003 14:32:39 -0500
Date: Thu, 20 Feb 2003 20:42:36 +0100
From: Remco Post <r.post@sara.nl>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux v2.5.62
Message-Id: <20030220204236.03f63b54.r.post@sara.nl>
In-Reply-To: <20030220011339.GB19520@ip68-0-152-218.tc.ph.cox.net>
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com>
	<3E536237.8010502@blue-labs.org>
	<20030219185017.GA6091@gemtek.lt>
	<20030219224627.71a85963.r.post@sara.nl>
	<20030219232344.1b9f4c20.r.post@sara.nl>
	<20030220011339.GB19520@ip68-0-152-218.tc.ph.cox.net>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003 18:13:39 -0700
Tom Rini <trini@kernel.crashing.org> wrote:

> On Wed, Feb 19, 2003 at 11:23:44PM +0100, Remco Post wrote:
> > 
> > On Wed, 19 Feb 2003 22:46:27 +0100
> > Remco Post <r.post@sara.nl> wrote:
> > 
> > > Hi all,
> > >
> > > just to let you all know, The linus 2.5.62 (plain as can be) just booted
> > > on my motorola powerstack II system. No modules, but also, no oops on
> > > boot, like 2.5.59 and allmost every other 2.5 before that....
> > >
> > > -- Remco
> > 
> > and fortunately, I also have some use for booting this kernel:
> > 
> > When the ethernet link goed down on my on-board dec-tulip:
> > 
> > eth1: timeout expired stopping DMA
> > kernel BUG at drivers/net/tulip/de2104x.c:925!
> > Oops: Exception in kernel mode, sig: 4
> > NIP: C0138248 LR: C0138248 SP: C0275E00 REGS: c0275d50 TRAP: 0700
> > Not taintedMSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > TASK = c022f550[0] 'swapper' Last syscall: 120
> > GPR00: C0138248 C0275E00 C022F550 0000002F 00000001 C0275CB8 C0271800 C02B0000
> > GPR08: 0000161F 00000000 00000000 C0275D30 4000C088 00000000 00000000 00000000
> > GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > GPR24: 00000000 00000000 00000002 00001032 C03DD000 00009032 FFFFFFCE C03DD1C0
> > Call trace: [c0138588]  [c002066c]  [c001b85c]  [c0007e80]  [c00061c4]  [c00039
> > Kernel panic: Aiee, killing interrupt handler!
> > In interrupt handler - not syncing
> 
> What does that decode to?
> 

Well it doesn't, of course, relevant addresses close to the ones in the call trace:

c00061c4 T ret_from_except
c0003904 t setup_disp_bat
c0003950 T init_idle_6xx
c0003988 T ppc6xx_idle
c0007bfc T timer_interrupt
c0007e94 T do_gettimeofday
c001b7d4 T do_softirq
c001b8d8 T raise_softirq
c0020560 t run_timer_softirq
c00206c4 T run_local_timers
c0138460 t de21040_media_timer
c0138620 t de_ok_to_advertise


> -- 
> Tom Rini
> http://gate.crashing.org/~trini/

Hope this is about what you're looking for... If not, please let me know...


-- 

Remco
