Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318046AbSHHX0U>; Thu, 8 Aug 2002 19:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318066AbSHHX0U>; Thu, 8 Aug 2002 19:26:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58385 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318046AbSHHX0T>; Thu, 8 Aug 2002 19:26:19 -0400
Date: Fri, 9 Aug 2002 00:29:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc, mips, m68k, sh, cris to use it
Message-ID: <20020809002958.B20257@flint.arm.linux.org.uk>
References: <1028842995.1669.70.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1028842995.1669.70.camel@ldb>; from ldb@ldb.ods.org on Thu, Aug 08, 2002 at 11:43:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 11:43:15PM +0200, Luca Barbieri wrote:
>...

Please don't do this for ARM.

> -static inline int atomic_dec_and_test(volatile atomic_t *v)
> -{
> -	unsigned long flags;
> -	int val;
> -
> -	local_irq_save(flags);
> -	val = v->counter;
> -	v->counter = val -= 1;
> -	local_irq_restore(flags);
> -
> -	return val == 0;
> -}

This C code is carefully optimised to allow the compiler to order things
efficiently.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

