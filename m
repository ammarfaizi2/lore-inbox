Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbVBYLIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVBYLIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 06:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVBYLHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 06:07:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:7660 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262672AbVBYLHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 06:07:31 -0500
Message-Id: <200502251107.j1PB7Ptk008435@owlet.beaverton.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 12/13] schedstats additions for sched-balance-fork 
In-reply-to: Your message of "Thu, 24 Feb 2005 09:46:22 +0100."
             <20050224084622.GC10023@elte.hu> 
Date: Fri, 25 Feb 2005 03:07:25 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    There is little help we get from userspace, and i'm not sure we want to
    add scheduler overhead for this single benchmark - when something like a
    _tiny_ bit of NUMAlib use within the OpenMP library would probably solve
    things equally well!

There's has been a general problem with sched domains and it trying to
meet two goals: "1) spread things around evenly within a domain and
balance across domains infrequently", and "2) load up cores before
loading up siblings, even at the expense of violating 1)".

We've had trouble getting both 1) and 2) implemented correctly in
the past.  If this patch gets us closer to that nirvana, it will be
valuable regardless of the benchmark it also happens to be improving.

Regardless, I agree it will need good testing, and we may need to
pick the wheat from the chaff.

Rick
