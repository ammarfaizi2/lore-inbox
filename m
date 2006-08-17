Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWHQI3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWHQI3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWHQI3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:29:47 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:4963 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932449AbWHQI3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:29:46 -0400
Date: Thu, 17 Aug 2006 04:29:52 -0400
From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: /dev/sd*
In-reply-to: <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>,
       Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Message-id: <44E42900.1030905@PicturesInMotion.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060809212124.GC3691@stusta.de>
 <1155160903.5729.263.camel@localhost.localdomain>
 <20060809221857.GG3691@stusta.de>
 <20060810123643.GC25187@boogie.lpds.sztaki.hu> <44DB289A.4060503@garzik.org>
 <44E3DFD6.4010504@PicturesInMotion.net>
 <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr>
User-Agent: Thunderbird 1.5.0.5 (X11/20060731)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>> AFAIR long ago Linus said he'd like just one major number (and thus only
>>>> one naming scheme) for every disk in the system; with /dev/sd* we're now
>>>> getting there.
>>>>         
>>> Yep.  /dev/disk is a long term goal :)
>>>
>>>       
>> I agree with Adrian, users are going to get confused if their devices
>> are named something different once they switch to this new interface. So
>> if we're going to confusing them why not just take the big leap and
>> switch it over to /dev/disk? It seems to make more sense then to have
>> all IDE and SATA users use /dev/sda for awhile only to down the road
>> have to to switch to /dev/disk.
>>     
>
> In the process, we can rename the then-"generic disk" (scsi ide whatever) 
> back to "hd*" since that actually expands to Hard Disk.
> (If I would have known a lot earlier about Linux I would have proposed 
> "id*" for the IDE disks.)
>
>
> Jan Engelhardt
>   
Actually that does make more sense then using disk. So I guess we're
back to square one. Personally I don't think its that big of a deal, all
you have to do is change fstab and grub or lilo. My main concern is for
the less advanced Linux users.
