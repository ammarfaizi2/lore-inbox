Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267437AbTAQI4x>; Fri, 17 Jan 2003 03:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267438AbTAQI4w>; Fri, 17 Jan 2003 03:56:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:56807 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267437AbTAQI4v>;
	Fri, 17 Jan 2003 03:56:51 -0500
Date: Fri, 17 Jan 2003 01:06:58 -0800
From: Andrew Morton <akpm@digeo.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59-mm1
Message-Id: <20030117010658.4900da96.akpm@digeo.com>
In-Reply-To: <20030117084600.GA26172@krispykreme>
References: <20030117002451.69f1eda1.akpm@digeo.com>
	<20030117084600.GA26172@krispykreme>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2003 09:05:44.0012 (UTC) FILETIME=[9DBAF8C0:01C2BE07]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
>  
> > -cputimes_stat.patch
> > 
> >  Not to Linus's taste.
> 
> Pity, I just had another reason to use this today (Checking if a network
> app was locking itself down to a cpu)

You can query that with sched_getaffinity()

> > -lockless-current_kernel_time.patch
> > 
> >  Is ia32-only.
> 
> We can fix that. Ive been avoiding it because it will take some non
> trivial cleanup of our ppc64 time.c. Based on how often get_current_time
> is appearing in profiles

Have you some numbers handy?

> and also how gettimeofday has been known to
> cause problems on large SMP (due to read_lock on xtime starving
> write_lock in the timer irq) I think this should get merged.
> 

OK.  I've had basically zero success getting non-ia32 people to test these
patches, and breaking their build won't help that.

But yes, this code needs to go ahead.
