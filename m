Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVJDQdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVJDQdZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbVJDQdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:33:25 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:57821 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932455AbVJDQdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:33:24 -0400
Date: Tue, 4 Oct 2005 12:32:45 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Daniel Walker <dwalker@mvista.com>
cc: dino@in.ibm.com, Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <1128442180.4252.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Message-ID: <Pine.LNX.4.58.0510041227520.17786@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> 
 <20051004130009.GB31466@elte.hu>  <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain>
  <20051004142718.GA3195@elte.hu>  <20051004151635.GA8866@in.ibm.com>
 <1128442180.4252.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Oct 2005, Daniel Walker wrote:

> On Tue, 2005-10-04 at 20:46 +0530, Dinakar Guniguntala wrote:
> >
> > I get a lot of these with -rt7 (One every minute)
> >
> > BUG: auditd:3596, possible softlockup detected on CPU#3!
> >  [<c0144c48>] softlockup_detected+0x39/0x46 (8)
> >  [<c0144d26>] softlockup_tick+0xd1/0xd3 (20)
> >  [<c0111252>] smp_apic_timer_ipi_interrupt+0x4d/0x56 (24)
> >  [<c010396c>] apic_timer_ipi_interrupt+0x1c/0x24 (12)
> >  [<c0102e7f>] sysenter_past_esp+0x24/0x75 (44)
>

Daniel,

If it works then sure.  That would also show that the offending CPU is not
taking any normal interrupts (non-ipi).

Ingo, do you get the same on your 8x machine?  Or is this just somthing
strange with Dinakar's machine?

Dinakar, can you try Daniel's patch, and let us know if it works or not?

Thanks,

-- Steve

