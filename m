Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbVCDPFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbVCDPFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 10:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVCDPFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 10:05:20 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:62689 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S262888AbVCDPCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 10:02:05 -0500
Date: Fri, 04 Mar 2005 10:02:03 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [linux-dvb-maintainer] Re: 2.6.11 vs DVB cx88 stuffs
In-reply-to: <20050304122434.GB9121@linuxtv.org>
To: Johannes Stezenbach <js@linuxtv.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org,
       Gerd Knorr <kraxel@bytesex.org>
Reply-to: gene.heskett@verizon.net
Message-id: <200503041002.03471.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503032119.04675.gene.heskett@verizon.net>
 <4227CE34.2040805@osdl.org> <20050304122434.GB9121@linuxtv.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 March 2005 07:24, Johannes Stezenbach wrote:
>On Thu, Mar 03, 2005 at 06:55:48PM -0800, Randy.Dunlap wrote:
>> Gene Heskett wrote:
>> >Greetings;
>> >
>> >I've a new pcHDTV-3000 card, and I thought maybe it would
>> >be a good idea to build the cx88 stuff in the DVB section
>> >of a make xconfig.
>> >
>> >It doesn't build, spitting out this bailout:
>
>...
>
>> >Another patch needed maybe?
>>
>> Sure, some patch is needed.  Let's ask the maintainer (cc-ed).
>>
>> BTW, to get this you had to enable CONFIG_BROKEN:
>>
>> config VIDEO_CX88_DVB
>>         tristate "DVB Support for cx2388x based TV cards"
>>         depends on VIDEO_CX88 && DVB_CORE && BROKEN
>>         select VIDEO_BUF_DVB
>
>Gerd Knorr has patches pending which depend on patches which
>I have to create from linuxtv.org CVS. I will submit then asap.
>
>Johannes

Ok, but this morning I noticed another potential problem, one that 
I've pinged Jack K., (the author of the pcHDTV-1.6 driver kit, some 
of whose modules overwrite kernel modules by the same names,) about 
just a few minutes ago.

I'm getting the usual nvidia generated 'tainted kernel' messages in my 
log when the modules are loaded:

Mar  4 04:17:46 coyote kernel: bttv: no version for "struct_module" 
found: kernel tainted.
Mar  4 04:17:46 coyote kernel: bttv: No versions for exported symbols. 
Tainting kernel.
Mar  4 04:17:46 coyote kernel: bttv: driver version 0.9.15 loaded
Mar  4 04:17:46 coyote kernel: bttv: using 8 buffers with 2080k (520 
pages) each for capture

Since we do have the srcs for this one, how can a relative dummy like 
me fix this?  Or should I wait for Jack K.'s answer...  Grepping 
kernel srcs for a 'struct_module' seems to come up empty for 2.6.11.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
