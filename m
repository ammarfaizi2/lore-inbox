Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWGYTSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWGYTSm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWGYTSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:18:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:16061 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964822AbWGYTSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:18:41 -0400
Date: Tue, 25 Jul 2006 21:12:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Olaf Hering <olh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Albert Cahalan <acahalan@gmail.com>,
       arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: utrace vs. ptrace
Message-ID: <20060725191221.GA10641@elte.hu>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com> <200607131437.28727.ak@suse.de> <20060713124316.GA18852@elte.hu> <200607131521.52505.ak@suse.de> <Pine.LNX.4.64.0607131203450.5623@g5.osdl.org> <1153853342.4725.21.camel@localhost> <Pine.LNX.4.64.0607251124080.29649@g5.osdl.org> <20060725185744.GA15844@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725185744.GA15844@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Olaf Hering <olh@suse.de> wrote:

>  On Tue, Jul 25, Linus Torvalds wrote:
> 
> > What you often want is not a core-dump at all, but a "stop the process" 
> > thing. It's really irritating that the core-dump is generated and the 
> > process is gone, when it would often be a lot nicer if instead of 
> > core-dumping, the process was just stopped and then you could attach to it 
> > with gdb, and get the whole damn information (including things like access 
> > to open file descriptors etc).
> > 
> > But again, that has nothing to do with core-dumping. 
> 
> It would be helpful to have that sort of functionality in mainline. 
> Would a patch be acceptable that sends SIGSTOP instead of SIGSEGV or 
> SIGILL if some knob was enabled, either global or per process?

FYI, the sample utrace module from Roland does precisely that, it stops 
a task on crash... See more at:

  http://people.redhat.com/roland/utrace/

- crash-suspend.c is the sample module.

- ntrace-0.0.2.tar.bz2 is an extensive ptrace and utrace functionality 
  testsuite.

	Ingo
