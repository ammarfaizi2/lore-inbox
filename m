Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVAKKvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVAKKvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbVAKKvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:51:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28553 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262702AbVAKKvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:51:40 -0500
Date: Tue, 11 Jan 2005 05:48:17 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Edjard Souza Mota <edjard@gmail.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: User space out of memory approach
Message-ID: <20050111074817.GD18796@logos.cnet>
References: <3f250c71050110134337c08ef0@mail.gmail.com> <20050110192012.GA18531@logos.cnet> <4d6522b9050110144017d0c075@mail.gmail.com> <20050110200514.GA18796@logos.cnet> <1105403747.17853.48.camel@tglx.tec.linutronix.de> <4d6522b90501101803523eea79@mail.gmail.com> <1105433093.17853.78.camel@tglx.tec.linutronix.de> <20050111085803.GF26799@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111085803.GF26799@dualathlon.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 09:58:03AM +0100, Andrea Arcangeli wrote:
> On Tue, Jan 11, 2005 at 09:44:53AM +0100, Thomas Gleixner wrote:
> > I consider the invocation of out_of_memory in the first place. This is
> > the real root of the problems. The ranking is a different playground.
> > Your solution does not solve
> > - invocation madness
> > - reentrancy protection
> > - the ugly mess of timers, counters... in out_of_memory, which aren't
> > neccecary at all
> 
> Thomas, you're obviously right, it's not even worth discussing this.
> The 6 patches I posted (and my version is the only one that includes all
> the outstanding fixes) have to be applied. Than we can think about the
> rest.
> 
> Rik's two patches (writeback-highmem and writeback_nr_scanned) should be
> applied too since they're obviously right too (and they're completely
> orthogonal with our 6). Rik's 2/2 looked more like an hack and it
> shouldn't be applied.

This patchsets should be in -mm by now? :)
