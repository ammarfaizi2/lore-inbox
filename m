Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274876AbTHFFvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 01:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274877AbTHFFvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 01:51:36 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:35274 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S274876AbTHFFve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 01:51:34 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Valdis.Kletnieks@vt.edu
Subject: Re: 2.5/2.6 NVidia (was Re: 2.4 vs 2.6 version of ioport.h)
Date: Wed, 6 Aug 2003 01:51:33 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200308051041.08078.gene.heskett@verizon.net> <200308052253.57257.gene.heskett@verizon.net> <200308060306.h7636k5m003563@turing-police.cc.vt.edu>
In-Reply-To: <200308060306.h7636k5m003563@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308060151.33548.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.61.178] at Wed, 6 Aug 2003 00:51:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 August 2003 23:06, Valdis.Kletnieks@vt.edu wrote:
>On Tue, 05 Aug 2003 22:53:57 EDT, Gene Heskett said:
>> >10) 'make install' to put the /usr/lib parts in place.
>>
>> check, its rather verbose, even complained about something but I
>> didn't capture it :(
>
>This is almost certainly the cause of...
>
>> >11) Start X in the usual manner - you've probably got an XFconfig
>> > file with the right NVidia pieces in it already (or you'd not be
>> > asking ;)
>>
>> check.  Just one problem, went to black screen about the time the
>> NV logo should have popped up, and locked the machine up tight,
>> had to use the hardware reset button.
>
>this hang here.  Things to check:
>
>1) what it complained about when doing the 'make install' of the
> userspace. 2) What /var/log/XFree86.log (or wherever your X server
> output goes) says - it's usually pretty good about logging what
> it's upset about.

chicken and egg, no valid log till X is started, no machine after X is 
started.  Humm, look at log before restarting X after the reboot.  
Now, why didn't I think of that :(

>3) Make sure you have a sane setting for "Option NvAGP" in your
> XF86Config that matches what your kernel has.  It's documented in
> Appendix D of the README....

If this belongs in the 'Device' section, it wasn't there.  According 
to the README, the default is 3, which=try all options.  I put it in.

I note that in my present 2.4.22-pre10 boot, the only reference to 
this in the log is:
(II) NVIDIA(0): AGP 4X successfully initialized
IIRC, but possibly not the case in the 2.6 .config yet, is that any 
references to AGP are 'is not set'.

But on checking, thats not the case, I have this:
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_NVIDIA=y
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
CONFIG_DRM=y
-----
so I need to shut that off and let it use the nvidia version.  None of 
that is set in this 2.4.22-pre10 boot...  And its now turned off in 
the 2.6 .config too.  Its rebuilding.

Then I've been down for a couple of hours, it seems somebody took out 
a pole or something and my ups worked as expected, allowing me to do 
a gracefull shutdown in the dark.  Nice.

Thanks Valdis.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

