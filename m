Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWFUJkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWFUJkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWFUJkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:40:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36226 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932496AbWFUJkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:40:36 -0400
Date: Wed, 21 Jun 2006 11:35:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Message-ID: <20060621093517.GA16968@elte.hu>
References: <200606210329_MC3-1-C305-E008@compuserve.com> <p73zmg6oo5t.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73zmg6oo5t.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> Chuck Ebbert <76306.1226@compuserve.com> writes:
> 
> > Use a GDT entry's limit field to store per-cpu data for fast access 
> > from userspace, and provide a vsyscall to access the current CPU 
> > number stored there.
> 
> Just the CPU alone is useless - you want at least the node too in many 
> cases. Best you use the prototype I proposed earlier for x86-64.

just the CPU is fine already in many cases [and the node ID derives from 
the linear CPU id anyway] - but i agree that in the API we want to 
include the node-ID too, for NUMA-aware userspace allocators, etc.

	Ingo
