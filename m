Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283052AbRLVXwv>; Sat, 22 Dec 2001 18:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282998AbRLVXwl>; Sat, 22 Dec 2001 18:52:41 -0500
Received: from jalon.able.es ([212.97.163.2]:64446 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S282983AbRLVXw0>;
	Sat, 22 Dec 2001 18:52:26 -0500
Date: Sun, 23 Dec 2001 00:54:28 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Pavel Machek <pavel@suse.cz>
Cc: Robert Love <rml@tech9.net>, Martin Devera <devik@cdi.cz>,
        Chris Meadors <clubneon@hereintown.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: gcc 3.0.2/kernel details (-O issue)
Message-ID: <20011223005428.I6735@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.10.10112192037490.3265-100000@luxik.cdi.cz> <1008792213.806.36.camel@phantasy> <20011222215457.A118@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011222215457.A118@elf.ucw.cz>; from pavel@suse.cz on Sat, Dec 22, 2001 at 21:54:58 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011222 Pavel Machek wrote:
>Hi!
>
>> > It is interesting that 2.2 can be done with -O. Also I'd expect
>> > errors during compilation and not silent crash...
>> 
>> Well, you certainly won't get errors, because compiler optimizations
>> shouldn't change expected syntax.
>> 
>> -O2 is the standard optimization level for the kernel; everything is
>> compiled via it.  When developers test their code, nuances that the
>> optimization introduce are accepted.  Removing the optimization may
>> break those expectations.  Thus the kernel requires it.
>
>Huh? Those expectations are *bugs*.
>
>Kernel will not link without optimalizations because it *needs*
>inlining. Any else dependency is a *bug*.
>									Pavel

Wouldn't it be better to mark such places with something like
#pragma inline, if gcc allows it, than relaying on gcc guesses about
inlining, or options activated in O2 ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.17-beo #1 SMP Fri Dec 21 21:39:36 CET 2001 i686
