Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263022AbVG3JSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbVG3JSC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 05:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbVG3JSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 05:18:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36875 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263022AbVG3JRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 05:17:50 -0400
Date: Sat, 30 Jul 2005 10:17:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ucb1x00: touchscreen cleanups
Message-ID: <20050730101744.A9652@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
References: <20050726074627.GA11975@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050726074627.GA11975@elf.ucw.cz>; from pavel@ucw.cz on Tue, Jul 26, 2005 at 09:46:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 09:46:27AM +0200, Pavel Machek wrote:
> @@ -55,20 +54,6 @@ struct ucb1x00_ts {
>  
>  static int adcsync;
>  
> -static inline void ucb1x00_ts_evt_add(struct ucb1x00_ts *ts, u16 pressure, u16 x, u16 y)
> -{
> -	input_report_abs(&ts->idev, ABS_X, x);
> -	input_report_abs(&ts->idev, ABS_Y, y);
> -	input_report_abs(&ts->idev, ABS_PRESSURE, pressure);
> -	input_sync(&ts->idev);
> -}
> -
> -static inline void ucb1x00_ts_event_release(struct ucb1x00_ts *ts)
> -{
> -	input_report_abs(&ts->idev, ABS_PRESSURE, 0);
> -	input_sync(&ts->idev);
> -}
> -

Only one query: What's the reason for moving these?  I think keeping
them makes the code more readable.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
