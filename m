Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWDNXuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWDNXuv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 19:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWDNXuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 19:50:51 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:53444 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750731AbWDNXuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 19:50:50 -0400
Date: Sat, 15 Apr 2006 00:50:37 +0100 (IST)
From: Mel Gorman <mel@skynet.ie>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bob.picco@hp.com, ak@suse.de,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture
 independent manner V2
In-Reply-To: <200604150917.10596.ncunningham@cyclades.com>
Message-ID: <Pine.LNX.4.64.0604150033230.22940@skynet.skynet.ie>
References: <20060412232036.18862.84118.sendpatchset@skynet>
 <200604150917.10596.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2006, Nigel Cunningham wrote:

> It looks to me like this code could be used by the software suspend code in
> our determinations of what pages to save

Potentially yes. Currently, the node map and related functions are marked 
__init so they become unavailable but that is not set in stone.

>, particularly in the context of
> memory hotplug support.

Right now during memory hot-add, the memory is not registered with 
add_active_range(), but it would be straight-forward to add the call to 
add_memory() of each architecture that supported hotplug for example.

> Just some food for thought at the moment; I'll see if
> I can come up with a patch when I have some time, but it might help justify
> getting this merged.
>

Thanks

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
