Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289331AbSA1TMx>; Mon, 28 Jan 2002 14:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289334AbSA1TMq>; Mon, 28 Jan 2002 14:12:46 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:901 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289331AbSA1TMc>;
	Mon, 28 Jan 2002 14:12:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "" <simon@baydel.com>, Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
Date: Mon, 28 Jan 2002 20:17:06 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020125114634.762A-100000@chaos.analogic.com> <3C54D1CB.23664.50D4C3@localhost>
In-Reply-To: <3C54D1CB.23664.50D4C3@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VHH9-0000Ba-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 28, 2002 05:21 am,  wrote:
> First of all I would like to thank all the people that responded to my 
> mail. Unfortunately the numbers I am using are not restricted to 
> powers of two so I could not simply shift the data. I have decided to 
> use the div64.h solution and it seems to work well. 
> 
> I have looked at this header file and I do not understand the asm 
> syntax. 
> 
> In particular the only x86 div instruction I know only returns a 32 bit 
> div result. Because I don't understand the div64 header I cannot 
> see how a 64 bit result is calculated.

This particular macro can't do that.  However, 64bits/32bits = 64bits is
easily calculated with two 64/32 hardware divides, in assembly.

> I also tried this header in a regular application. This failed to return 
> the modulus although it works in a module.
> 
> Is this asm syntax documented anywhere ? 

It's painful, isn't it?  And no, I don't know where it's documented.

--
Daniel
