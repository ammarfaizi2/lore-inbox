Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269862AbUJGW0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269862AbUJGW0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269851AbUJGW0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:26:13 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:25191 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267961AbUJGWY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:24:57 -0400
Subject: Re: strange AMD x Intel Behaviour in 2.4.26
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m31xga2oly.fsf@averell.firstfloor.org>
References: <2MLlk-5MH-5@gated-at.bofh.it>
	 <m31xga2oly.fsf@averell.firstfloor.org>
Content-Type: text/plain
Date: Thu, 07 Oct 2004 19:25:54 -0300
Message-Id: <1097187954.3790.15.camel@lfs.barra.bali>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 23:40 +0200, Andi Kleen wrote:
> Fabiano Ramos <ramos_fabiano@yahoo.com.br> writes:
> 
> >   The code is producing correct results (same as ptrace, I mean)
> > but is RUNNING FASTER on a 500Mhz AMD K6-2 than on a 2.6Ghz HT
> > Pentium 4 !!!!  The monitored code runs faster on P4 if not being
> 
> The Pentium 4 is slow for anything that involves changing of the 
> ring or an exception. Well known problem, you can see it in other
> benchmarks too. Normally the penalty is not that drastic, probably
> it doesn't like single stepping very much.
> 
> However a cheaper way to do this would be to use performance counters
> and save/restore them on each context switch. There is normally a
> perfctr for "retired instructions on ring 3", which is what you
> want. Mikael P's perfctr patchkit can do that per process.
> 

OK, I'll check it.  But I will still need to stick with the stop-at-
every-instruction approach, since this counting is just the start of
my project. I am developing a intepretation-like scheme, and need do
do some action at every instruction. The counting was just the stopping
mechanism.   I do not use ptrace, since I want to do it in kernel space.

Thanks, it was giving me nightmares :(


> -Andi
> 

