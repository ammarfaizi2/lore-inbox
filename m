Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbUKDKXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbUKDKXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 05:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbUKDKXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 05:23:46 -0500
Received: from sartre.ispvip.biz ([209.118.182.154]:7857 "HELO
	sartre.ispvip.biz") by vger.kernel.org with SMTP id S262156AbUKDKXn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 05:23:43 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
From: "Michael J. Cohen" <mjc@unre.st>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, sboyce@blueyonder.co.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041104100634.GA29785@elte.hu>
References: <4189108C.2050804@blueyonder.co.uk>
	 <41892899.6080400@cybsft.com> <41897119.6030607@blueyonder.co.uk>
	 <418988A6.4090902@cybsft.com>  <20041104100634.GA29785@elte.hu>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 05:23:25 -0500
Message-Id: <1099563805.30372.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 11:06 +0100, Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> > >include/asm/vsyscall.h:48: error: previous declaration of `__xtime_lock'
> > 
> > Does the patch below fix the above error?
> 
> i applied your earlier patch but many more changes were needed to port
> PREEMPT_REALTIME (and in particular, PREEMPT_HARDIRQS) to x64. You can
> check out the x64 bits in -V0.7.8 which can be downloaded from the usual
> place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> Sid, does this one build/work for you? (i had to disable CPUFREQ in the
> .config to get it to build - an -mm bug i suspect.)
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Ingo
	Great timing! only 7 minutes after I posted my concession speech. ;)

Here you go:

  LD      .tmp_vmlinux1
kernel/built-in.o(.text+0x1e57c): In function `___trace':
: undefined reference to `irqs_disabled_flags'
kernel/built-in.o(.text+0x1e797): In function `add_preempt_count':
: undefined reference to `irqs_disabled_flags'
make: *** [.tmp_vmlinux1] Error 1

------
Michael Cohen

