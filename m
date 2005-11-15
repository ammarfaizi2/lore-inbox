Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVKONKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVKONKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 08:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVKONKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 08:10:47 -0500
Received: from barclay.balt.net ([195.14.162.78]:59011 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S932485AbVKONKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 08:10:46 -0500
Date: Tue, 15 Nov 2005 15:08:59 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, yi.zhu@intel.com,
       jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051115130859.GA9910@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org> <20051115100519.GA5567@gemtek.lt> <20051115115657.GA30489@gemtek.lt> <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pekka, 

I will apply the patch and will rerun test again. No problem.
Compiling ...

Zilvinas Valinskas

On Tue, Nov 15, 2005 at 02:51:16PM +0200, Pekka Enberg wrote:
> Hi Zilvinas,
> 
> On 11/15/05, Zilvinas Valinskas <zilvinas@gemtek.lt> wrote:
> > Eventually kernel will freeze (I can trigger this reliably, tried 3
> > times and it "worked" 3 times as well). Although I've seen no error message
> > printed to console - sysrq-T always shows the same stack trace (in
> > wpa_supplicant context:
> 
> [snip]
> 
> > http://www.gemtek.lt/~zilvinas/backtrace.jpg
> 
> Would be helpful to see the oops message... If you don't have serial
> console handy, you can do the below to disable the call trace.
> 
>                          Pekka
> 
> Index: 2.6/arch/i386/kernel/traps.c
> ===================================================================
> --- 2.6.orig/arch/i386/kernel/traps.c
> +++ 2.6/arch/i386/kernel/traps.c
> @@ -185,8 +185,10 @@ void show_stack(struct task_struct *task
>  			printk("\n       ");
>  		printk("%08lx ", *stack++);
>  	}
> +#if 0
>  	printk("\nCall Trace:\n");
>  	show_trace(task, esp);
> +#endif
>  }
> 
>  /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
