Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVCYXvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVCYXvC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 18:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVCYXvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 18:51:02 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:24594 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261411AbVCYXu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 18:50:56 -0500
Date: Sat, 26 Mar 2005 10:47:45 +1100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kim Phillips <kim.phillips@freescale.com>, johnpol@2ka.mipt.ru,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       cryptoapi@lists.logix.cz, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050325234745.GA22661@gondor.apana.org.au>
References: <1111737496.20797.59.camel@uganda> <424495A8.40804@freescale.com> <20050325234348.GA17411@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050325234348.GA17411@havoc.gtf.org>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 06:43:49PM -0500, Jeff Garzik wrote:
> 
> In any case, it is the wrong solution to simply "turn on the tap" and
> let the RNG spew data.  There needs to be a limiting factor... typically
> rngd should figure out when /dev/random needs more entropy, or simply
> delay a little bit between entropy collection/stuffing runs.

Completely agreed.  Having it in rngd also allows the scheduler to
do its job.

When applications need entropy from /dev/random and they can't get it,
they'll simply block which allows rngd to run to refill the tank.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
