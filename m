Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268479AbUJUQNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268479AbUJUQNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270778AbUJUQJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:09:11 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:4104 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S270765AbUJUQH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:07:27 -0400
Message-ID: <4177E17F.10104@techsource.com>
Date: Thu, 21 Oct 2004 12:19:11 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <1098334097.9402.958.camel@cube>
In-Reply-To: <1098334097.9402.958.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Albert Cahalan wrote:
> Timothy Miller writes:
> 
> 
>>(2) How much would you be willing to pay for it?
>>
>>(3) How do you feel about the choice of neglecting
>>3D performance as a priority?  How important is 3D
>>performance?  In what cases is it not?
>>
>>(4) How much extra would you be willing to pay for
>>excellent 3D performance?
>>
>>(5) What's most important to you, performance, price,
>>or stability?
> 
> 
> Stability with a kernel of my choice on possibly
> non-x86 hardware matters most. Digital DVI, fanless
> operation, and DVD scaling are next. After that, 3D.

My aside from the DVD bit, my original 2D concept would make all of that 
possible.

So, say you decide that you want to use this card for some obscure 
variant of BSD or an Amiga or something, and you're having some trouble 
with the porting of the available drivers, I'd be happy to assist in 
that process.

> 
> I'm not so sure you have to give up 3D. You can put
> at least 4 AltiVec-capable "G4" CPUs on a PCI board
> without having horrible power and temperature issues.
> (Perhaps an AGP board can safely support even more.)
> Each will do 4 32-bit floating-point fused-multiply-add
> operations per cycle. That's got to be good for something.
> I think the latest chips have built-in memory interfaces.
> They have RapidIO interfaces. So you make your FPGA
> speak RapidIO protocol (easy) and have each CPU render
> every fourth frame.

A CPU and a GPU don't do the same things.  A GPU naturally parallelizes 
things, both in time (pipelining of rendering functions) and space 
(multiple pipelines).  A CPU, even a superscalar one, does things in 
essentially a sequential fashion.  Thus, a 200Mhz GPU will absolutely 
cream your 1Ghz G4 in graphics performance, even WITH clever AltiVec 
hacks.  Dedicated hardware is ALWAYS going to be faster than doing it in 
  software.

That being said, I'm not rejecting your G4 idea out-right.  While you 
can't expect stellar performance out of it, you CAN program it to do 
absolutely every kind of 3D rendering you want.

I'm going to propose this as a possible solution to the problem.


> One could even put the X server on the card.

'Tis true.

> 
> Ultimately, this is a huge risk, with potentially
> great reward. One must take some risks to succeed,
> and this one is a whopper.
> 
> 
> 
> 

