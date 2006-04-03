Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWDCVNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWDCVNI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 17:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWDCVNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 17:13:07 -0400
Received: from www.osadl.org ([213.239.205.134]:32910 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751404AbWDCVNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 17:13:06 -0400
Subject: Re: [PATCH] add cpu_relax to hrtimer_cancel
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: joe.korty@ccur.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060403180037.GA21038@tsunami.ccur.com>
References: <20060403180037.GA21038@tsunami.ccur.com>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 23:13:18 +0200
Message-Id: <1144098798.5344.386.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 14:00 -0400, Joe Korty wrote:
> Add a cpu_relax() to the hand-coded spinwait in hrtimer_cancel().
> 
> Signed-off-by: Joe Korty <joe.korty@ccur.com>
> 
> 
>  2.6.17-rc1-jak/kernel/hrtimer.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puNa kernel/hrtimer.c~add.cpu_relax.to.hrtimer_cancel kernel/hrtimer.c
> --- 2.6.17-rc1/kernel/hrtimer.c~add.cpu_relax.to.hrtimer_cancel	2006-04-03 13:40:05.000000000 -0400
> +++ 2.6.17-rc1-jak/kernel/hrtimer.c	2006-04-03 13:41:06.000000000 -0400
> @@ -501,6 +501,7 @@ int hrtimer_cancel(struct hrtimer *timer
>  
>  		if (ret >= 0)
>  			return ret;
> +		cpu_relax();
>  	}
>  }
>  
> 
> _

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Doh. It had been there once ..:)


