Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSHVRVb>; Thu, 22 Aug 2002 13:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSHVRVb>; Thu, 22 Aug 2002 13:21:31 -0400
Received: from mta.sara.nl ([145.100.16.144]:56205 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S315178AbSHVRU5>;
	Thu, 22 Aug 2002 13:20:57 -0400
Date: Thu, 22 Aug 2002 19:25:01 +0200
Subject: Re: Problem with random.c and PPC
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
From: Remco Post <r.post@sara.nl>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
In-Reply-To: <ak1l8c$drl$2@abraham.cs.berkeley.edu>
Message-Id: <16BFC8C3-B5F4-11D6-B24B-000393911DE2@sara.nl>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On donderdag, augustus 22, 2002, at 03:19 , David Wagner wrote:

> Chris Friesen  wrote:
>> The problem is this.  If you have an embedded system that is headless,
>> diskless, keyboardless, and
>> mouseless, then your only remaining source of any interrupt-based
>> entropy is the network.
>
> Try replacing "network" with "/dev/zero" to see how your sentence
> sounds, and then maybe the flaw in your reasoning will become apparent.
>
>   "If you have an embedded system that is headless, etc., then your
>   only remaining source of entropy is /dev/zero."
>
> Well, sometimes there is just no reliable entropy source on hand.
> Maybe it's better to admit that than to fool ourselves.

And how would you see this. On a diskless/headless system, you'll be 
sure to find more than one NIC, making it IMHO very unlikely for one 
attacker to be able to generate so much traffic on all of those that all 
NICs are continuesly generating interrupts. Granted, it's not the best 
source of entropy, but it's guanranteed to be more that /dev/zero. 
Having your network cards in your entropy pool, is not really bad, and 
is a lot better than not being able to generate session keys at all for 
your ssh connection.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
---
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


