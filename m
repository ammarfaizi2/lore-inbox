Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbULIWsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbULIWsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 17:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbULIWsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 17:48:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:35255 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261647AbULIWsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 17:48:39 -0500
Date: Thu, 9 Dec 2004 14:52:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: hugh@veritas.com, torvalds@osdl.org, benh@kernel.crashing.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12: rss tasklist vs sloppy rss
Message-Id: <20041209145237.353f5c71.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0412091348130.7478@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain>
	<Pine.LNX.4.58.0412091348130.7478@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Thu, 9 Dec 2004, Hugh Dickins wrote:
> 
> > How do the scalability figures compare if you omit patch 7/7 i.e. revert
> > the per-task rss complications you added in for Linus?  I remain a fan
> > of sloppy rss, which you earlier showed to be accurate enough (I'd say),
> > though I guess should be checked on other architectures than your ia64.
> > I can't see the point of all that added ugliness for numbers which don't
> > need to be precise - but perhaps there's no way of rearranging fields,
> > and the point at which mm->(anon_)rss is updated (near up of mmap_sem?),
> > to avoid destructive cacheline bounce.  What I'm asking is, do you have
> > numbers to support 7/7?  Perhaps it's the fact you showed up to 512 cpus
> > this time, but only up to 32 with sloppy rss?  The ratios do look better
> > with the latest, but the numbers are altogether lower so we don't know.
> 
> Here is a full set of numbers for sloppy and tasklist.

Yes, but that only tests the thing-which-you're-trying-to-improve.  We also
need to work out the impact of that tasklist walk on other people's worst
cases.

> sloppy (2.6.10-bk14-rss-sloppy-prefault):

It would be helpful if you could generate a breif summary of benchmarking
results as well as dumping the raw numbers, please.
