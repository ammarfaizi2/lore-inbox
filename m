Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbULKHjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbULKHjb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 02:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbULKHjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 02:39:31 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:13239 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S261826AbULKHj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 02:39:28 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1102731973.3228.8.camel@localhost.localdomain>
References: <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
	 <1102532625.25841.327.camel@localhost.localdomain>
	 <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
	 <1102543904.25841.356.camel@localhost.localdomain>
	 <20041209093211.GC14516@elte.hu> <20041209131317.GA31573@elte.hu>
	 <1102602829.25841.393.camel@localhost.localdomain>
	 <1102619992.3882.9.camel@localhost.localdomain>
	 <20041209221021.GF14194@elte.hu>
	 <1102659089.3236.11.camel@localhost.localdomain>
	 <20041210111105.GB6855@elte.hu>
	 <1102731973.3228.8.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1102750669.32041.8.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Dec 2004 23:37:49 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 18:26, Steven Rostedt wrote:
> On Fri, 2004-12-10 at 12:11 +0100, Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > Second, my ethernet doesn't work, and it really seems to be some kind
> > > of interrupt trouble.  It sends out ARPs but doesn't see them come
> > > back, and it also doesn't seem to know that it sent them out. I get
> > > the following:
> > > 
> 
> <snip>
> 
> > > I'll hack on it some more.
> > 
> > yeah, please check this - you are the first one to report this issue.
> 
> Hi Ingo,  I found the problem! and I now know why John Cooper didn't
> have this problem too.  I have CONFIG_PCI_MSI defined. I don't know why,
> I must have seen the option a while ago and said to myself "That looks
> cool, lets try it". Since I started with the config file of the vanilla
> kernel with your rt patches, it was still on. 
> 
> Anyways, what is happening is that the io_apic code is mapping irqs to
> vectors, and your code didn't account for it. So here's my patch.

Can't wait to try the patch, I don't have CONFI_PCI_MSI defined in the
configurations I use. I've had problems with a network card (R8169
driver) for a while (I think I reported it), the interrupts were being
ignored. Hopefully the same problem...

-- Fernando


