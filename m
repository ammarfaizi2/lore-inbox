Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVHKOL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVHKOL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVHKOL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:11:59 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:3295 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750867AbVHKOL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:11:58 -0400
Date: Thu, 11 Aug 2005 10:51:00 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
In-reply-to: <E1E3CJE-0001NJ-PH@allen.werkleitz.de>
To: linux-kernel@vger.kernel.org
Message-id: <200508111051.01067.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
 <20050811064217.GB21395@titan.lahn.de> <E1E3CJE-0001NJ-PH@allen.werkleitz.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 August 2005 08:37, hunold@linuxtv.org wrote:
>Hello Philipp,
>
>> I got the following OOPS from running "alevtd -F -d -v /dev/vbi0"
>> with my Siemens-DVB-C on a Dual-i686-600. I'm able to reproduce
>> this even running a 2.6.12-rc6 without the nvidia module tainting
>> the kernel.
>
>So you're using the analog tuner of the card to watch analog cable
> tv and want to decode teletext from the vbi, right?

Yes, and I can also report that teletext decoding has ceased to work
here.  But I'm not sure what kernel version killed it.  Currently
running 2.6.13-rc6.  But my card is cx88 based, a pcHDTV-3000.  But
attempting to switch it on/off doesn't seem to generate any output
indicating it failed, it just Doesn't Work(TM)

>Can you tell me the last kernel version that worked for you?
>
>> ...
>> kernel BUG at drivers/media/common/saa7146_video.c:741!
>
>739         fmt = format_by_fourcc(dev,fh->video_fmt.pixelformat);
>740         /* we need to have a valid format set here */
>741         BUG_ON(NULL == fmt);
>
>This sanity check is failing. Apparently the software managed
>to select a pixelformat that cannot be translated to a "saa7146
> format".
>
>Puh, I wrote this long ago. ;-) IIRC this should not be possible
> (ie. the driver should reject the unknown pixelformat in the
> configuring stage).
>
>Did you update the alevt package? Perhaps it's now doing this
> differently and it would fail with older kernels as well, which
> have worked before.
>
>We will probably have to debug this on a very low level.
>
>Regards
>Michael.
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

