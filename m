Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVC2Bfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVC2Bfe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 20:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVC2Bfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 20:35:34 -0500
Received: from waste.org ([216.27.176.166]:5348 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262135AbVC2Bf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 20:35:26 -0500
Date: Mon, 28 Mar 2005 17:33:59 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, davidm@snapgear.com,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329013358.GD25554@waste.org>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org> <42424D52.7070508@pobox.com> <20050323213226.1b8010f8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323213226.1b8010f8.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 09:32:26PM -0800, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > > It neither applies correctly nor compiles in current kernels.  2.6.11 is
> >  > very old in kernel time.
> > 
> >  Hrm.  This is getting pretty lame, if you can't take patches from the 
> >  -latest- stable release.  It's pretty easy in BK:
> > 
> >  	bk clone -ql -rv2.6.11 linux-2.6 rng-2.6.11
> >  	cd rng-2.6.11
> >  	{ apply patch }
> >  	bk pull ../linux-2.6
> > 
> >  Can you set up something like that?
> 
> About thirty patches have gone into random.c since 2.6.11.  But the patch
> was easy enough to apply anyway.
> 
> And then, it didn't compile.  I don't think bk will fix that.

No, the names of all the pools changed. I agree with Jeff, this patch
is unnecessary. If we actually wanted such an interface, I'd rather it
refactor things so as not to reproduce the wake up logic.

-- 
Mathematics is the supreme nostalgia of our time.
