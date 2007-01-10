Return-Path: <linux-kernel-owner+w=401wt.eu-S965260AbXAJXDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbXAJXDt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbXAJXDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:03:48 -0500
Received: from mail.tmr.com ([64.65.253.246]:40781 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965260AbXAJXDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:03:47 -0500
Message-ID: <45A57125.3070406@tmr.com>
Date: Wed, 10 Jan 2007 18:05:09 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Alexy Khrabrov <deliverable@gmail.com>
CC: Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: installing only the newly (re)built modules
References: <7c737f300701082029i1ce9f7d8oc67cb3339c9c2856@mail.gmail.com>	 <45A5609C.1000308@tmr.com> <7c737f300701101402q21ee4a8dr1ef32771d8cd78a2@mail.gmail.com>
In-Reply-To: <7c737f300701101402q21ee4a8dr1ef32771d8cd78a2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexy Khrabrov wrote:
> Well, fast -- it depends!  :)  My Crusoe tablet, Compaq TC1000, can
> use any break it gets...  And generally, the beauty of a make system
> is not to do any extra moves.  Since it already knows what to build,
> why not let it install just that?
The answer just came to me, because you may have deleted creation of a 
module, and make doesn't know how to get it out of the directory. So the 
modules file is rebuilt from zero, rather than put in a lot of logic 
which might result in problems.

Think moving a driver from module to built in, what happens if you 
modprobe the module? Or if you delete a module totally because some 
other module does your hardware better. Think network and sound on that, 
particularly. You do NOT want the old "works-badly" module around ready 
to jump in when something you overlooked loads it.

Just a case of preventing problems all at once rather than trying to be 
clever. I would think building a kernel on that hardware would take 
longer than the useful life of the release. I used to build 1.2.13 on a 
slow machine, and that took days.

In any case you have an answer, it's because being clever is hard.
>
> Cheers,
> Alexy
>
> On 1/10/07, Bill Davidsen <davidsen@tmr.com> wrote:
>> Alexy Khrabrov wrote:
>> > The 2.6 build system compiles only those modules whose config
>> > changed.  However, the install still installs all modules.
>> >
>> > Is there a way to entice make modules_install to install only those
>> > new modules we've actually just changed/built?
>>
>> Out of curiosity, why? I've noticed this, but the copy runs so fast I
>> never really thought about it as an issue.
>>
>> -- 
>> bill davidsen <davidsen@tmr.com>
>>    CTO TMR Associates, Inc
>>    Doing interesting things with small computers since 1979
>>
>


-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

