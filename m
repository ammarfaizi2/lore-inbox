Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136975AbREJWpY>; Thu, 10 May 2001 18:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136976AbREJWpE>; Thu, 10 May 2001 18:45:04 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22803 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136975AbREJWo4>; Thu, 10 May 2001 18:44:56 -0400
To: linux-kernel@vger.kernel.org
From: hpa@transmeta.com (H. Peter Anvin)
Subject: Re: Wow! Is memory ever cheap!
Date: 10 May 2001 15:44:10 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9df5jq$8dq$1@tazenda.transmeta.com>
In-Reply-To: <lm@bitmover.com> <200105090424.AAA05768@soyata.home> <20010508222210.B14758@work.bitmover.com> <3AF9B0D2.F2E330F9@gmx.de>
Reply-To: hpa@transmeta.com (H. Peter Anvin)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3AF9B0D2.F2E330F9@gmx.de>
By author:    Edgar Toernig <froese@gmx.de>
In newsgroup: linux.dev.kernel
> 
> I think you have a wrong idea why the ECC is there.  ECC deals with
> the inherit shortcommings of DRAM.
> 
> DRAMs are not perfect.  They have a probability to lose a bit.
> Normally this probability is low enough to live with it.  Lets say
> you have a system with 1MByte and let's say the probability for a
> single bit error is around 1 error in 100 years.  Good enough.
> Now put 1GByte in the system. You'll get a probability of 10 errors
> per year.  Maybe good enough for a Windows box but not acceptable
> for your server.  So you put in ECC to bring this probability back
> into reasonable numbers.  ECC can correct the single bit errors.
> You only have to deal with double bit errors.  Chance for them is
> much much lower.
> 

Yes, ECC, unlike parity, is a technique for reducing the error rate,
with the side benefit of intercepting an error when it happens.

I am not disagreeing with Larry that integrity checks are a Good
Thing[TM], and in general are a hallmark of good engineering.
However, they are not a replacement for ECC for the purpose of driving
the failure rate down into an acceptable probability range.

It is of course a very nice thing that DRAM prices have come down into
the range where buying them in gigabyte quantities are reasonable :)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
