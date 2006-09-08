Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWIHUPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWIHUPg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 16:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWIHUPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 16:15:36 -0400
Received: from mga07.intel.com ([143.182.124.22]:24248 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751187AbWIHUPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 16:15:34 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,134,1157353200"; 
   d="scan'208"; a="113862872:sNHT30053954"
Date: Fri, 8 Sep 2006 13:00:28 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, npiggin@suse.de, mingo@elte.hu
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
Message-ID: <20060908130028.A9446@unix-os.sc.intel.com>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com> <20060908103529.A9121@unix-os.sc.intel.com> <Pine.LNX.4.64.0609081135590.23089@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.64.0609081135590.23089@schroedinger.engr.sgi.com>; from clameter@sgi.com on Fri, Sep 08, 2006 at 11:40:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 11:40:51AM -0700, Christoph Lameter wrote:
> The balancing operation is not that frequent and having to treat a special 
> case in the callers would make code more complicated and likely offset the
> gains in this function.

This solution as such is not accurate and clean :) and my suggestion is
not making it any more ugly.

With increase in NR_CPUS, cost of cpumask operations will increase and 
we shouldn't penalize the other logical threads or cores sharing the caches by
bringing in unnecessary cache lines.

thanks,
suresh
