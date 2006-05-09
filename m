Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWEIIK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWEIIK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWEIIK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:10:28 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:13481 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751457AbWEIIK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:10:27 -0400
Date: Tue, 9 May 2006 13:36:38 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, jlan@engr.sgi.com
Subject: Re: [Patch 2/8] Sync block I/O and swapin delay collection
Message-ID: <20060509080638.GB11533@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061408.GM13962@in.ibm.com> <20060508141952.2d4b9069.akpm@osdl.org> <20060509035320.GC784@in.ibm.com> <44601933.2040905@yahoo.com.au> <20060509054556.GG784@in.ibm.com> <44602F32.1060909@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44602F32.1060909@yahoo.com.au>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 03:57:06PM +1000, Nick Piggin wrote:
> Balbir Singh wrote:
> 
> >
> >I expect/hope that the CONFIG will be turned on. There is a boot
> >option (called delayacct) to enable/disable the statistics collection.
> >Once turned on and enabled, all tasks will be filling in/using the 
> >statistics.
> >
> 
> Well they'll be _collecting_ the stats, yes. Will they really be using
> them for anything?

Hmm.. No, the statistics are sent down using the netlink interface
to listeners on the netlink group (on every task exit) or to the task that
actually requested for the delay accounting data.

The stats are currently gathered in kernel and used by user space.

> 
> If you make the whole thing much lighter weight for tasks which aren't
> using the accounting, you have a better chance of people turning the
> CONFIG option on.
> 

I am not sure I understand the point completely. Are you suggesting that
struct task_delay_info be moved to common data structure as an aggregate
containing all the delay stats data?

	Thanks,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
