Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268911AbUHMA1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268911AbUHMA1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268913AbUHMA1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:27:05 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:58810 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268911AbUHMAZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:25:55 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Date: Thu, 12 Aug 2004 17:25:15 -0700
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, steiner@sgi.com
References: <200408121646.50740.jbarnes@engr.sgi.com> <20040813001331.GR11200@holomorphy.com>
In-Reply-To: <20040813001331.GR11200@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408121725.15985.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 12, 2004 5:13 pm, William Lee Irwin III wrote:
> Interesting. This may attempt to allocate from offlined nodes, assuming
> one adds on sufficient hotplug bits atop mainline and/or -mm. The
> following almost does it hotplug-safe except that it needs to enter the
> allocator with preemption disabled and drop the preempt_count
> internally to it.

Can we make alloc_pages_node take offline nodes instead?  Maybe it could just 
allocate from the next nearest node or something?

> I suspect we are better off punting this in the direction of hotplug
> people than trying to address it ourselves. I think we should go with
> this now, as the node hotplug bits are yet to hit the tree.

Yeah, agreed.

Jesse
