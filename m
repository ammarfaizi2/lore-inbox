Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753400AbWKCSPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbWKCSPE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbWKCSPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:15:04 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:52618 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1753394AbWKCSPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:15:00 -0500
Date: Fri, 3 Nov 2006 19:14:59 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: Andrew Morton <akpm@osdl.org>, Gabriel C <nix.or.die@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: New filesystem for Linux
In-Reply-To: <20061103173609.GA17080@flower.upol.cz>
Message-ID: <Pine.LNX.4.64.0611031912460.27914@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <454A71EB.4000201@googlemail.com> <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
 <20061102174149.3578062d.akpm@osdl.org> <20061103171443.GA16912@flower.upol.cz>
 <Pine.LNX.4.64.0611031808280.15472@artax.karlin.mff.cuni.cz>
 <20061103173609.GA17080@flower.upol.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Nov 2006, Oleg Verych wrote:

> On Fri, Nov 03, 2006 at 06:09:39PM +0100, Mikulas Patocka wrote:
>>> In gmane.linux.kernel, you wrote:
>>> []
>>>> From: Andrew Morton <akpm@osdl.org>
>>>>
>>>> As Mikulas points out, (1 << anything) won't be evaluating to zero.
>>>
>>> How about integer overflow ?
>>
>> C standard defines that shifts by more bits than size of a type are
>> undefined (in fact 1<<32 produces 1 on i386, because processor uses only 5
>> bits of a count).
> ,--
> |#include <stdio.h>
> |int main(void) {
> |	unsigned int b = 1;
> |
> |	printf("%u\n", (1 << 33));
> |	printf("%u\n", (b << 33));
> |	return 0;
> |}
> |$ gcc bit.c && ./a.out
> `--
>
> There *is* difference, isn't it?

The standard says that the result is undefined, so the compiler is 
standard-compliant. It could have returned any numbers and still be 
correct.

Mikulas
