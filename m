Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274889AbTGaVal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274880AbTGaV2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:28:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:34969 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S274877AbTGaV2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:28:11 -0400
Date: Fri, 1 Aug 2003 03:01:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, andrea@suse.de, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2
Message-ID: <20030731213103.GB17709@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030731185806.GC1990@in.ibm.com> <20030731134954.54108d95.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731134954.54108d95.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 01:49:54PM -0700, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> >
> > I have merged Rusty's original patch for reducing the size of
> > rcu_heads by splitting the two main changes into two patches.
> 
> There are probably a lot of data structures in which we could save 4 (or 8)
> bytes by converting things from doubly linked to singly linked.
> 
> And that's good, but given that at this time we are concentrating 100% on
> stabilising 2.6 (aren't we?) I'll be letting these patches slide, thanks.

The linked-list change is internal enough for a future backport from
2.7. The only concern here is the change in call_rcu() API. What would
be a good way to manage that ?

Thanks
Dipankar
