Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVAJMl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVAJMl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 07:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVAJMl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 07:41:28 -0500
Received: from alog0069.analogic.com ([208.224.220.84]:34688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262226AbVAJMlP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 07:41:15 -0500
Date: Mon, 10 Jan 2005 07:41:02 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: "Patrick J. LoPresti" <patl@curl.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random vs. /dev/urandom
In-Reply-To: <s5gzmzjbza1.fsf@egghead.curl.com>
Message-ID: <Pine.LNX.4.61.0501100735210.19253@chaos.analogic.com>
References: <20050107190536.GA14205@mtholyoke.edu> <20050107213943.GA6052@pclin040.win.tue.nl>
 <Pine.LNX.4.61.0501071729330.22391@chaos.analogic.com> <s5gzmzjbza1.fsf@egghead.curl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2005, Patrick J. LoPresti wrote:

> linux-os <linux-os@chaos.analogic.com> writes:
>
>> In this case I AND with 1, which should produce as many '1's as
>> '0's, ... and clearly does not.
>
> Actually, a fair coin flipped N times is unlikely to come up heads
> exactly N/2 times, and the probability of this drops quickly as N
> grows.
>
> What is true is that it will usually come up heads N/2 times, give or
> take sqrt(N).  Mathematicians call this the "Central Limit Theorem".
>
> For example, take N=32.  The square root of 32 is a little less than
> 6.  So we expect to see between 16-6 (i.e., 10) and 16+6 (i.e., 22)
> heads in a typical trial.  (Of course, in one trial out of 4 billion
> it will come up all heads.  The Central Limit Theorem is about "usual"
> outcomes, not every outcome.)
>
> So we expect between 10 and 22 odds/evens in your trial.
>
>> Trying /dev/random
>> 0100000101010000010001000101000000000000000101000100010000000101
>>   odds = 14 evens = 18
>> Trying /dev/urandom
>> 0001010001000100000101000100010001000000000000000000010000000000
>>   odds = 10 evens = 22
>> LINUX> ./xxx
>> Trying /dev/random
>> 0100000100010101000101010101010101000100010000010001010000000101
>>   odds = 20 evens = 12
>> Trying /dev/urandom
>> 0100000100000101010001000101010001010001000000010101010100010000
>>   odds = 18 evens = 14
>
> Well how about that.  Try it with larger N, and you will find it gets
> even harder to hit a case where the total is outside the sqrt(N) error
> margin.  And of course, as a percentage of N, sqrt(N) only shrinks as
> N grows.
>
> If you doubt any of this, try it with a real coin.  Or read a book on
> probability.
>
> - Pat

One is free to use any number of samples. The short number of samples
was DELIBERATELY used to exacerbate the problem although a number
or nay-sayers jumped on this in an attempt to prove that I don't
know what I'm talking about.

In the first place, the problem was to display the error of using
an ANDing operation to truncate a random number. In the limit,
one could AND with 0 and show that all randomness has been removed.
However, those who know nothing about the theory would then
probably jump upon this as a "special case" even though it usn't.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
