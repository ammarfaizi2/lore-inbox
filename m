Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422775AbWKPJtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbWKPJtj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 04:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422805AbWKPJti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 04:49:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55983 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1422775AbWKPJti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 04:49:38 -0500
Date: Thu, 16 Nov 2006 10:48:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc6] x86_64: UP build fixes
Message-ID: <20061116094852.GA19305@elte.hu>
References: <20061116084855.GA8848@elte.hu> <200611161001.01407.ak@suse.de> <20061116011733.e119eae5.akpm@osdl.org> <200611161022.04022.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611161022.04022.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Thursday 16 November 2006 10:17, Andrew Morton wrote:
> > On Thu, 16 Nov 2006 10:01:01 +0100
> > Andi Kleen <ak@suse.de> wrote:
> > 
> > > +#ifdef CONFIG_HOTPLUG_CPU
> > >  	hotcpu_notifier(cpu_vsyscall_notifier, 0);
> > > +#endif
> > 
> > this part isn't needed - the definition handles that.
> 
> Thanks. Updated patch appended.

my hotplug-CPU cleanup patch solves this in a cleaner way: by removing 
all those #ifdefs as well.

	Ingo
