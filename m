Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbULBTYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbULBTYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbULBTYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:24:17 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23936
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261732AbULBTYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:24:12 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
In-Reply-To: <20041202112208.34150647.akpm@osdl.org>
References: <20041201104820.1.patchmail@tglx>
	 <20041201211638.GB4530@dualathlon.random>
	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>
	 <20041202033619.GA32635@dualathlon.random>
	 <1101985759.13353.102.camel@tglx.tec.linutronix.de>
	 <1101995280.13353.124.camel@tglx.tec.linutronix.de>
	 <20041202164725.GB32635@dualathlon.random>
	 <20041202085518.58e0e8eb.akpm@osdl.org>
	 <20041202180823.GD32635@dualathlon.random>
	 <1102013716.13353.226.camel@tglx.tec.linutronix.de>
	 <20041202110729.57deaf02.akpm@osdl.org>
	 <1102014493.13353.239.camel@tglx.tec.linutronix.de>
	 <20041202112208.34150647.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 20:24:10 +0100
Message-Id: <1102015450.13353.245.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 11:22 -0800, Andrew Morton wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Thu, 2004-12-02 at 11:07 -0800, Andrew Morton wrote:
> > > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > FYI, I tried with 2.6 UP and PREEMPT=n. The result is more horrible. The
> > > > box just gets stuck in an endless swap in/swap out and does not respond
> > > > to anything else than SysRq-T and the reset button.
> > > 
> > > There's a patch in -mm which causes the oom-killer to be invoked each time
> > > you hit sysrq-F, which sounds like a fine idea to me.
> > 
> > Can you please explain, how I can hit sysrq-F when I can't log into the
> > remote machine ?
> > 
> 
> umm, in the same way you're using "SysRq-T and the reset button"?
> 
> You can issue sysrq commands over serial consoles too.

I know, but the console and the reset button are 150km away. When I dial
into the machine or try to connect via the network, I cannot connect
with the current kernels. Neither 2.4, because the fork fails, nor 2.6
because oom killed sshd. So I cannot send anything except a service man,
who drives 150km to hit sysrq-F or the reset button.

If this happens the kernel just should make sure to make the machine
accessible and let me repair the problem. Nothing else.

tglx


