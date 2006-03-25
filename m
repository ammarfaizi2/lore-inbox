Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWCYWin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWCYWin (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 17:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbWCYWin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 17:38:43 -0500
Received: from ns2.suse.de ([195.135.220.15]:63375 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751333AbWCYWim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 17:38:42 -0500
From: Andreas Schwab <schwab@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Parenthesize macros in xfs
References: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr>
	<20060321082327.B653275@wobbly.melbourne.sgi.com>
	<Pine.LNX.4.61.0603202239110.11933@yvahk01.tjqt.qr>
	<20060321084619.E653275@wobbly.melbourne.sgi.com>
	<Pine.LNX.4.61.0603252232570.18484@yvahk01.tjqt.qr>
X-Yow: Am I elected yet?
Date: Sat, 25 Mar 2006 23:38:40 +0100
In-Reply-To: <Pine.LNX.4.61.0603252232570.18484@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Sat, 25 Mar 2006 22:35:07 +0100 (MET)")
Message-ID: <je1wwq2lqn.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> diff -dpru xfs-mod-01/support/qsort.c xfs-mod-02/support/qsort.c
> --- xfs-mod-01/support/qsort.c	2005-09-23 05:51:28.000000000 +0200
> +++ xfs-mod-02/support/qsort.c	2006-03-25 22:20:37.055287000 +0100
> @@ -55,13 +55,14 @@ swapfunc(char *a, char *b, int n, int sw
>  		swapcode(char, a, b, n)
>  }
>  
> -#define swap(a, b)					\
> +#define swap(a, b) do {					\
>  	if (swaptype == 0) {				\
>  		long t = *(long *)(a);			\
>  		*(long *)(a) = *(long *)(b);		\
>  		*(long *)(b) = t;			\
>  	} else						\
> -		swapfunc(a, b, es, swaptype)
> +		swapfunc(a, b, es, swaptype)		\
> +} while(0)
                                           ^^

Missing semicolon.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
