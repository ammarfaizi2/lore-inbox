Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVKGQRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVKGQRo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVKGQRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:17:43 -0500
Received: from peabody.ximian.com ([130.57.169.10]:53956 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S964860AbVKGQRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:17:40 -0500
Subject: Re: [question] I doublt on timer interrput.
From: Robert Love <rml@novell.com>
To: liyu <liyu@ccoss.com.cn>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <436EEEA4.1020703@ccoss.com.cn>
References: <436EEEA4.1020703@ccoss.com.cn>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 11:16:13 -0500
Message-Id: <1131380173.15756.6.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 14:05 +0800, liyu wrote:
> Hi, all:
> 
>     I have one question about timer interrupt (i386 architecture).
> 
>     As we known, the timer emit HZ times interrputs per second,
> and in i386. The interrupt handler will call scheduler_tick()
> each time (on i386 at least, both enable or disable APIC).
> 
>     On my Celeron machine(IOW, only one CPU, not SMP/SMT), I defined
> a global int variable 'tick_count' in kernel/sched.c, and add one line
> of code like follow in scheduler_tick():
> 
>     ++tick_count;
> 
>     but I found it is not same with content of the /proc/interrupts,
> and the differennt between them is not little.
>    
>     I can not understand why that is.
>    
>     Any useful idea.

scheduler_tick() is not the timer interrupt.

You want to hook into do_timer() or similar.

	Robert Love


