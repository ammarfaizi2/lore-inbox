Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbUL0PUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbUL0PUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbUL0PUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:20:50 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:29863 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S261902AbUL0PUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:20:46 -0500
Date: Mon, 27 Dec 2004 23:20:37 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched-fix-scheduling-latencies-in-mttrc reenables interrupts
Message-ID: <20041227152037.GA4646@blackham.com.au>
References: <20041227062828.GE7415@blackham.com.au> <20041227013653.67965d46.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227013653.67965d46.akpm@osdl.org>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 01:36:53AM -0800, Andrew Morton wrote:
> Not OK.  That global `sal_flags' is not protected by the spinlock
> because spin_lock_irqsave() saves the flags before taking the
> lock.

Ahh, d'oh.

> How about this?
> 
> diff -puN arch/i386/kernel/cpu/mtrr/generic.c~sched-fix-scheduling-latencies-in-mttrc-reenables-interrupts arch/i386/kernel/cpu/mtrr/generic.c

Won't object here.

Thanks,

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
