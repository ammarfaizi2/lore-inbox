Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263030AbVCXEqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbVCXEqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 23:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVCXEqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 23:46:37 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:2445 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S262407AbVCXEq3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 23:46:29 -0500
Date: Thu, 24 Mar 2005 14:46:21 +1000
From: David McCullough <davidm@snapgear.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050324044621.GC3124@beast>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050324043300.GA2621@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324043300.GA2621@havoc.gtf.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin Jeff Garzik lays it down ...
> On Thu, Mar 24, 2005 at 02:27:08PM +1000, David McCullough wrote:
> > 
> > Hi all,
> > 
> > Here is a small patch for 2.6.11 that adds a routine:
> > 
> > 	add_true_randomness(__u32 *buf, int nwords);
> > 
> > so that true random number generator device drivers can add a entropy
> > to the system.  Drivers that use this can be found in the latest release
> > of ocf-linux,  an asynchronous crypto implementation for linux based on
> > the *BSD Cryptographic Framework.
> > 
> > 	http://ocf-linux.sourceforge.net/
> > 
> > Adding this can dramatically improve the performance of /dev/random on
> > small embedded systems which do not generate much entropy.
> 
> We've already had hardware RNG support for a while now.
> 
> No kernel patching needed.

Are you talking about /dev/hw_random ?  If not then sorry I didn't see it :-(

On a lot of the small systems I work on,  /dev/random is completely
unresponsive,  and all the apps use /dev/random,  not /dev/hw_random.

Would you suggest making /dev/random point to /dev/hw_random then ?

Thanks,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
