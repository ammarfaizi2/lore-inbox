Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289699AbSAWGAo>; Wed, 23 Jan 2002 01:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289697AbSAWGAf>; Wed, 23 Jan 2002 01:00:35 -0500
Received: from [202.135.142.196] ([202.135.142.196]:58380 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S289699AbSAWGAX>; Wed, 23 Jan 2002 01:00:23 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Anton Blanchard <anton@samba.org>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] One-liner typo 2.5.3-pre3 in ppc/kernel/idle.c 
In-Reply-To: Your message of "Wed, 23 Jan 2002 16:31:18 +1100."
             <20020123053118.GB14366@krispykreme> 
Date: Wed, 23 Jan 2002 17:00:25 +1100
Message-Id: <E16TGSQ-0000sN-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020123053118.GB14366@krispykreme> you write:
> We atomically grab the current value of need_resched and replace it with
> -1. The -1 tells the scheduler that we are busy looping and it doesnt need
> to send an IPI to force a reschedule.

Yes, but the replacment loop was completely wrong.  Sure, with my
patch this optimization isn't there, but at least it will work as
designed...

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
