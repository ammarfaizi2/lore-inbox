Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWGMJXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWGMJXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWGMJXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:23:44 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6324 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964868AbWGMJXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:23:43 -0400
Date: Thu, 13 Jul 2006 11:18:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: sekharan@us.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, arjan@infradead.org
Subject: Re: [patch] lockdep: more annotations for mm/slab.c
Message-ID: <20060713091804.GA11572@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu> <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu> <20060713004445.cf7d1d96.akpm@osdl.org> <20060713084213.GA6985@elte.hu> <20060713084613.GA7177@elte.hu> <20060713020801.44b99061.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713020801.44b99061.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5296]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > ---
> >  mm/slab.c |   45 +++++++++++++++++++++++++--------------------
> 
> geeze, what fuss.  Can't we just tell lockdep "the locking here is 
> correct, so buzz off"?

well, lockdep already found a locking bug in slab.c, so by telling 
lockdep to buzz off we lose the proof of correctness :-)

but i agree that this is getting a bit too intrusive. This patch is 
really just another expression of: 'slab locking is too complex', but i 
digress. Not all hope is lost though: Arjan thinks he can do a much 
simpler annotation.

	Ingo
