Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVIUA6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVIUA6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVIUA6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:58:52 -0400
Received: from fmr24.intel.com ([143.183.121.16]:14533 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750866AbVIUA6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:58:51 -0400
Date: Tue, 20 Sep 2005 17:58:44 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] intel_cacheinfo: remove MAX_CACHE_LEAVES limit
Message-ID: <20050920175843.A31499@unix-os.sc.intel.com>
References: <20050919121435.A10231@unix-os.sc.intel.com> <20050920160604.5e022fa8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050920160604.5e022fa8.akpm@osdl.org>; from akpm@osdl.org on Tue, Sep 20, 2005 at 04:06:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 04:06:04PM -0700, Andrew Morton wrote:
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> >
> > Remove the MAX_CACHE_LEAVES limit from the routine which calculates the
> > number of cache levels using cpuid(4)
> 
> Why?  Why was the code there originally, and why is it required that it be
> removed, and why is it safe to remove it?
> 
> (IOW: your description of this patch is inadequate: it describes what was
> done, but not why it was done).

oops! Initial internal version of Venki's cpuid(4) deterministic cache
parameter identification patch used static arrays of size MAX_CACHE_LEAVES. 
Final patch which made to the base used dynamic array allocation, with this
MAX_CACHE_LEAVES limit hunk still in place. 

cpuid(4) already has a mechanism to find out the number of cache levels
implemented and there is no need for this hardcoded MAX_CACHE_LEAVES limit.

thanks,
suresh
