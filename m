Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbVCQBEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbVCQBEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 20:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbVCQBEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 20:04:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:49324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262930AbVCQBEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 20:04:06 -0500
Date: Wed, 16 Mar 2005 17:03:59 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ian Pilcher <i.pilcher@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2/9] Possible AMD8111e free irq issue
Message-ID: <20050317010359.GD28536@shell0.pdx.osdl.net>
References: <20050316235336.GY5389@shell0.pdx.osdl.net> <20050316235427.GA5389@shell0.pdx.osdl.net> <d1aicj$iq1$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1aicj$iq1$2@sea.gmane.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ian Pilcher (i.pilcher@comcast.net) wrote:
> Chris Wright wrote:
> >
> >From: Andres Salomon <dilinger@debian.org>
> >
> >It seems to me that if in the amd8111e_open() fuction dev->irq isn't
> >zero and the irq request succeeds it might not get released anymore.
> 
> Based on the wording above, I can't help wondering if this fixes a
> problem that anyone is actually seeing.

I had same hesitation, but it's easy to see how lowmem could trigger
this latent bug (so it's not a highly theoretical race condition, for
example), and the fix is both quite simple and accepted upstream already.
Anyway that's what the review cycle is for, it can be rejected.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
