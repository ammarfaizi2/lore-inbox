Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUHQAIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUHQAIC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUHQAGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:06:47 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3978 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268050AbUHQAGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:06:10 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040817021431.169d07db@mango.fruits.de>
References: <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu>  <20040817021431.169d07db@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1092701223.13981.106.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 20:07:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 20:14, Florian Schmidt wrote:
> On Mon, 16 Aug 2004 06:05:15 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > Anyway, the change to sched.c fixes the mlockall bug, it works
> > > perfectly now.  Thanks!
> > 
> > great! This fix also means that we've got one more lock-break in the
> > ext3 journalling code and one more lock-break in dcache.c. I've
> > released-P1 with the fix included:
> > 
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P1
> 
> Hi,
> 
> i don't know if this was mentioned before, but i sometimes see traces
> like this where half the entries are "preempt_schedule
> (copy_page_range)". I just wanted to ask if this is normal and expected
> behaviour.
> 

Yes, Ingo identified an issue with copy_page_range, I don't think it's
fixed yet.  See the voluntary-preempt-2.6.8.1-P0 thread.

Lee

