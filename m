Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266174AbUHBG0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUHBG0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 02:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUHBG0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:26:22 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:51716 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266174AbUHBG0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:26:21 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: lkml@lpbproduction.scom
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mingo@redhat.com
In-Reply-To: <200408011644.06537.lkml@lpbproductions.com>
References: <20040713143947.GG21066@holomorphy.com>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <200408011644.06537.lkml@lpbproductions.com>
Content-Type: text/plain
Date: Mon, 02 Aug 2004 08:26:04 +0200
Message-Id: <1091427964.1827.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 16:44 -0700, Matt Heler wrote:
> Ingo,
> 
> I get the following error below on with your patch applied on stock 
> 2.6.8-rc2 ...
> 
>   CC      kernel/softirq.o
>   CC      kernel/hardirq.o
> kernel/hardirq.c:51: error: conflicting types for 'generic_handle_IRQ_event'
> include/linux/irq.h:78: error: previous declaration of 
> 'generic_handle_IRQ_event' was here
> kernel/hardirq.c:51: error: conflicting types for 'generic_handle_IRQ_event'
> include/linux/irq.h:78: error: previous declaration of 
> 'generic_handle_IRQ_event' was here
> make[1]: *** [kernel/hardirq.o] Error 1
> make: *** [kernel] Error 2

Try removing the "asmlinkage" from the definition of
"generic_handle_IRQ_event" in file "kernel/hardirq.c".

