Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129957AbRALSgN>; Fri, 12 Jan 2001 13:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129985AbRALSfy>; Fri, 12 Jan 2001 13:35:54 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4882 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129957AbRALSfp>; Fri, 12 Jan 2001 13:35:45 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Date: 12 Jan 2001 10:35:24 -0800
Organization: Transmeta Corporation
Message-ID: <93nipc$1vp$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10101120931520.1806-100000@penguin.transmeta.com> <E14H8PC-0004hZ-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E14H8PC-0004hZ-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> The fact that 2.2.x has bad control over capabilities and is messy is NOT
>> an excuse to screw up forever. 
>
>2.2 has a mix of 'can I use' and 'does the cpu have' so using 2.2 as an 
>example doesnt work

The above was exactly what I meant by being messy and not having a good
control over capabilities, so I think it's a perfect example. 

The fact is, we've historically NOT had a good way of indicating which
features the kernel can try to take advantage of.  This is something
that 2.4.0 tries to fix - to have everything in one central place with
no way to get mixed up about whether the CPU has some feature or not. 
And then export that single source knowledge through /proc/cpuinfo. 

I happen to believe that it's a big advantage to have just a single
source of capability data, AND to have that capability data be available
to user mode - with no way for the user to be confused ("But
/proc/cpuinfo _said_ that the kernel had FXSR, why can't I use it?"). 

Andreas argument was that earlier kernels weren't consistent, and as
such we shouldn't even bother to try to make newer kernels consistent. 
We would be better off reporting our internal inconsistencies the way
earlier kernels did - the kernel would be confusing, but at least it
would be consistently confusing ;)

I don't buy that argument. I don't care that we got details like this
wrong before.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
