Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVJDSFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVJDSFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVJDSFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:05:54 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:18605 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964889AbVJDSFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:05:53 -0400
Date: Tue, 4 Oct 2005 23:41:25 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051004181125.GB5072@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> <20051004130009.GB31466@elte.hu> <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain> <20051004142718.GA3195@elte.hu> <20051004151635.GA8866@in.ibm.com> <1128442180.4252.0.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20051004175842.GA5072@in.ibm.com> <1128448471.4252.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128448471.4252.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 10:54:30AM -0700, Daniel Walker wrote:
> On Tue, 2005-10-04 at 23:28 +0530, Dinakar Guniguntala wrote:
> 
> > Nope doesnt help. I booted with this code change and I get the
> > same message. 
> > 
> > I saw that the code change is in #ifdef CONFIG_HIGH_RES_TIMERS.
> > I have already disabled CONFIG_HIGH_RES_TIMERS as Thomas Gleixner 
> > suggested
> 
> Which code is #ifdef'd ?

Your code was in function smp_apic_timer_ipi_interrupt (right?) that
is under CONFIG_HIGH_RES_TIMERS which was disabled.

> 
> Is there any diversity in these messages , or is it always the same? Is
> the CPU# ever different?
> 

Sorry I should have put this up before.


BUG: auditd:3587, possible softlockup detected on CPU#2!
 [<c0144448>] softlockup_detected+0x39/0x46 (8)
 [<c0144526>] softlockup_tick+0xd1/0xd3 (20)
 [<c01112c7>] smp_apic_timer_interrupt+0xc0/0xcc (24)
 [<c010396c>] apic_timer_interrupt+0x1c/0x24 (24)
 [<c0102e8a>] sysenter_past_esp+0x2f/0x75 (44)
BUG: auditd:3587, possible softlockup detected on CPU#3!
 [<c0144448>] softlockup_detected+0x39/0x46 (8)
 [<c0144526>] softlockup_tick+0xd1/0xd3 (20)
 [<c01112c7>] smp_apic_timer_interrupt+0xc0/0xcc (24)
 [<c010396c>] apic_timer_interrupt+0x1c/0x24 (24)
BUG: auditd:3587, possible softlockup detected on CPU#2!
 [<c0144448>] softlockup_detected+0x39/0x46 (8)
 [<c0144526>] softlockup_tick+0xd1/0xd3 (20)
 [<c01112c7>] smp_apic_timer_interrupt+0xc0/0xcc (24)
 [<c010396c>] apic_timer_interrupt+0x1c/0x24 (24)
BUG: auditd:3587, possible softlockup detected on CPU#3!
 [<c0144448>] softlockup_detected+0x39/0x46 (8)
 [<c0144526>] softlockup_tick+0xd1/0xd3 (20)
 [<c01112c7>] smp_apic_timer_interrupt+0xc0/0xcc (24)
 [<c010396c>] apic_timer_interrupt+0x1c/0x24 (24)
BUG: auditd:3587, possible softlockup detected on CPU#2!
 [<c0144448>] softlockup_detected+0x39/0x46 (8)
 [<c0144526>] softlockup_tick+0xd1/0xd3 (20)
 [<c01112c7>] smp_apic_timer_interrupt+0xc0/0xcc (24)
 [<c010396c>] apic_timer_interrupt+0x1c/0x24 (24)
BUG: auditd:3587, possible softlockup detected on CPU#3!
 [<c0144448>] softlockup_detected+0x39/0x46 (8)
 [<c0144526>] softlockup_tick+0xd1/0xd3 (20)
 [<c01112c7>] smp_apic_timer_interrupt+0xc0/0xcc (24)
 [<c010396c>] apic_timer_interrupt+0x1c/0x24 (24)


	-Dinakar
