Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbTINM60 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 08:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTINM60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 08:58:26 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:48872 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S262394AbTINM6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 08:58:25 -0400
Date: Sun, 14 Sep 2003 18:30:37 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [patch] Make slab allocator work with SLAB_MUST_HWCACHE_ALIGN
Message-ID: <20030914130037.GA1781@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030910081654.GA1129@llm08.in.ibm.com> <1063208464.700.35.camel@localhost> <20030911055428.GA1140@llm08.in.ibm.com> <20030911110853.GB3700@llm08.in.ibm.com> <3F60A08A.7040504@colorfullife.com> <20030912085921.GB1128@llm08.in.ibm.com> <3F6378B0.8040606@colorfullife.com> <20030914080942.GA9302@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914080942.GA9302@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 01:39:42PM +0530, Ravikiran G Thirumalai wrote:
> The patch I posted earlier takes care of 1 & 2, but arbitraty alignment takes
> care of all 4, and as you mentioned the patch is small enough.  If interface

While we are at it, we should also probably look up the cache line
size for a cpu family from a table, store it in some per-cpu data
(cpuinfo_x86 ?) and provide an l1_cache_bytes() api to
return it at run time.

Thanks
Dipankar
