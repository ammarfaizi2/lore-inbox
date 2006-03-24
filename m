Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWCXXTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWCXXTf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWCXXTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:19:35 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:31875 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932213AbWCXXTe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:19:34 -0500
Subject: Re: [PATCH]
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <200603242307.k2ON7TK0007932@dhcp153.mvista.com>
References: <200603242307.k2ON7TK0007932@dhcp153.mvista.com>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 15:19:32 -0800
Message-Id: <1143242372.26994.13.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 15:07 -0800, Daniel Walker wrote:
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.16/kernel/time/timeofday.c
> ===================================================================
> --- linux-2.6.16.orig/kernel/time/timeofday.c
> +++ linux-2.6.16/kernel/time/timeofday.c
> @@ -644,7 +644,7 @@ static void timeofday_periodic_hook(unsi
>  
>  	int something_changed = 0;
>   	int clocksource_changed = 0;
> -	struct clocksource old_clock;
> +	struct clocksource old_clock = { .mult = 1, .shift = 0 };
>  	static s64 second_check;
>  
>  	write_seqlock_irqsave(&system_time_lock, flags);

I assume this is a fix for the GCC "may be used uninitialized" warning?

thanks
-john

