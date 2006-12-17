Return-Path: <linux-kernel-owner+w=401wt.eu-S932467AbWLQTFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWLQTFY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 14:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWLQTFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 14:05:24 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:37171 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467AbWLQTFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 14:05:23 -0500
Date: Sun, 17 Dec 2006 14:04:56 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ieee1394 in 2.6.20-rc1 (was Re: Linux 2.6.20-rc1)
In-reply-to: <45858CF2.7080402@s5r6.in-berlin.de>
To: linux-kernel@vger.kernel.org
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Linus Torvalds <torvalds@osdl.org>
Message-id: <200612171404.56278.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <200612171311.38763.gene.heskett@verizon.net>
 <45858CF2.7080402@s5r6.in-berlin.de>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 December 2006 13:31, Stefan Richter wrote:
>Gene Heskett wrote:
>...
>
>> while I didn't try
>> to capture a 2 hour movie, I did use kino to control the camera
>> playback, rewind etc stuff for about 10 minutes and had no problems
>> whatsoever.
>
>...
>
>> The only entry in the messages log for all this was:
>>
>> Dec 17 12:47:13 coyote kernel: WARNING: The dv1394 driver is
>> unsupported and will be removed from Linux soon. Use raw1394 instead.
>
>Is your version of kino still using dv1394 or does it work without
>dv1394 loaded too?
>
AFAIK, its kino is 0.9.3.  Ok, while kino is running I did a modprobe -rv 
dc1394 and it removed dv1394.ko and ohci1394.ko

Now when going to the capture screen is says the device /dev/raw1394 is 
gone or the kernel module isn't loaded.  raw1394 is still resident 
according to an lsmod, so I'm puzzled as to why the device was removed 
when the module is still present.  So I modprobe -rv raw1394 and it took 
out raw1394 and ieee1394, then reloaded raw1394 which loaded ieee1394.  
And kino is still without controls but does not now report the error at 
the bottom of its screen.  Quitting it and restarting it restores the 
error.  Then loading dv1394 also brings in ohci1394, and a recycle out and 
back to the capture window restored the controls.

So I removed dv1394, and reloaded only ohci1384, but an attempt to change 
screens in kino locked the box up tight, not even the x-clock in the 
right corner was running and I had to hard reset it.

With 4 modules to play with and 4!=15, its the lack of the dv1394 module 
that isn't exactly friendly, the other combo's just kill the controls.

AIUI, it *should* be ohci1394 handling the controls stuff, so this 
represents a bit of a puzzle.  Or the AIUI is wrong :)
 
>> Dec 17 12:47:13 coyote kernel: ieee1394: raw1394: /dev/raw1394 device
>> initialized
>>
>> So whatever was done to the ieee1394 stuffs between 2.6.19 and
>> 2.6.20-rc1 was a definite, and much appreciated improvement,
>
>...
>
>>From what went into linux/drivers/ieee1394 after 2.6.19 was released,
>I'm puzzled how this happened. :-)

Me too, but the whole combination does work.  Remove only dv1394=locked up 
machine & hardware reset.

I hope this is helpfull to the next step in your quest to get rid of 
dv1394.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
