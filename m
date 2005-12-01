Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVLAW2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVLAW2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 17:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVLAW2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 17:28:06 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:51789 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S932542AbVLAW2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 17:28:05 -0500
Date: Thu, 01 Dec 2005 17:26:40 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Gene's pcHDTV 3000 analog problem
In-reply-to: <438F73E5.5020600@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: Perry Gilfillan <perrye@linuxmail.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Don Koch <aardvark@krl.com>, Michael Krufky - V4L <mkrufky@m1k.net>
Message-id: <200512011726.41299.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <1133470859.23362.59.camel@localhost> <438F73E5.5020600@linuxmail.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 December 2005 17:06, Perry Gilfillan wrote:
>Mauro Carvalho Chehab wrote:
>> After checking the datasheets of Thompson tuner, and I have one
>> guess:
>>
>> At board description, tda9887 is not there. This tuner needs to work
>>properly.
>>
>> This small patch does enable it for your board.
>>
>> You should notice that you may need to use some parameters for
>> tda0887 to work properly, like using port1=0 port2=0 qss=0 as insmod
>> options for this module. (these are some on/off bits at the chip, to
>> enable some special functions - if 0/0/0 doesn't work you may need to
>> test 0/0/1, .. 1/1/1).
>
>This has fixed it for me!!  I compiled todays cvs, with out this patch,
>to watch it fail, then added the line as noted, and reloaded the
> modules without rebooting, and it worked.  I did a cold start to see
> that it is repeatable, and it continues to work.  I used no extra
> parameters, so the defaults are working fine.

I haven't built it yet, had to apply the patch by hand for some reason
here, after doing a cvs up -D today.

2.6.15-rc4 under construction to test it.
>
>Cheers,
>
>Perry
>
>>Cheers,
>>Mauro.
>>
>>
>>----------------------------------------------------------------------
>>--
>>
>>Index: linux/drivers/media/video/cx88/cx88-cards.c
>>===================================================================
>>RCS file:
>> /cvs/video4linux/v4l-dvb/linux/drivers/media/video/cx88/cx88-cards.c,
>>v retrieving revision 1.108
>>diff -u -p -r1.108 cx88-cards.c
>>--- linux/drivers/media/video/cx88/cx88-cards.c	25 Nov 2005 10:24:13
>> -0000	1.108 +++ linux/drivers/media/video/cx88/cx88-cards.c	1 Dec
>> 2005 20:56:43 -0000 @@ -569,6 +569,7 @@ struct cx88_board
>> cx88_boards[] = {
>> 		.radio_type     = UNSET,
>> 		.tuner_addr	= ADDR_UNSET,
>> 		.radio_addr	= ADDR_UNSET,
>>+		.tda9887_conf   = TDA9887_PRESENT,
>> 		.input          = {{
>> 			.type   = CX88_VMUX_TELEVISION,
>> 			.vmux   = 0,

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

