Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbVCXMj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbVCXMj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 07:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbVCXMj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 07:39:28 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:11406 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S263124AbVCXMjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 07:39:08 -0500
Date: Thu, 24 Mar 2005 22:38:02 +1000
From: David McCullough <davidm@snapgear.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jmorris@redhat.com, cryptoapi@lists.logix.cz, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050324123802.GB7115@beast>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323203856.17d650ec.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin Andrew Morton lays it down ...
> David McCullough <davidm@snapgear.com> wrote:
> >
> > Here is a small patch for 2.6.11 that adds a routine:
> > 
> >  	add_true_randomness(__u32 *buf, int nwords);
> 
> It neither applies correctly nor compiles in current kernels.  2.6.11 is
> very old in kernel time.

Sorry about that,  I had actually checked a fairly recent bk version
and noticed quite a few changes.  I used that to figure out what I could
do that would apply reasonably to both 2.4 and 2.6 kernels,  and then
forgot about all those new changes and used the older release kernel.

See the new patch.

> Are we likely to see any in-kernel users of this?

Both the OCF port that I am working on and Evgeniy Polyakov's acrypto
support devices that could use such an API.  The OCF port has already
has two drivers (hifn and safenet) that are using this and,  depending
on how this pans out,  there will be another for Xscale soon.

Whether or not these users of it end up in the kernel is out of my hands
somewhat :-)

Cheers,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
