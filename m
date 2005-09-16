Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161174AbVIPRPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbVIPRPU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161181AbVIPRPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:15:20 -0400
Received: from [139.30.44.2] ([139.30.44.2]:12864 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1161174AbVIPRPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:15:19 -0400
Date: Fri, 16 Sep 2005 19:15:17 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Tim Bird <tim.bird@am.sony.com>
cc: jesper.juhl@gmail.com, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
Subject: Re: early printk timings way off
In-Reply-To: <432AFB01.3050809@am.sony.com>
Message-ID: <Pine.LNX.4.61.0509161909500.31820@gans.physik3.uni-rostock.de>
References: <9a87484905091515495f435db7@mail.gmail.com> <432AFB01.3050809@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005, Tim Bird wrote:

> UPDATE:
> [Based on Tim Schmielau's analysis, maybe it's not the raw TSC
> value, but an unititialized jiffy value coming back from sched_clock().
> In this case, the value is worthless until after time_init().

Well, it's not uninitialized, but initialized to a very high value. So 
the differences between the large values still contain useful information.

> This may be why you're seeing a jump in the first "real" value
> returned.

Yep.

> Previously on x86, the pre-time_init() value was useful (wrong as an absolute
> number, but right in relatives values.)

This should still be the case.


So, one jump (probably the first) happens when time_init sets use_tsc.
Do we understand the other jump as well?

Tim
