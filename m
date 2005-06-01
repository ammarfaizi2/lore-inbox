Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVFACcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVFACcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 22:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVFACcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 22:32:13 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:39067 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261235AbVFACcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 22:32:07 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 31 May 2005 19:31:07 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Machine Freezes while Running Crossover Office
In-Reply-To: <200506011007.26650.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.62.0505311926130.19864@qynat.qvtvafvgr.pbz>
References: <84144f0205052911202863ecd5@mail.gmail.com> <20050531184101.GA3175@elte.hu>
 <1117574407.9231.3.camel@localhost> <200506011007.26650.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Con Kolivas wrote:

> On Wed, 1 Jun 2005 07:20 am, Pekka Enberg wrote:
>> On Tue, 2005-05-31 at 20:41 +0200, Ingo Molnar wrote:
>>> Now, assuming you can confirm that doing:
>>>
>>>   echo 5 > /proc/sys/kernel/INTERACTIVE_DELTA
>>
>> The hang goes away with a magic number of 6 (although it does not seem
>> as smooth as with turning off interactivity completely). With 5, I still
>> get the hang but it is noticeable shorter than before. Number 4 gives me
>> the same old hang.
>>
>> Ingo, are there other patches you wanted me to try out?
>
> Generally when I was playing with it I found that if something was critically
> dependant on the _value_ of a tunable rather than the algorithm design, it
> would simply take a different piece of hardware or test case to induce the
> problem, and the algorithm would have to be changed instead of tweaking the
> parameters. This will require a some thought as to the design and an
> algorithm change for the long term rather than tweaking a value :-|
>
> None of this behaviour existed when the interactivity code went in during 2.5
> and I could never have anticipated this pipe design change coming and
> affecting it in this way.

IIRC back when the interactivity code was introduces someone raised the 
question about a set of malicious cooperating processes takeing advantage 
of this feature to hog system resources. This seems to match what is 
happening accidently with these pipe processes

at the time an answer was given that satisfied everyone (but I don't 
remember what it was and don't have the time to do the digging for it), I 
seem to remember something about an option to detect the dependancies 
between processes and boost/penalize them as a group in addition to the 
individual bonuses (with this deemed unessasary overhead at the time as 
there were no example cases to show that this was more then a theoretical 
case)

possibly someone with a better memory (or more time to research) can find 
more.

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
