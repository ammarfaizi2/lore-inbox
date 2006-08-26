Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWHZWNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWHZWNk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 18:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWHZWNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 18:13:40 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36485 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751223AbWHZWNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 18:13:39 -0400
Date: Sun, 27 Aug 2006 00:05:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       ego@in.ibm.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, vatsa@in.ibm.com, dipankar@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-ID: <20060826220525.GA27933@elte.hu>
References: <20060824102618.GA2395@in.ibm.com> <20060824091704.cae2933c.akpm@osdl.org> <20060825095008.GC22293@redhat.com> <Pine.LNX.4.64.0608261404350.11811@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608261404350.11811@g5.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> I personally doubt that it's the case that we'd want to accelerate 
> inclusion - very few things actually do CPU hotplug, and right now the 
> only way to even hit the sequences in normal use is literally just the 
> "suspend under SMP" case that hasn't historically worked very well 
> anyway, but was what made at least me personally aware of the problems 
> ;^).

there's also bootup on SMP that is technically a series of hot-cpu-add 
events. That already tests some aspects of it. Maybe we should turn 
shutdown into the logical reverse: into a series of hot-cpu-remove 
events?

	Ingo
