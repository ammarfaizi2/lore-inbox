Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbUKCTOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUKCTOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbUKCTNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:13:40 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:459 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261825AbUKCTMl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:12:41 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, linux-os@analogic.com
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 14:12:37 -0500
User-Agent: KMail/1.7
Cc: bert hubert <ahu@ds9a.nl>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031124.19179.gene.heskett@verizon.net> <Pine.LNX.4.61.0411031133590.14117@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0411031133590.14117@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031412.37389.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.46.51] at Wed, 3 Nov 2004 13:12:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 11:46, linux-os wrote:
>On Wed, 3 Nov 2004, Gene Heskett wrote:
>> On Wednesday 03 November 2004 09:33, bert hubert wrote:
>>> On Wed, Nov 03, 2004 at 07:51:39AM -0500, Gene Heskett wrote:
>>>> But I'd tried to run gnomeradio earlier to listen to the
>>>> elections,
>>>
>>> Depressing enough.
>>>
>>>> I'd tried to kill the zombie earlier but couldn't.
>>>> Isn't there some way to clean up a &^$#^#@)_ zombie?
>>>
>>> Kill the parent, is the only (portable) way.
>>
>> The parent would have been the icon.  It opened its usual sized
>> small window, but never did anything to it. I clicked on closing
>> the window, but 10 seconds later the system asked me if I wanted
>> to kill it as it wasn't responding. I said yes, the window
>> disappeared, but kpm said gomeradio was still present as process
>> 8162, and that wasn't killable.  Funny thing is, on the reboot, it
>> automaticly self restored and ran just fine.
>>
>> I consider this as one of linux's achilles heels.  Such a hung and
>> dead process can be properly disposed of by a primitive os called
>> os9 because it keeps track of all resources in tables in the
>> kernel memory space.  Issueing a kill procnumber removes the
>> process from the exec queue, reclaims all its memory to the system
>> free memory pool, and removes it from the IRQ service tables if an
>> entry exists there.  Near instant, total cleanup, nothing left, in
>> about 250 microseconds max. 1.79 mhz cpu's aren't quite instant :)
>>
>> Lets just say that I think having to reboot because of a zombie
>> that has resources locked up, and have the reboot fubared by it
>> too, aren't exactly friendly actions.
>
>[SNIPPED....]
>
>There is no problem killing a task and freeing its resources.
>The problem is that Linux and other Unix variations need to
>do this in a specific manner. That manner being that some
>parent (or ultimately init) needs to receive the terminating
>status. A task that has been otherwise killed, but is awaiting
>its status to be obtained is in the 'Z' or zombie state. If
>the code for either the child task or its parent was improperly
>written, the death of a parent could allow a child to wait
>forever (zombie).
>
>The fix is to fix the code. 

In other words, its gnomeradio that needs fixed then?

Its the best 'radio' proggy I've run across that works with my 
hardware, but I'm not sure it has a support person at ths late date.  
Its probably not been touched in 2 years.  Kde doesn't appear to have 
a similar util that I've run across in the menu's so far, and its 
3.3.0 here.

All of which seems to be dancing around the real problem though.  
There seems to be no handy (to the user) path into the kernel to 
allow such a killing unconditionally function.  root should have that 
ability.

>Your temporary fix is to use 
>Ctrl-Alt-backspace to kill the X11 server (the parent).

The logout took about 2 minutes because X couldn't clear itself 
either.

>If it doesn't restart (it's not a kernel problem, it's
>a distribution problem), you can log in as root and
>execute:
>
>  /etc/X11/prefdm &

I'll try that next time.

>All these little windows and icons are the 'children' of
>the X server. The above is a temporary work-around for
>a non-kernel problem.

But a problem the kernel really should be capable of handling 
transparently.
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by John Ashcroft.

What on earth for?  I don't issue anything he would be interested in 
except the first part of my sig.  And thats been in my sig for a year 
or so, and will stay there till the so-called Patriot Act is 
repealed.  John Ashcroft has done more damage to democracy 
single-handedly because of his paranoia than any other 20 men in our 
history.  G. Washington certainly wouldn't have tolerated such a 
person in his 1st term of government.

Depending on the mailing list, data here has a lifetime as short as 30 
days.

Sorry about spilling politics into the list folks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
