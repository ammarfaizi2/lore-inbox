Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWCWTzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWCWTzl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWCWTzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:55:41 -0500
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:1544 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750730AbWCWTzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:55:40 -0500
Date: Thu, 23 Mar 2006 20:56:17 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Christopher Hoover <ch@murgatroid.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up magic numbers in i2c_parport.h
Message-Id: <20060323205617.38e02afe.khali@linux-fr.org>
In-Reply-To: <20060323081231.D794B1EC019@garage.murgatroid.com>
References: <20060323081231.D794B1EC019@garage.murgatroid.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

> This small patch gets rid of some magic numbers in the i2c parport
> drivers, specifically wrt the control and status handling, using the
> symbols already defined in parport.h
> 
> The patch produces the same binary objects for i2c-parport.c and
> i2c-parport-simple.c as before.

> --- linux-2.6.16/drivers/i2c/busses/i2c-parport.h	2006-03-19 21:53:29.000000000 -0800
> +++ linux-2.6.16.i2c/drivers/i2c/busses/i2c-parport.h	2006-03-22 23:51:08.000000000 -0800
> (...)
> +#define LINEOP_DATA(val_, inverted_) \
> +   { .val=(val_), .port = DATA, .inverted=(inverted_) }
> +
> +#define LINEOP_STATUS(val_, inverted_) \
> +   { .val=(val_), .port = STAT, .inverted=(inverted_) }
> +
> +#define LINEOP_CONTROL(val_, inverted_) \
> +   { .val=(val_), .port = CTRL, .inverted=(inverted_) }
> +

Beeuh. These macros don't really help. They actually make the lines
longer! I'm not taking this change, sorry.

Other than that, I am fine with your patch. Not that I really see the
benefit, but it others do, why not. Can you please respin the patch
without the additional macros?

Thanks,
-- 
Jean Delvare
