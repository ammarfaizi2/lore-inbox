Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUH2Hjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUH2Hjo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 03:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267341AbUH2Hjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 03:39:43 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:19688 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S267334AbUH2Hjl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 03:39:41 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q3
Date: Sun, 29 Aug 2004 00:40:11 -0700
User-Agent: KMail/1.7
Cc: Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
References: <20040823221816.GA31671@yoda.timesys> <200408282210.03568.pnambic@unu.nu> <20040828203116.GA29686@elte.hu>
In-Reply-To: <20040828203116.GA29686@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408290040.14028.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had this ambitional feeling to port this over to the mm tree. 

So here's a link for Q3 .. 

http://mobius.lpbproductions.com/kernel/voluntary-preempt-2.6.9-rc1-mm1-Q3

I test compiled this patch fine. I havent had time yet to boot up onto it. But 
I'm fairly positive it will work.

Matt H.

On Saturday 28 August 2004 1:31 pm, Ingo Molnar wrote:
> * Daniel Schmitt <pnambic@unu.nu> wrote:
> > > there's a Kconfig chunk missing from the Q0/Q1 patches, i've uploaded
> > > Q2 that fixes this:
> >
> > This breaks here unless CONFIG_SMP is defined, with the following error:
> >
> >   CC      arch/i386/kernel/asm-offsets.s
> > In file included from arch/i386/kernel/asm-offsets.c:7:
> > include/linux/sched.h: In function `lock_need_resched':
> > include/linux/sched.h:983: error: structure has no member named
> > `break_lock'
> >
> > Probably missing a check for CONFIG_SMP around the need_lockbreak
> > defines in sched.h, and maybe also in cond_resched_lock().
>
> doh - right indeed. -Q3 has this fixed, it is at:
>
>  
> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-
>Q3
>
> ontop of the usual:
>
>   http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2
>
>         Ingo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
