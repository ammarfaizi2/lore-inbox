Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbTIRMkC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 08:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTIRMkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 08:40:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35726 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261268AbTIRMkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 08:40:00 -0400
Date: Thu, 18 Sep 2003 09:42:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
X-X-Sender: marcelo@logos.cnet
To: Andi Kleen <ak@suse.de>
cc: andrea@suse.de, <linux-kernel@vger.kernel.org>, <sct@redhat.com>
Subject: Re: 2.4.23pre4 VM breaks in LTP
In-Reply-To: <p73llsmlgrx.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0309180929260.2846-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea, do you have any idea of what could cause this? A missing merge may
be the cause, as Andi pointed out. I wont have time to look further into 
it during the weekend and next week (Europe conferences). 

Andi, about the ext3 BUG I'm waiting for Stephen. I remember he knew how
to fix the issue but didnt had the patch ready yet sometime ago.

On 18 Sep 2003, Andi Kleen wrote:


> 
> FYI
> 
> When I run LTP on 2.4.23pre4 the machine deadlocks in mem01.
> It is still pingable, but login etc. do not manage to fork anything.
> 
> mem01 simply allocates all free memory and free swap (as seen
> in /proc/meminfo) and touches a single page in this mapping, then
> exits. 
> 
> I saw the problem on a 1GB RAM + 1GB swap x86-64 box
> 
> (note that on 32bit the limit is 1GB max, so in many cases it will
> not trigger on 32bit)
> 
> When I change mem01 to allocate 10% less memory it does not hang the box.
> And UL -aa kernel also doesn't hang it, so it's probably some half merge.
> 
> Also the ext3 BUG on x86-64 can be also triggered with multiple LTP
> runs.


