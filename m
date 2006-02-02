Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423360AbWBBHrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423360AbWBBHrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 02:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423361AbWBBHrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 02:47:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:61654 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1423360AbWBBHru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 02:47:50 -0500
Date: Thu, 2 Feb 2006 08:46:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060202074627.GA6805@elte.hu>
References: <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu> <20060131102758.GA31460@gondor.apana.org.au> <20060131.024323.83813817.davem@davemloft.net> <20060201133219.GA1435@elte.hu> <20060201202610.GA13107@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201202610.GA13107@gondor.apana.org.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Wed, Feb 01, 2006 at 02:32:19PM +0100, Ingo Molnar wrote:
> > 
> > update: with all of Herbert's fixes i havent gotten these yet - so maybe 
> > the validator was not producing a false positive, but perhaps the 
> > inet6_destroy_sock()->sk_dst_reset() thing was causing the messages?
> 
> Maybe.  But in that case shouldn't the validator show that code-path?

yeah, it should have. In any case, things are looking good so far with 
your fixes. (Any suggestions wrt. how to trigger as many different 
codepaths in the networking code as possible, to increase coverage of 
locking scenarios mapped? I've tried LTP so far, and a few ad-hoc tests.  
Perhaps there's some IP protocol tester i should try, which is known to 
trigger lots of boundary conditions?)

	Ingo
