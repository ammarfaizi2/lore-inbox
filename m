Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVCJBZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVCJBZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVCJBXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:23:51 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:60639 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S262594AbVCJBE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 20:04:56 -0500
Date: Wed, 09 Mar 2005 20:04:50 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime
In-reply-to: <20050309203317.64916119.khali@linux-fr.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503092004.51128.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503082326.28737.gene.heskett@verizon.net>
 <200503090243.06270.gene.heskett@verizon.net>
 <20050309203317.64916119.khali@linux-fr.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 14:33, Jean Delvare wrote:
>Hi Gene, Andrew, all,
>[Gene Heskett]
>
>> /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:36
>>2: error: unknown field `id' specified in initializer
>
>I've dropped the "id" member of struct i2c_client, as it were
> useless. Third-party driver authors now need to do the same.
>
>Patches to pcHDTV 1.6 and 2.0 attached (untested). Feel free to push
> the latter to the author of hdPCTV. Note that the removed struct
> member was really not used before, so the driver will still work
> with earlier kernels.

The 1.6 patch won't apply due to -pn problems, so I did it by hand.
It now builds and installs ok, but tvtime is still dead, taking about 
5 seconds to open its initial window, and another 15 to display just 
the channel and time on a permanent blue screen, with its time 
display only being updated about every 3 seconds.  Audio works ok.
Clicking on the exit also takes about 5 seconds for it to quit.
Running it from a shell with the -vv doesn't show any problems that 
look like showstoppers:
---------
[root@coyote driver]# tvtime -vv
Running tvtime 0.9.15.
Reading configuration from /etc/tvtime/tvtime.xml
Reading configuration from /root/.tvtime/tvtime.xml
cpuinfo: CPU AMD Athlon(tm) XP 2800+, family 6, model 10, stepping 0.
cpuinfo: CPU measured at 2079.706MHz.
xcommon: Display :0.0, vendor The X.Org Foundation, vendor release 
60801901
xfullscreen: Single-head detected, pixel aspect will be calculated.
xfullscreen: Pixel aspect ratio on the primary head is: 1/1 == 1.00.
xfullscreen: Using the XFree86-VidModeExtension to calculate 
fullscreen size.
xfullscreen: Fullscreen to 0,0 with size 1600x1200.
xcommon: Have XTest, will use it to ping the screensaver.
xcommon: Pixel aspect ratio 1:1.
xcommon: Pixel aspect ratio 1:1.
xcommon: Window manager is KWin and is EWMH compliant.
xcommon: Using EWMH state fullscreen property.
xcommon: Using EWMH state above property.
xcommon: Using EWMH state below property.
xcommon: Pixel aspect ratio 1:1.
xcommon: Displaying in a 768x576 window inside 768x576 space.
xvoutput: Using XVIDEO adaptor 69: ATI Radeon Video Overlay.
speedycode: Using MMXEXT optimized functions.
station: Reading stationlist from /root/.tvtime/stationlist.xml
videoinput: Using video4linux2 driver 'cx8800', card 'pcHDTV HD3000 
HDTV' (bus PCI:0000:01:07.0).
videoinput: Version is 4, capabilities 5010011.
videoinput: Width 768 too high, using 640 instead as suggested by the 
driver.
videoinput: Maximum input width: 640 pixels.
tvtime: Sampling input at 640 pixels per scanline.
xcommon: Pixel aspect ratio 1:1.
xcommon: Displaying in a 768x576 window inside 768x576 space.
xcommon: Received a map, marking window as visible (71).
xcommon: Window fully obscured, marking window as hidden (71).
xcommon: Window made visible, marking window as visible (71).
------------
And unless the diff between 640 and 768 is the problem, there isn't 
much else to go on there.

Since this involves x, its xorg-6.8.1, locally built, and so far (4 
months?) absolutely dead stable.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
