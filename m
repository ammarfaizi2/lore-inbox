Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161100AbWBNVDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbWBNVDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWBNVDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:03:04 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:35602 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1161100AbWBNVDD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:03:03 -0500
Date: Tue, 14 Feb 2006 22:03:13 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove duplicate #includes
Message-Id: <20060214220313.1158be5b.khali@linux-fr.org>
In-Reply-To: <20060213093959.GA10496@MAIL.13thfloor.at>
References: <20060213093959.GA10496@MAIL.13thfloor.at>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

> recently I stumbled over a few files which #include the 
> same .h file twice -- sometimes even in the immediately
> following line. so I thought I'd look into that to reduce 
> the amount of duplicate includes in the kernel ...
> (...)
> diff -NurpP --minimal linux-2.6.16-rc2/drivers/macintosh/therm_pm72.c linux-2.6.16-rc2-mpf/drivers/macintosh/therm_pm72.c
> --- linux-2.6.16-rc2/drivers/macintosh/therm_pm72.c	2006-02-07 11:52:31 +0100
> +++ linux-2.6.16-rc2-mpf/drivers/macintosh/therm_pm72.c	2006-02-13 02:07:58 +0100
> @@ -104,7 +104,6 @@
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/sched.h>
> -#include <linux/i2c.h>
>  #include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/spinlock.h>

This one was already taken care of in a different patch:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc3/2.6.16-rc3-mm1/broken-out/macintosh-cleanup-the-use-of-i2c-headers.patch

So please exclude this part from your patch so as to avoid collisions.

Thanks,
-- 
Jean Delvare
