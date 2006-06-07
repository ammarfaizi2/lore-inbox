Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWFGPUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWFGPUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 11:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWFGPUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 11:20:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:59271 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932256AbWFGPUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 11:20:33 -0400
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 0/5] Sizing zones and holes in an architecture independent manner V7
Date: Wed, 7 Jun 2006 17:20:22 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk,
       tony.luck@intel.com, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org
References: <20060606134710.21419.48239.sendpatchset@skynet.skynet.ie> <200606071216.24640.ak@suse.de> <Pine.LNX.4.64.0606071118230.20653@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0606071118230.20653@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606071720.22242.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, while true, I'm not sure how it affects performance. The only "real" 
> value affected by present_pages is the number of patches that are 
> allocated in batches to the per-cpu allocator.

It affects the low/high water marks in the VM zone balancer.

Especially for the 16MB DMA zone it can make a difference if you
account 4MB kernel in there or not.

-Andi

