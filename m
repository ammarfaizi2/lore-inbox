Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbULQBQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbULQBQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 20:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbULQBQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 20:16:16 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:59780 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S262707AbULQBPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 20:15:38 -0500
Date: Fri, 17 Dec 2004 02:15:22 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Greg KH <greg@kroah.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
In-Reply-To: <20041217002124.GA11898@kroah.com>
Message-ID: <Pine.LNX.4.60.0412170204480.25628@alpha.polcom.net>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com>
 <41C20356.4010900@sun.com> <20041216221843.GA10172@kroah.com>
 <20041216144531.3a8d988c@lembas.zaitcev.lan> <20041216225323.GA10616@kroah.com>
 <Pine.LNX.4.60.0412170033160.25628@alpha.polcom.net> <20041216235147.GC11330@kroah.com>
 <Pine.LNX.4.60.0412170101530.25628@alpha.polcom.net> <20041217002124.GA11898@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Greg KH wrote:

> On Fri, Dec 17, 2004 at 01:08:05AM +0100, Grzegorz Kulewski wrote:
>> On Thu, 16 Dec 2004, Greg KH wrote:
>>> Disadvantage:
>>> - it puts a non-process type thing into /proc which is what I am
>>>  specifically trying to get away from doing.
>>>
>>> Only process related things _should_ be in /proc.  Now if I can ever
>>> fully achieve that goal in my lifetime is something that is left to be
>>> seen...
>>
>> Ok, probably - but who said this?
>
> Well, if you can't find it written down anymore, here, I'll give you a
> quote:
> 	"/proc should only be for process related things."
> 			- Greg Kroah-Hartman, December 16, 2004
>
>> IIRC there is no standard describing what should be in proc and what
>> should not.
>
> We have one now, see above :)

Thanks, I needed that! :)


>> I do not think that after so many years of storing everyting in /proc
>> there is any chance that you will remove all not [0-9]* dirs and files
>> from /proc before the sun will stop lighting... :-)
>
> Hey, everyone needs a windmill to chase after to define their life's
> purpose...

Ok, you are kernel and Gentoo developer - you are right by definition. :)


>> And polluting / with proc, sys, dev, selinux, debug and who knows what
>> else is at least equally bad.
>
> Why?  Each location is defined to have one, specific, well defined thing
> there that people can count on (or not count on in the case of /debug.)

Because in short time we will end with / occupying >1 page of console - 
and it will be bad in my opinion. Besides do we really need that many 
fses - each for exporting kernel data to userspace? This is at least 
strange. Why can not /dev, /selinux be merged into /sys (ok, maybe there 
should be symlinks in /dev to devices in right device directory in /sys). 
Why debugfs can not live in /sys - for example in /sys/debug? What is 
wrong with one value per file and debugfs?

And I have also other question: Where can I find some info about using 
/sys (in kernel) and some small note about its implementation and overhead 
(cpu and memory)?


Thanks,

Grzegorz Kulewski
