Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbUAJTPt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbUAJTPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:15:49 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:33166 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S265303AbUAJTPr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:15:47 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: Martin Schlemmer <azarah@nosferatu.za.org>,
       John Lash <jlash@speakeasy.net>
Subject: Re: Q re /proc/bus/i2c
Date: Sat, 10 Jan 2004 14:15:46 -0500
User-Agent: KMail/1.5.1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401100117.42252.gene.heskett@verizon.net> <20040110095911.7b99d40c.jlash@speakeasy.net> <1073758800.9096.12.camel@nosferatu.lan>
In-Reply-To: <1073758800.9096.12.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401101415.46745.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.61.108] at Sat, 10 Jan 2004 13:15:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 13:20, Martin Schlemmer wrote:
>On Sat, 2004-01-10 at 17:59, John Lash wrote:
>> In a 2.6.x kernel, the sensors information is kept in sysfs. I
>> haven't actually tried installing lmsensors on my 2.6 system, but
>> if I look in: /sys/bus/i2c/devices/0-002d/
>> I can see files for all of the sensors on my system.
>>
>> Check below in your last mail where it is complaining about
>> "Algorithm: Unavailable from sysfs".
>
>Right, needs sysfs mounted.  You should (after creating /sys) add
>the following to /etc/fstab:
>
>--
>none	/sys	sysfs	defaults	0 0
>--

>From my fstab, and its been there for several months now:
---
none    /sys    sysfs   defaults        0 0
---
Also, from my mtab:
Well, I was gonna quote that too, but apparently my entry in 
rc.sysinit doesn't record it in mtab.  I've got a message in the log 
to the effect that its already mounted or is otherwise busy.  I'd put 
that line in rc.sysinit a few (2-3) weeks ago, thinking it needed to 
be done earlier than the fstab driven mount.  I'll remove it from 
rc.sysinit and reboot for effects.

Done.

I also moved the mount of /proc/bus/usb to fstab while I was at it, 
and they are all recorded in mtab now:
---
none /proc/bus/usb usbfs rw 0 0
none /sys sysfs rw 0 0
---
But the response from sensors is still as I posted before, "Algorithm: 
Unavailable from sysfs"

tvtime still works, so thats promising.  Sounds like they (the Feed 
Bag Information folks) got something/someone(s) trapped on a plane at 
Dulles according to FOX News, who are of course makeing the usual 
mountain out of whats probably a molehill.

Next thing to check?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

