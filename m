Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWCHWYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWCHWYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWCHWYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:24:50 -0500
Received: from ns1.siteground.net ([207.218.208.2]:28802 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1030233AbWCHWYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:24:48 -0500
Date: Wed, 8 Mar 2006 14:25:28 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, netdev@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
Message-ID: <20060308222528.GE4493@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain> <20060308015934.GB9062@localhost.localdomain> <20060307181301.4dd6aa96.akpm@osdl.org> <20060308202656.GA4493@localhost.localdomain> <20060308203642.GZ5410@kvack.org> <20060308210726.GD4493@localhost.localdomain> <20060308211733.GA5410@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308211733.GA5410@kvack.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 04:17:33PM -0500, Benjamin LaHaise wrote:
> On Wed, Mar 08, 2006 at 01:07:26PM -0800, Ravikiran G Thirumalai wrote:
> 
> Last time I checked, all the major architectures had efficient local_t 
> implementations.  Most of the RISC CPUs are able to do a load / store 
> conditional implementation that is the same cost (since memory barriers 
> tend to be explicite on powerpc).  So why not use it?

Then, for the batched percpu_counters, we could gain by using local_t only for 
the UP case. But we will have to have a new local_long_t implementation 
for that.  Do you think just one use case of local_long_t warrants for a new
set of apis?

Kiran
