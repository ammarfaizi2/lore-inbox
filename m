Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbUKPXPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUKPXPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUKPXMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:12:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:31698 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261884AbUKPXKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:10:46 -0500
Date: Tue, 16 Nov 2004 15:10:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
In-Reply-To: <20041116232827.GA842@elte.hu>
Message-ID: <Pine.LNX.4.58.0411161509190.2222@ppc970.osdl.org>
References: <20041116113209.GA1890@elte.hu> <419A7D09.4080001@bigpond.net.au>
 <20041116232827.GA842@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Nov 2004, Ingo Molnar wrote:
> 
> maybe, but why? Atomic ops are still a tad slower than normal ops

A "tad" slower? 

An atomic op is pretty much as expensive as a spinlock/unlock pair on x86.  
Not _quite_, but it's pretty close.

So yes, avoiding atomic ops is good if you can do it without any other 
real downsides (not having had time to check the patch yet, I won't do 
into that ;)

		Linus
