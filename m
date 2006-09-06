Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWIFW1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWIFW1i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWIFW1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:27:38 -0400
Received: from nef2.ens.fr ([129.199.96.40]:23817 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1751544AbWIFW1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:27:37 -0400
Date: Thu, 7 Sep 2006 00:27:31 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060906222731.GA10675@clipper.ens.fr>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906182531.GA24670@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906182531.GA24670@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Thu, 07 Sep 2006 00:27:31 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 01:25:31PM -0500, Serge E. Hallyn wrote:
> The fact that you're changing the inheritance rules is a bit scary, so
> I'm going to (and I hope others will) take some time to look it over.

Thanks!  I'd appreciate it.  Don't hesitate to ask me if some
decisions I made are unclear.

I was about to write to you, in fact, since I wrote a version of my
patch which merges with the one you made (an old version, though, I
suppose: I took it from <URL: http://lkml.org/lkml/2006/8/15/294 >,
but I can try merging with more recent versions).  The point being to
show that my patch is not incompatible with yours: they are quite
complementary.  (The merged patch can be found in <URL:
ftp://quatramaran.ens.fr/pub/madore/newcaps/pre-alpha/ >.)

> In the meantime, so long as you're adding some new capabilities, how
> about also splitting up a few like CAP_SYS_ADMIN?  Have you looked into
> it and decided none are really separable, i.e. any subset leads to the
> ability to get any other subset?

I agree that splitting CAP_SYS_ADMIN might be worth while, but it
really looks like opening a worm can, so I didn't feel up to the
challenge there.  It might be a good idea to reserve some bits for
that possibility, however - I'm not sure how best to proceed.

> I'd recommend you split this patch into at least 3:
> 	1. move to 64-bit caps
> 	2. introduce your new caps
> 		(perhaps even one new cap per patch)
> 	3. introduce the new inheritance rules

Yes, that sounds like a good idea.  I'll do that.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
