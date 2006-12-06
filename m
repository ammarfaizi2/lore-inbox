Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936655AbWLFQ7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936655AbWLFQ7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936550AbWLFQ7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:59:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33544 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936655AbWLFQ7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:59:37 -0500
Date: Wed, 6 Dec 2006 17:58:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061206165842.GA17755@elte.hu>
References: <20061204204024.2401148d.akpm@osdl.org> <Pine.LNX.4.64.0612060348150.1868@scrub.home> <20061205203013.7073cb38.akpm@osdl.org> <1165393929.24604.222.camel@localhost.localdomain> <Pine.LNX.4.64.0612061334230.1867@scrub.home> <20061206131155.GA8558@elte.hu> <Pine.LNX.4.64.0612061422190.1867@scrub.home> <20061206152244.GA24613@elte.hu> <Pine.LNX.4.64.0612061633230.1867@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061633230.1867@scrub.home>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > > > [...] one obvious user would be the scheduler, [...]
> > 
> > but that is not a refutation of what Thomas said, at all. You say 
> > that the scheduler /could/ use such a facility. What Thomas said was 
> > that /there are no current users of such a facility/. It is a really 
> > simple (and unconditionally true) observation from Thomas. Yes, we 
> > could change other kernel code not directly related to high-res 
> > timers, but we chose not to.
> 
> I didn't say "/could/", the scheduler _needs_ such a facility. [...]

i disagree that the scheduler unconditionally 'needs' such a facility. 
The scheduler clock is pretty special and has other requirements and 
constraints than generic timekeeping clocks. It /might/ and /could/ 
utilize such an infrastructure, but it's not at all clear that it 
'needs' such a facility.

in any case, i very much entertain the possibility of more synergy in 
this space, but it's far from obvious and it's definitely not 
unconditionally 'necessary'. The scheduler and profiling code certainly 
worked for 15 years without such synergy. What we concentrated on in 
this patchset is high-resolution timers and dynticks, not scheduler or 
profiler clock cleanups. We cleaned up everything that we impacted 
directly, but we also tried to limit the scope of the changes wherever 
possible.

	Ingo
