Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWDZLJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWDZLJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 07:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWDZLJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 07:09:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58261 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932390AbWDZLJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 07:09:03 -0400
Date: Wed, 26 Apr 2006 06:08:56 -0500
From: Robin Holt <holt@sgi.com>
To: Jes Sorensen <jes@sgi.com>
Cc: Dean Nelson <dcn@sgi.com>, Andrew Morton <akpm@osdl.org>,
       tony.luck@intel.com, avolkov@varma-el.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] change gen_pool allocator to not touch managed memory
Message-ID: <20060426110856.GB19935@lnx-holt.americas.sgi.com>
References: <444D1A7E.mailx85W11DZZU@aqua.americas.sgi.com> <20060424181626.09966912.akpm@osdl.org> <20060425155051.GA19248@sgi.com> <444F3990.5030100@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444F3990.5030100@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 11:12:48AM +0200, Jes Sorensen wrote:
> > -	if (status)
> > -		printk(KERN_WARNING "smp_call_function failed for "
> > -		       "uncached_ipi_mc_drain! (%i)\n", status);
> > +	(void) smp_call_function(uncached_ipi_mc_drain, NULL, 0, 1);
> 
> This thing could in theory fail so having the error check there seems
> the right thing to me. In either case, please don't (void) the function
> return (this is a style issue, I know).

I must be blind.  Both up and smp cases for smp_call_function appear to
always return 0.  What am I missing?

Thanks,
Robin
