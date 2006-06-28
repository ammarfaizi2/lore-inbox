Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423232AbWF1JGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423232AbWF1JGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 05:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423235AbWF1JGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 05:06:08 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46287 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1423232AbWF1JGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 05:06:07 -0400
Date: Wed, 28 Jun 2006 11:00:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Paul Jackson <pj@sgi.com>, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, drepper@redhat.com,
       roland@redhat.com, jakub@redhat.com
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Message-ID: <20060628090058.GA15328@elte.hu>
References: <200606210329_MC3-1-C305-E008@compuserve.com> <20060621081539.GA14227@elte.hu> <20060627224433.fb726e0c.pj@sgi.com> <200606281053.15681.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606281053.15681.ak@suse.de>
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

> On Wednesday 28 June 2006 07:44, Paul Jackson wrote:
> > > but my gut feeling is that we should add a proper sys_get_cpu() syscall 
> > 
> > Yes - this should be for more or less all arch's.
> 
> The whole point of the original implementation is to do a fast 
> architecture specific call. A slow generic call isn't very useful.

it's useful in terms of userspace uniformity. It's alot easier to expose 
such APIs via glibc if there's a generic implementation everywhere. 
Obviously every arch is encouraged to optimize it into a vsyscall.

	Ingo
