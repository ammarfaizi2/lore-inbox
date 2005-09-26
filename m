Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbVIZQwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbVIZQwq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbVIZQwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:52:46 -0400
Received: from mail-res.bigfish.com ([63.161.60.61]:20813 "EHLO
	mail30-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751677AbVIZQwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:52:45 -0400
X-BigFish: V
Message-ID: <4338275B.1030500@am.sony.com>
Date: Mon, 26 Sep 2005 09:52:43 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Darren Hart <dvhltc@us.ibm.com>, george@mvista.com,
       "Theodore Ts'o" <tytso@mit.edu>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "lkml," <linux-kernel@vger.kernel.org>, dino@us.ibm.com,
       Paul McKenney <paulmck@us.ibm.com>,
       "Sarma, Dipankar" <dipankar@in.ibm.com>
Subject: Re: HRT on opteron / rt14 on opteron
References: <432F21D1.90209@us.ibm.com> <432F5A44.9010208@am.sony.com>	 <433489F6.9080203@us.ibm.com> <1127684460.15115.116.camel@tglx.tec.linutronix.de>
In-Reply-To: <1127684460.15115.116.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Fri, 2005-09-23 at 16:04 -0700, Darren Hart wrote:
> 
>>I am trying to run all the tests in the above tarball on a 2.6.13 kernel with 
>>ktimers+tod+hrt + a hrt compatibility patch which uses the normal clocks when a 
>>_HR clock is requested since ktimers treats them the same.  I remember there 
>>used to be a run_tests script or something when this was a kernel patch, but I 
> 
> 
> do_test
> 
> 
>>am not seeing that or any kind of documentation on how to interpret the output 
>>of the tests which output numbers rather than pass/fail.  For instance:
>>
>># ./1-4
>>it value left is 3 999985323
>>What does that even mean?  
> 
> 
> Cryptic POSIX compliance test output.
> 

I beleive a number of the tests came from the Open 
POSIX Test Suite (http://posixtest.sourceforge.net/).

> 
>># ./timerlimit
>>7168: timer id = 7167
>>timer_create: Resource temporarily unavailable
>>
>>Is that a reasonable number of successfully created clocks?
> 
> 
> Depends on the number of timers available on your system. But sounds
> reasonable.
> 

If I remember correctly, you're limited by the number of
signals a process can have, and the kernel default is 
1024 per process.

-Geoff




