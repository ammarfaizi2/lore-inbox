Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130390AbRBKXGR>; Sun, 11 Feb 2001 18:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130642AbRBKXGH>; Sun, 11 Feb 2001 18:06:07 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:48633 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S130390AbRBKXF6>;
	Sun, 11 Feb 2001 18:05:58 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hot swap CPU support for 2.4.1 
In-Reply-To: Your message of "Sun, 11 Feb 2001 00:29:55 BST."
             <20010211002955.I7877@bug.ucw.cz> 
Date: Mon, 12 Feb 2001 10:05:35 +1100
Message-Id: <E14S5Ym-0003m4-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010211002955.I7877@bug.ucw.cz> you write:
> This is not quite right:
> 
> @@ -1643,7 +1643,7 @@
>                 printk(KERN_NOTICE "apm: disabled on user
> request.\n");
>                 return -ENODEV;
>         }
> -       if ((smp_num_cpus > 1) && !power_off) {
> +       if ((num_online_cpus() > 1) && !power_off) {
>                 printk(KERN_NOTICE "apm: disabled - APM is not SMP
> 
> I do not think it is safe to call APM when there is just CPU #5
> running. smp_num_cpus in this context means "if we ever had more than
> boot cpu".

Um, it's not safe to call APM in SMP full stop: we try anyway.
However, this code changes nothing since it's only run at boot.

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
