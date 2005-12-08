Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbVLHAON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVLHAON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVLHAON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:14:13 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:21833 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S965064AbVLHAOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:14:12 -0500
Date: Wed, 07 Dec 2005 19:14:11 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ntp problems
In-reply-to: <439771A0.1000604@eclis.ch>
To: linux-kernel@vger.kernel.org
Message-id: <200512071914.11254.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <200512050031.39438.gene.heskett@verizon.net>
 <200512071750.20709.gene.heskett@verizon.net> <439771A0.1000604@eclis.ch>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 December 2005 18:34, Jean-Christian de Rivaz wrote:
>Gene Heskett a écrit :
>> On Wednesday 07 December 2005 16:56, Jean-Christian de Rivaz wrote:
>>>Gene Heskett a écrit :
>>>>And, acpi is on, and ntpd is happy with the new bios.  Hurrah!
>>>
>>>Good news!
>>>
>>>I wonder if it would be a good idea to add something into the kernel
>>> or into ntpd to alert the users that ntpd can't run normaly because
>>> of a too fast drift ? Then a BIOS upgrade could be proposed
>>> (especially on a nForce2 system). I don't know if it's even
>>> realistc.
>>>
>>>Regards,
>>
>> The drift itself wasn't what I'd call excessive,
>> something like 6 minutes in a week, which for
>> mainboard quality crystals is pretty darned good.
>
>ntpd work only on system with a drift of maximum +/-500ppm. This post
>summarize a lot of informations about the problem:
>http://marc.theaimsgroup.com/?l=linux-kernel&m=113105244509795&w=2
>It was found later that an issue into the nForce2 is the root of the
>problem and that a BIOS update solve it.
>
Yes, but this 500ppm limitation does not AIUI, include the mitigating 
effects of the drift files contents I'm told.  I know there have been 
times when I had to manually play with it to get it in range, or simply 
delete it and let ntpd reset it, which it then finetuned as I can see in 
an ntpq -p output.

Is this incorrect?  FWIW, the value in the drift file right now is within 
about 1 ppm of the value that was in it when it wasn't working.  So that 
tells me the drift rate was ok, with the files compensating effects 
added in.  Offsets to the server its peering to right now haven't 
exceeded 6.554 since the last reboot.  Humm, I'll take it back, just in 
the last half hour the peer site has gone from an offset of -1.568 to an 
offset of -41.184, and it did this without updateing the contents of the 
drift file logged a few milliseconds before.  This bears watching I 
think.


>6.0 / (60*24*7) * 1e6 = 595.24
>6 minutes per week is near 600ppm, it's enough to trigg the problem you
>have seen. Even very cheap crystal are 100ppm at commercial temperature
>range. 100ppm is about 1 minute per week. Some crystal manufacturers
>propose now 30ppm as the default standard at commercial temperature
> range.
>
>As your watch prove, good cristal can be just a few ppm (about 3.86ppm
>for your watch)
>
>Regards,

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
