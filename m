Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313975AbSDKDwm>; Wed, 10 Apr 2002 23:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313976AbSDKDwl>; Wed, 10 Apr 2002 23:52:41 -0400
Received: from air-2.osdl.org ([65.201.151.6]:23054 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S313975AbSDKDwk>;
	Wed, 10 Apr 2002 23:52:40 -0400
Date: Wed, 10 Apr 2002 20:52:37 -0700 (PDT)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch-2.5.8-pre] swapinfo accounting
In-Reply-To: <3CB4DD71.DED82F57@zip.com.au>
Message-ID: <Pine.LNX.4.33.0204102046140.12442-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, Andrew Morton wrote:

| "Randy.Dunlap" wrote:
| >
| > It looks to me like mm/swapfile.c::si_swapinfo()
| > shouldn't be adding nr_to_be_unused to total_swap_pages
| > or nr_swap_pages for return in val->freeswap and
| > val->totalswap.
|
| whee, an si_swapinfo() maintainer.

whoops.  I can't argue for its efficiency, can I?

| Your function sucks :)  I'm spending 15 CPU-seconds
| in there during a kernel build.  The problem appears
| to be that a fix from 2.4 hasn't been propagated
| forward.

Bah!!  :(  Where is a version-forwarder for this stuff?  8;)
and will it be dropped...

Your latter 2 sentences aren't related -- right?
On the 15 CPU-seconds in si_swapfile():  yes, I think
there is room for some improvement there.

| 2.4 has:
|
|                 if (swap_info[i].flags != SWP_USED)
|
| and 2.5 has:
|
|                 if (!(swap_info[i].flags & SWP_USED))
|
| and I think the 2.4 version will fix the accounting
| problem you're seeing?

OK, I'll try it Thurs.

| (I haven't checked whather it's the _right_ fix, but
| it looks like it'll make it go away?)

We'll see about that.

Thanks-
-- 
~Randy

