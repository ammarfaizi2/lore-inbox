Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWFAHBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWFAHBq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 03:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWFAHBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 03:01:45 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:9176 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750711AbWFAHBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 03:01:45 -0400
Date: Thu, 1 Jun 2006 11:01:36 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060601070136.GA754@2ka.mipt.ru>
References: <20060531090301.GA26782@2ka.mipt.ru> <20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru> <20060531.114127.14356069.davem@davemloft.net> <20060601060424.GA28087@2ka.mipt.ru> <20060601001825.A21730@openss7.org> <20060601063012.GC28087@2ka.mipt.ru> <20060601004608.C21730@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060601004608.C21730@openss7.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 01 Jun 2006 11:01:38 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 12:46:08AM -0600, Brian F. G. Bidulock (bidulock@openss7.org) wrote:
> > Since pseudo-randomness affects both folded and not folded hash
> > distribution, it can not end up in different results.
> 
> Yes it would, so to rule out pseudo-random effects the pseudo-
> random number generator must be removed.
> 
> > 
> > You are right that having test with 2^48 values is really interesting,
> > but it will take ages on my test machine :)
> 
> Try a usable subset; no pseudo-random number generator.

I've run it for 2^30 - the same result: folded and not folded Jenkins
hash behave the same and still both results produce exactly the same
artifacts compared to XOR hash.

Btw, XOR hash, as completely stateless, can be used to show how
Linux pseudo-random generator works for given subset - it's average of
distribution is very good.

-- 
	Evgeniy Polyakov
