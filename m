Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269081AbRH0VYc>; Mon, 27 Aug 2001 17:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269099AbRH0VYX>; Mon, 27 Aug 2001 17:24:23 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:3501 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S269081AbRH0VYN>; Mon, 27 Aug 2001 17:24:13 -0400
Date: Mon, 27 Aug 2001 23:24:15 +0200
From: Cliff Albert <cliff@oisec.net>
To: Robert Love <rml@tech9.net>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, J Sloan <jjs@toyota.com>
Subject: Re: Updated Linux kernel preemption patches
Message-ID: <20010827232415.A670@oisec.net>
In-Reply-To: <998877465.801.19.camel@phantasy> <20010827093835.A15153@oisec.net> <3B8AA02D.6F7561AB@lexus.com> <998941465.1993.9.camel@phantasy> <998947154.11860.30.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998947154.11860.30.camel@phantasy>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 05:18:57PM -0400, Robert Love wrote:

> The problem is that dec_and_lock.c is not being compiled (or at least
> the object isnt being included).  I believe this is caused by having bad
> dependencies.  My .depend has a dependency to compile the object -- I
> wager your's does not.
> 
> So... did you rerun `make dep' ?

I ALWAYS run make dep && make clean && make bzImage when building a new 
kernel 

> If not, try a fresh kernel tree and make sure to do `make oldconfig dep
> clean' after patching.
> 
> Please let me know because I am trying to track this down, and I don't
> have it happening to me.  I think this should do it.

It still borks, probably you are having other options in your kernel config
and sections you don't use may depend on dec_and_lock

> Of note, I will release a patch against 2.4.9-ac2 and 2.4.10-pre1 soon.

First get it to work, and then spend time on keeping it current with alan's
and linus' tree.

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
