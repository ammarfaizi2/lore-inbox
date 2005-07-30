Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263025AbVG3JYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbVG3JYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 05:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVG3JYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 05:24:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44164 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263021AbVG3JXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 05:23:21 -0400
Date: Sat, 30 Jul 2005 11:23:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ucb1x00: touchscreen cleanups
Message-ID: <20050730092315.GA2013@elf.ucw.cz>
References: <20050726074627.GA11975@elf.ucw.cz> <20050730101744.A9652@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730101744.A9652@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > @@ -55,20 +54,6 @@ struct ucb1x00_ts {
> >  
> >  static int adcsync;
> >  
> > -static inline void ucb1x00_ts_evt_add(struct ucb1x00_ts *ts, u16 pressure, u16 x, u16 y)
> > -{
> > -	input_report_abs(&ts->idev, ABS_X, x);
> > -	input_report_abs(&ts->idev, ABS_Y, y);
> > -	input_report_abs(&ts->idev, ABS_PRESSURE, pressure);
> > -	input_sync(&ts->idev);
> > -}
> > -
> > -static inline void ucb1x00_ts_event_release(struct ucb1x00_ts *ts)
> > -{
> > -	input_report_abs(&ts->idev, ABS_PRESSURE, 0);
> > -	input_sync(&ts->idev);
> > -}
> > -
> 
> Only one query: What's the reason for moving these?  I think keeping
> them makes the code more readable.

Vojtech liked that better after moving, and it is few lines shorter,
but I have no strong feelings about that.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
