Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268055AbUIPNWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268055AbUIPNWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUIPNWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:22:03 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:21755 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S268055AbUIPNVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:21:37 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: journal aborted, system read-only
Date: Thu, 16 Sep 2004 09:21:34 -0400
User-Agent: KMail/1.7
Cc: "Stephen C. Tweedie" <sct@redhat.com>
References: <200409121128.39947.gene.heskett@verizon.net> <200409160103.35665.gene.heskett@verizon.net> <1095331734.1958.3.camel@sisko.scot.redhat.com>
In-Reply-To: <1095331734.1958.3.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409160921.34902.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.59.197] at Thu, 16 Sep 2004 08:21:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2004 06:48, Stephen C. Tweedie wrote:
>Hi,
>
>On Thu, 2004-09-16 at 06:03, Gene Heskett wrote:
>> >Well, we really need to see _what_ error the journal had
>> > encountered
>
>...
>
>> It just did it to me again, this time with 2.6.9-rc1-mm5.
>>
>> And as usual in these cases, the logs are spotlessly clean
>> because /var is on /, which is on /dev/hda7, an syslog couldn't
>> write when its read-only.
>
>Possibility the first is to create a separate partition for /var;

Thats now been done, but not w/o a minor disaster & an extra hour 
sorting out something heyu seems to have done.  NDI when, but its log 
output in /var/tmp has been renamed from heyu.out to heyu.outttyS1 
and thats why xtend has been getting a tummy ache.

I did have 2 partitions on that 200Gigger, one accidently way too big 
16GB swap and the rest as /amandatapes.  The minor disaster was that 
I didn't wait till I had rebooted before I ran a mke2fs -j /dev/hdd2 
(the new /var, and the amanda useage partition was left exactly the 
same, but the kernel was still runing on the old partition table so 
it formatted the amanda partition.  My bad...), so amanda is back to 
square one tonight but thinking it has a weeks backups to count on.  
But with a 7 day dumpcycle, it will be caught up in a week if I 
expand the tapetypes set size to 60Gb or so till it gets in balance.

Anyway, I now have a 15GB /var to record this crap in.

>possibility the second is to set up a serial console.

Both of my seriel ports are busy, one is watching the ups, and the 
other is running x10 stuffs.

So we'll have to take our chances that we can catch it in the logs.  
There was a single 'driver ready seek not complete' message in the 
log several days ago according to logwatch.  Its about a year old 
120GB Maxtor, and smartd is watching both of them now without send me 
any telegrams (so far, that knocking sound is me, knocking on wood).

>Without 
> access to that log information, all we know is "there was an IO
> error," and that's really not enough to narrow down the search. :-)
>
>Thanks,
> Stephen

Anyway, now we wait, except I'm going to fire off the initial amdump 
right now after telling it there is enough space on its 'tape' do do 
a level 0 on everything.  That might be interesting in itself.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
