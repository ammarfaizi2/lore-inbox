Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbULMV5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbULMV5b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbULMV5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:57:30 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:44194 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261192AbULMV5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:57:13 -0500
Subject: Re: [2.6 patch] kernel/time.c: possible cleanups
From: john stultz <johnstul@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: lkml <linux-kernel@vger.kernel.org>, ulrich.windl@rz.uni-regensburg.de
In-Reply-To: <20041212200600.GS22324@stusta.de>
References: <20041212200600.GS22324@stusta.de>
Content-Type: text/plain
Message-Id: <1102975027.1281.433.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Dec 2004 13:57:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-12 at 12:06, Adrian Bunk wrote:
> The patch below contains some possible cleanups.
> 
> I don't claim it's correct, but since all these variables are never 
> changed it doesn't make a difference.
> 
> --- linux-2.6.10-rc2-mm4-full/include/linux/timex.h.old	2004-12-12 03:27:38.000000000 +0100
> +++ linux-2.6.10-rc2-mm4-full/include/linux/timex.h	2004-12-12 03:28:09.000000000 +0100
> @@ -249,19 +249,11 @@
>  extern long time_next_adjust;	/* Value for time_adjust at next tick */
>  
>  /* interface variables pps->timer interrupt */
> -extern long pps_offset;		/* pps time offset (us) */
>  extern long pps_jitter;		/* time dispersion (jitter) (us) */
>  extern long pps_freq;		/* frequency offset (scaled ppm) */
>  extern long pps_stabil;		/* frequency dispersion (scaled ppm) */
>  extern long pps_valid;		/* pps signal watchdog counter */
>  
> -/* interface variables pps->adjtimex */
> -extern int pps_shift;		/* interval duration (s) (shift) */
> -extern long pps_jitcnt;		/* jitter limit exceeded */
> -extern long pps_calcnt;		/* calibration intervals */
> -extern long pps_errcnt;		/* calibration errors */
> -extern long pps_stbcnt;		/* stability limit exceeded */
> -

There's an out of tree PPS patch that used those values, but since its
out of tree it could just pick up the reversed change. Really, I'm not
sure if anyone is using it. 

Ulrich? Do you have any comments?

thanks
-john


