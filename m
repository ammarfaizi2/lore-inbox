Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVHFCAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVHFCAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 22:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVHFCAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 22:00:18 -0400
Received: from kanga.kvack.org ([66.96.29.28]:8940 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261881AbVHFCAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 22:00:16 -0400
Date: Fri, 5 Aug 2005 22:00:36 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andrew Morton <akpm@osdl.org>
Cc: benoit.boissinot@ens-lyon.fr, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: fix invalid kmalloc flags
Message-ID: <20050806020035.GA24455@kvack.org>
References: <20050806002603.GA29515@ens-lyon.fr> <20050805173629.78f3a0e6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805173629.78f3a0e6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 05:36:29PM -0700, Andrew Morton wrote:
> No, GFP_DMA should work OK.  Except GFP_DMA doesn't have __GFP_VALID set. 
> It's strange that this didn't get noticed earlier.
> 
> Ben, was there a reason for not giving GFP_DMA the treatment?

Not really.  Traditionally GFP_DMA was always mixed in with GFP_KERNEL or 
GFP_ATOMIC.  It seems that GFP_DMA wasn't in the hunk of defines that all 
the other kernel flags were in, so if GFP_DMA is really valid all by itself, 
adding in the __GFP_VALID should be okay.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
