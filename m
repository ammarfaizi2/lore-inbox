Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVAKJax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVAKJax (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbVAKJax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:30:53 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:22930
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262638AbVAKJas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:30:48 -0500
Subject: Re: User space out of memory approach
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Edjard Souza Mota <edjard@gmail.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <4d6522b905011101202918f361@mail.gmail.com>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <4d6522b905011101202918f361@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 10:30:46 +0100
Message-Id: <1105435846.17853.85.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 11:20 +0200, Edjard Souza Mota wrote:
> > You are definitely curing the symptom instead of the cause.
> > 
> > > 1) ranking for the most likely culprits only starts when memory consumption
> > >     gets close to the red zone (for example 98% or something like that).

We do the ranking only in the oom situation, so what's your point ?

> > > 2) killing just gets the first candidate from the list and kills it.
> > > No need to calculate
> > >     at kernel level.

So I need a userspace change in order to solve a kernel problem ?

> > What is the default behaviour when no userspace settings are available -
> > Nothing ? Are you really expecting that we change every root fs in order
> > to be able to upgrade the kernel for solving this _kernel_ problem ?
> 
> No, I certainly don't. But, have seen the application we also posted? It is
> a test for while, that actually starts a deamon when you boot the kernel
> and does rate this application, i.e. an application with root rating priority
> so it will never be killed and never lack space for itself. 
> So, the answer to your 2nd very good point.

You did not answer my question at all. I do not want to update my rootfs
to solve a problem which exists in the kernel and must be solved in the
kernel.

tglx


