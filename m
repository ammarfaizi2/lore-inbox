Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284837AbRL2AHY>; Fri, 28 Dec 2001 19:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284866AbRL2AHO>; Fri, 28 Dec 2001 19:07:14 -0500
Received: from are.twiddle.net ([64.81.246.98]:42727 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S284837AbRL2AHC>;
	Fri, 28 Dec 2001 19:07:02 -0500
Date: Fri, 28 Dec 2001 16:07:00 -0800
From: Richard Henderson <rth@twiddle.net>
To: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Alpha/Linux ] Stack layout/and register values for ret_from_sys_call
Message-ID: <20011228160700.B30611@twiddle.net>
Mail-Followup-To: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1008613257.22228.3.camel@satan.xko.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1008613257.22228.3.camel@satan.xko.dec.com>; from aneesh.kumar@digital.com on Mon, Dec 17, 2001 at 11:50:57PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 11:50:57PM +0530, Aneesh Kumar K.V wrote:
>  Can someone explain me what should be the stack layout and register
> value( if there is any restriction ) before calling ret_from_syscall for
> Alpha.

Top of stack should contain a struct pt_regs.  See asm/ptrace.h.

>   lda     $8,0x3fff
>   bic     $30,$8,$8
> 
> If someone can expain what happens in the above two assembly statement
> it will be really helpful.

This computes the value for "current".  The stack plus task structure
is aligned on a two-page boundary.  See task_union in linux/sched.h.


r~
