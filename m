Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVCIHnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVCIHnz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 02:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVCIHnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 02:43:55 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:32484 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261641AbVCIHnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 02:43:17 -0500
Date: Wed, 09 Mar 2005 02:43:04 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime
In-reply-to: <20050308224441.2e29f895.akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, linux1394-devel@lists.sourceforge.net,
       video4linux-list@redhat.com, sensors@stimpy.netroedge.com
Reply-to: gene.heskett@verizon.net
Message-id: <200503090243.06270.gene.heskett@verizon.net>
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
g'day to you, sir.

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

It did work previously with the svn download from the ieee1394 site 
for the kernels in the series of RT stuff that Ingo Molnar was 
working on.  Also, since I posted this, I tried catting a .wav file 
to /dev/dsp, which is the output that kino is expecting to use, and 
that sort of worked, playing the file at half speed and pitch.  So I 
believe its the upload from the camera, and the stripping of the 
audio data from the stream from the camera thats at fault.  But thats 
just a SWAG on my part, & I probably should not have used the S 
there. :)

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
This is the latest driver set for this card, downloadable from the 
pcHDTV site.  It overwrites, when it builds and installs, the bttv 
and cx88xx stuffs in the modules dir.  And it has worked up to 
2.6.11-mm2, but I didn't get around to trying mm1. It worked with the 
last of the RT's from Ingo, and for 2.6.11(.1).

>CC'ed video4linux-list@redhat.com
>> Third, somewhere between 2.6.11-rc5-RT-V0.39-02 and 2.6.11, I've
>> lost my sensors except for one on the motherboard called THRM by
>> gkrellm-2.28.  Nothing seems to be able to bring the w83627hf back
>> to life.

I'm back on 2.6.11-rc5 and thats working as expected now.

>CC'ed sensors@Stimpy.netroedge.com

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
