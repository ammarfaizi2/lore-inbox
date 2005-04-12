Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVDLMMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVDLMMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVDLMLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:11:22 -0400
Received: from alog0438.analogic.com ([208.224.222.214]:8622 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262375AbVDLMKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:10:38 -0400
Date: Tue, 12 Apr 2005 08:10:20 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Petr Baudis <pasky@ucw.cz>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Call to atention about using hash functions as content indexers
 (SCM saga)
In-Reply-To: <20050411225139.GA9145@pasky.ji.cz>
Message-ID: <Pine.LNX.4.61.0504120805010.31214@chaos.analogic.com>
References: <20050411224021.GA25106@larroy.com> <20050411225139.GA9145@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2005, Petr Baudis wrote:

> Dear diary, on Tue, Apr 12, 2005 at 12:40:21AM CEST, I got a letter
> where Pedro Larroy <piotr@larroy.com> told me that...
>> Hi
>
> Hello,
>
>> I had a quick look at the source of GIT tonight, I'd like to warn you
>> about the use of hash functions as content indexers.
>>
>> As probably you are aware, hash functions such as SHA-1 are surjective not
>> bijective (1-to-1 map), so they have collisions. Here one can argue
>> about the low probability of such a collision, I won't get into
>> subjetive valorations of what probability of collision is tolerable for
>> me and what is not.
>>
>> I my humble opinion, choosing deliberately, as a design decision, a
>> method such as this one, that in some cases could corrupt data in a
>> silent and very hard to detect way, is not very good. One can also argue
>> that the probability of data getting corrupted in the disk, or whatever
>> could be higher than that of the collision, again this is not valid
>> comparison, since the fact that indexing by hash functions without
>> additional checking could make data corruption legal between the
>> reasonable working parameters of the program is very dangerous.
>
> (i) 1461501637330902918203684832716283019655932542976 possible SHA1 hashes.
>
> (ii) In git-pasky, there's (turnable off) detection of collisions.
>
> (iii) Your argument against comparing with the probability of a hardware
> error does not make sense to me.
>
> (iv) You fail to propose a better solution.
>
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> 98% of the time I am right. Why worry about the other 3%.

This is a standard, free (no patents) hash-function that works.
The fact that somebody can write a program, designed to create
collisions, and demonstrate that after many weeks of processing,
iteratively building upon the previous result, and finally
cause a collision, really isn't relevant for this application.

There is a good possibility that there are no hash-functions
that can't be broken.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
