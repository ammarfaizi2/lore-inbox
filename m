Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbTAQIia>; Fri, 17 Jan 2003 03:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267432AbTAQIia>; Fri, 17 Jan 2003 03:38:30 -0500
Received: from dp.samba.org ([66.70.73.150]:22659 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267429AbTAQIia>;
	Fri, 17 Jan 2003 03:38:30 -0500
Date: Fri, 17 Jan 2003 19:46:00 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59-mm1
Message-ID: <20030117084600.GA26172@krispykreme>
References: <20030117002451.69f1eda1.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117002451.69f1eda1.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> -cputimes_stat.patch
> 
>  Not to Linus's taste.

Pity, I just had another reason to use this today (Checking if a network
app was locking itself down to a cpu)

> -lockless-current_kernel_time.patch
> 
>  Is ia32-only.

We can fix that. Ive been avoiding it because it will take some non
trivial cleanup of our ppc64 time.c. Based on how often get_current_time
is appearing in profiles and also how gettimeofday has been known to
cause problems on large SMP (due to read_lock on xtime starving
write_lock in the timer irq) I think this should get merged.

Anton
