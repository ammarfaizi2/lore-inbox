Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263402AbVCJXMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbVCJXMA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbVCJXHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:07:33 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:22747 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S263363AbVCJXCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:02:36 -0500
Date: Thu, 10 Mar 2005 18:02:34 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime
In-reply-to: <20050308224441.2e29f895.akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, video4linux-list@redhat.com,
       linux1394-devel@lists.sourceforge.net, sensors@stimpy.netroedge.com
Reply-to: gene.heskett@verizon.net
Message-id: <200503101802.34407.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503082326.28737.gene.heskett@verizon.net>
 <20050308224441.2e29f895.akpm@osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 01:44, Andrew Morton wrote:
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> Greetings Andrew;
>
>g'day.
>
>> 2.6.11-mm2 seems to work, mostly.
>>
>> First, the ieee1394 stuff seems to have fixed up that driver, and
>> kino can access my movie cameras video over the firewire very
>> nicely without applying the bk-ieee1394-patch.  The camera has
>> builtin stereo mics in it, but nary a peep can be heard from it
>> thru the firewire.  Am I supposed to be able to hear that?
>
>Was it working with 2.6.11+bk-ieee1394.patch?  Or with anything
> else?

Yes, as long as that patch was applied.

>Cc'ed linux1394-devel@lists.sourceforge.net
>
>> Second, I have a pdHDTV-3000 card, and up till now I've been
>> overwriting the bttv stuffs with the drivers in pcHDTV-1.6.tar.gz
>> by doing a make clean;make;make install.  But now thats broken,
>> and the error message doesn't seem to make sense to this old K&R C
>> guy.
>>
>> The error exit:
>> make[1]: Entering directory `/usr/src/linux-2.6.11-mm2'
>>   CC
>> [M] 
>> /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.o
>> /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:36
>>2: error: unknown field `id' specified in initializer
>> /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:36
>>2: warning: missing braces around initializer
>> /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:36
>>2: warning: (near initialization for
>> `bttv_i2c_client_template.released')
>> make[2]: ***
>> [/usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.o]
>> Error 1
>> make[1]: ***
>> [_module_/usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver]
>> Error 2
>> make[1]: Leaving directory `/usr/src/linux-2.6.11-mm2'
>> make: *** [modules] Error 2
>>
>> The braces are indeed there.
>
>What's pcHDTV-1.6.tar.gz?  If it was merged up then these things
> wouldn't happen.
>
>CC'ed video4linux-list@redhat.com
>
>> Third, somewhere between 2.6.11-rc5-RT-V0.39-02 and 2.6.11, I've
>> lost my sensors except for one on the motherboard called THRM by
>> gkrellm-2.28.  Nothing seems to be able to bring the w83627hf back
>> to life.
>
>CC'ed sensors@Stimpy.netroedge.com

That I got, somewhere in trying to build a working kernel without the 
config_broken, i2c-isa got lost.  Restored that and all is well in 
that dept.

I've got 3 patches that remove the '&& EXPERIMENTAL' from the Kconfigs 
for the nforce2 stuffs, and even posted one here, but got .000zip 
response, so I don't know if they are welcome or not...
>
>--
>video4linux-list mailing list
>Unsubscribe
> mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> https://www.redhat.com/mailman/listinfo/video4linux-list

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
