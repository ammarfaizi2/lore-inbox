Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268914AbUHMAd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268914AbUHMAd3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUHMAd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:33:28 -0400
Received: from holomorphy.com ([207.189.100.168]:32655 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268914AbUHMAdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:33:07 -0400
Date: Thu, 12 Aug 2004 17:32:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Message-ID: <20040813003255.GS11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, steiner@sgi.com
References: <200408121646.50740.jbarnes@engr.sgi.com> <20040813001331.GR11200@holomorphy.com> <200408121725.15985.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408121725.15985.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 12, 2004 5:13 pm, William Lee Irwin III wrote:
>> Interesting. This may attempt to allocate from offlined nodes, assuming
>> one adds on sufficient hotplug bits atop mainline and/or -mm. The
>> following almost does it hotplug-safe except that it needs to enter the
>> allocator with preemption disabled and drop the preempt_count
>> internally to it.

On Thu, Aug 12, 2004 at 05:25:15PM -0700, Jesse Barnes wrote:
> Can we make alloc_pages_node take offline nodes instead?  Maybe it could just 
> allocate from the next nearest node or something?

I don't think we should do anything but point it out for those writing
the hotplug patches to look for. There are enough interactions in
general we're not even looking for that making the whole tree
hotplug-safe is hopeless unless the hotplug ppl get involved with e.g.
more complete patches, being able to actually test things, etc.


On Thursday, August 12, 2004 5:13 pm, William Lee Irwin III wrote:
>> I suspect we are better off punting this in the direction of hotplug
>> people than trying to address it ourselves. I think we should go with
>> this now, as the node hotplug bits are yet to hit the tree.

On Thu, Aug 12, 2004 at 05:25:15PM -0700, Jesse Barnes wrote:
> Yeah, agreed.

Yes... their patch, their implementation burden.


-- wli
