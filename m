Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVAUGi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVAUGi5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVAUGi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:38:57 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:39257 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262285AbVAUGgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:36:25 -0500
Subject: Re: OOM fixes 2/5
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       npiggin@novell.com
In-Reply-To: <20050120222056.61b8b1c3.akpm@osdl.org>
References: <20050121054840.GA12647@dualathlon.random>
	 <20050121054916.GB12647@dualathlon.random>
	 <20050120222056.61b8b1c3.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 17:36:14 +1100
Message-Id: <1106289375.5171.7.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 22:20 -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> >  This is the forward port to 2.6 of the lowmem_reserved algorithm I
> >  invented in 2.4.1*, merged in 2.4.2x already and needed to fix workloads
> >  like google (especially without swap) on x86 with >1G of ram, but it's
> >  needed in all sort of workloads with lots of ram on x86, it's also
> >  needed on x86-64 for dma allocations. This brings 2.6 in sync with
> >  latest 2.4.2x.
> 
> But this patch doesn't change anything at all in the page allocation path
> apart from renaming lots of things, does it?
> 
> AFAICT all it does is to change the default values in the protection map. 
> It does it via a simplification, which is nice, but I can't see how it
> fixes anything.
> 
> Confused.


It does turn on lowmem protection by default. We never reached
an agreement about doing this though, but Andrea has shown that
it fixes trivial OOM cases.

I think it should be turned on by default. I can't recall what
your reservations were...?



