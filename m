Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWAZUeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWAZUeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWAZUeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:34:21 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:55545 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S964866AbWAZUeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:34:20 -0500
Message-ID: <43D9317D.6070509@mvista.com>
Date: Thu, 26 Jan 2006 12:30:53 -0800
From: George Anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/posix-timers.c: remove do_posix_clock_notimer_create()
References: <20060126095002.GX3590@stusta.de>
In-Reply-To: <20060126095002.GX3590@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>This function is neither used nor has any real contents.
>
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>  
>
Looks good to me.
George (please note new address)

>---
>
>This patch was already sent on:
>- 20 Jan 2006
>- 7 Jan 2006
>
> include/linux/posix-timers.h |    1 -
> kernel/posix-timers.c        |    6 ------
> 2 files changed, 7 deletions(-)
>
>--- linux-2.6.15-mm2-full/include/linux/posix-timers.h.old	2006-01-07 23:13:08.000000000 +0100
>+++ linux-2.6.15-mm2-full/include/linux/posix-timers.h	2006-01-07 23:13:17.000000000 +0100
>@@ -84,7 +84,6 @@
> void register_posix_clock(const clockid_t clock_id, struct k_clock *new_clock);
> 
> /* error handlers for timer_create, nanosleep and settime */
>-int do_posix_clock_notimer_create(struct k_itimer *timer);
> int do_posix_clock_nonanosleep(const clockid_t, int flags, struct timespec *,
> 			       struct timespec __user *);
> int do_posix_clock_nosettime(const clockid_t, struct timespec *tp);
>--- linux-2.6.15-mm2-full/kernel/posix-timers.c.old	2006-01-07 23:13:25.000000000 +0100
>+++ linux-2.6.15-mm2-full/kernel/posix-timers.c	2006-01-07 23:13:30.000000000 +0100
>@@ -875,12 +875,6 @@
> }
> EXPORT_SYMBOL_GPL(do_posix_clock_nosettime);
> 
>-int do_posix_clock_notimer_create(struct k_itimer *timer)
>-{
>-	return -EINVAL;
>-}
>-EXPORT_SYMBOL_GPL(do_posix_clock_notimer_create);
>-
> int do_posix_clock_nonanosleep(const clockid_t clock, int flags,
> 			       struct timespec *t, struct timespec __user *r)
> {
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
