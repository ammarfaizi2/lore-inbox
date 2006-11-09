Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754368AbWKIJRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbWKIJRH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 04:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754448AbWKIJRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 04:17:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:19655 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1754368AbWKIJRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 04:17:04 -0500
Date: Thu, 9 Nov 2006 10:15:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, rdreier@cisco.com
Subject: Re: locking hierarchy based on lockdep
Message-ID: <20061109091554.GB23876@elte.hu>
References: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com> <20061106200529.GA15370@elte.hu> <Pine.LNX.4.64.0611071833450.22572@dhcp83-20.boston.redhat.com> <20061107235342.GA5496@elte.hu> <Pine.LNX.4.64.0611081254150.18340@dhcp83-20.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611081254150.18340@dhcp83-20.boston.redhat.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jason Baron <jbaron@redhat.com> wrote:

> You are right though, i think that the data in the locks after lists 
> is sufficient to re-create the entire graph, since its acyclic, but by 
> simply printing out nodes of distance '1', the algorithm is greatly 
> simplified. Otherwise, i'd have to first reconstruct the graph...

but ... the locks_after list should really only include locks that are 
taken immediately after. I.e. there should only be 'distance 1' locks.

	Ingo

