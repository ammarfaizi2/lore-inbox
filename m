Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbUAVP2F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264901AbUAVP2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:28:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:5084 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264608AbUAVP15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:27:57 -0500
Date: Thu, 22 Jan 2004 07:27:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Richard Henderson <rth@twiddle.net>
cc: Valdis.Kletnieks@vt.edu,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm5 versus gcc 3.5 snapshot
In-Reply-To: <20040122060253.GA18719@twiddle.net>
Message-ID: <Pine.LNX.4.58.0401220725180.2123@home.osdl.org>
References: <200401212236.i0LMaNuh020491@turing-police.cc.vt.edu>
 <Pine.LNX.4.58.0401212043200.2123@home.osdl.org> <20040122060253.GA18719@twiddle.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jan 2004, Richard Henderson wrote:
> 
> You're reading that wrong way-round.  It's "+m" and "=m"/"0" that's
> disallowed.

Ok, but...

>	  I.e. if you have matching constraints (or read-write
> constrants, which are exactly short-hand for matching constraints),
> then you *must* have a register alternative.  I.e. you'll get this
> warning if you *only* allow memories.
> 
> The problem is partially conceptual -- what in the world does
> 
> 	"=m"(x) : "0"(y)

I agree about the latter one, but "+m" (which is what the kernel uses) has
well-defined meaning, and the compiler would be/is silly to complain about
it.

So your arguments fall down flat. If it was

	"=m" (x) : "0" (y)

I'd agree with you, but that's not the code the compiler complains about.

Shorthand or not, the "+m" usage is (a) totally logical and (b) 
historically allowed.

Please fix the compiler.

		Linus
