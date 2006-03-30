Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWC3Gnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWC3Gnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWC3Gnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:43:39 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:43235 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751134AbWC3Gni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:43:38 -0500
Date: Thu, 30 Mar 2006 12:11:04 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, bharata@in.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: dcache leak in 2.6.16-git8 II
Message-ID: <20060330064104.GC18387@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <200603270750.28174.ak@suse.de> <200603300026.59131.ak@suse.de> <20060329145013.37c87323.akpm@osdl.org> <200603300053.25235.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603300053.25235.ak@suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 12:53:24AM +0200, Andi Kleen wrote:
> On Thursday 30 March 2006 00:50, Andrew Morton wrote:
> 
> > It looks that way.  Didn't someone else report a sock_inode_cache leak?
> 
> Didn't see it.
>  
> > > I still got a copy of the /proc in case anybody wants more information.
> > 
> > We have this fancy new /proc/slab_allocators now, it might show something
> > interesting.  It needs CONFIG_DEBUG_SLAB_LEAK.
> 
> I didn't have that enabled unfortunately. I can try it on the next round.
> 
> -Andi
>

There is also a new sysctl to drop caches. It is called vm.drop_caches.
It will be interesting to see if it is able to free up some dcache memory
for you.

Balbir
 
