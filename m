Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTKWFoU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 00:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTKWFoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 00:44:19 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:4100 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263274AbTKWFoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 00:44:18 -0500
Date: Sun, 23 Nov 2003 06:43:37 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 oops
Message-ID: <20031123054337.GA5001@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20031122054904.GA3656@middle.of.nowhere> <20031123011805.GT22764@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031123011805.GT22764@holomorphy.com>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, Nov 22, 2003 at 05:18:05PM -0800
> On Sat, Nov 22, 2003 at 06:49:04AM +0100, Jurriaan wrote:
> > Nov 21 21:25:40 middle kernel: ------------[ cut here ]------------
> > Nov 21 21:25:40 middle kernel: kernel BUG at arch/i386/mm/fault.c:357!
> > Nov 21 21:25:40 middle kernel: invalid operand: 0000 [#1]
> 
> 
> diff -prauN mm4-2.6.0-test9-1/mm/memory.c mm4-2.6.0-test9-default-2/mm/memory.c
> --- mm4-2.6.0-test9-1/mm/memory.c	2003-11-19 00:07:15.000000000 -0800
> +++ mm4-2.6.0-test9-default-2/mm/memory.c	2003-11-19 18:08:49.000000000 -0800
> @@ -1424,7 +1424,7 @@ do_no_page(struct mm_struct *mm, struct 
>  	pte_t entry;
>  	struct pte_chain *pte_chain;
>  	int sequence = 0;
> -	int ret;
> +	int ret = VM_FAULT_MINOR;
>  
>  	if (!vma->vm_ops || !vma->vm_ops->nopage)
>  		return do_anonymous_page(mm, vma, page_table,

Thanks. It only happened once, so I don't think I can reproduce or test
this...

Jurriaan
-- 
Big Brother tries to stitch and bend
but channel surfers find new friends
        Midnight Oil - Golden Age
Debian (Unstable) GNU/Linux 2.6.0-test9-mm4 4276 bogomips 0.71 0.44
