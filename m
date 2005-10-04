Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVJDQqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVJDQqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVJDQqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:46:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:64253 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964857AbVJDQqM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:46:12 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dino@in.ibm.com, Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
In-Reply-To: <Pine.LNX.4.58.0510041227520.17786@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain>
	 <20051004142718.GA3195@elte.hu>  <20051004151635.GA8866@in.ibm.com>
	 <1128442180.4252.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <Pine.LNX.4.58.0510041227520.17786@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 09:46:09 -0700
Message-Id: <1128444369.4252.3.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 12:32 -0400, Steven Rostedt wrote:
> 
> On Tue, 4 Oct 2005, Daniel Walker wrote:
> 
> > On Tue, 2005-10-04 at 20:46 +0530, Dinakar Guniguntala wrote:
> > >
> > > I get a lot of these with -rt7 (One every minute)
> > >
> > > BUG: auditd:3596, possible softlockup detected on CPU#3!
> > >  [<c0144c48>] softlockup_detected+0x39/0x46 (8)
> > >  [<c0144d26>] softlockup_tick+0xd1/0xd3 (20)
> > >  [<c0111252>] smp_apic_timer_ipi_interrupt+0x4d/0x56 (24)
> > >  [<c010396c>] apic_timer_ipi_interrupt+0x1c/0x24 (12)
> > >  [<c0102e7f>] sysenter_past_esp+0x24/0x75 (44)
> >
> 
> Daniel,
> 
> If it works then sure.  That would also show that the offending CPU is not
> taking any normal interrupts (non-ipi).

Could we move that check into update_process_times() , and do the if
statement off user_tick ? Cause otherwise the touch call will have to be
copied to bunch more functions ..

Daniel

