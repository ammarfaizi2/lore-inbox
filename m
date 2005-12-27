Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVL0Ifx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVL0Ifx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 03:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVL0Ifx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 03:35:53 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:40923 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932263AbVL0Ifw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 03:35:52 -0500
Message-ID: <43B0D585.3070700@m1k.net>
Date: Tue, 27 Dec 2005 00:47:49 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Knecht <markknecht@gmail.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ho ho ho.. Linux 2.6.15-rc7
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org> <5bdc1c8b0512261002n6167a78ewfc45a6d3a5078ac0@mail.gmail.com>
In-Reply-To: <5bdc1c8b0512261002n6167a78ewfc45a6d3a5078ac0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Knecht wrote:

>On 12/24/05, Linus Torvalds <torvalds@osdl.org> wrote:
>  
>
>>Please do give it a try, and if you have any issues/regressions, send out
>>a note (even if you sent one earlier) so that we don't forget about it.
>>    
>>
>I've visiting at my parents house and gave 2.6.15-rc7 a try on my
>dad's machine. This machine is his normal desktop box which I
>administer remotely, as well as a MythTV server. The new kernel built
>and booted fine. I then built the NVidia stuff. However when I tried
>to build the ivtv driver from portage it failed:
>  
>
>>>>Unpacking ivtv-0.4.0.tar.gz to /var/tmp/portage/ivtv-0.4.0-r2/work
>>>>Unpacking pvr_2.0.24.23035.zip to /var/tmp/portage/ivtv-0.4.0-r2/work
>>>>Source unpacked.
>>>>        
>>>>
> * Preparing ivtv module
>created ivtv-svnversion.h
>make CONFIG_VIDEO_IVTV=m -C /usr/src/linux
>M=/var/tmp/portage/ivtv-0.4.0-r2/work /ivtv-0.4.0/driver modules
>make[1]: Entering directory `/usr/src/linux-2.6.15-rc7'
>  CC [M]  /var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver/msp3400.o
>In file included from
>/var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver/comp at.h:77,
>                 from
>/var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver/msp3 400.c:52:
>include/linux/videodev.h: In function `video_device_create_file':
>include/linux/videodev.h:21: error: dereferencing pointer to incomplete type
>include/linux/videodev.h: In function `video_device_remove_file':
>include/linux/videodev.h:27: error: dereferencing pointer to incomplete type
>In file included from
>/var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver/comp at.h:77,
>                 from
>/var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver/msp3 400.c:52:
>include/linux/videodev.h:30:5: warning: "OBSOLETE_OWNER" is not defined
>include/linux/videodev.h: At top level:
>include/linux/videodev.h:204: error: `VIDEO_MAX_FRAME' undeclared here
>(not in a  function)
>make[2]: *** [/var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver/msp3400.o]
>E rror 1
>make[1]: *** [_module_/var/tmp/portage/ivtv-0.4.0-r2/work/ivtv-0.4.0/driver]
>Err or 2
>make[1]: Leaving directory `/usr/src/linux-2.6.15-rc7'
>make: *** [all] Error 2
>
>!!! ERROR: media-tv/ivtv-0.4.0-r2 failed.
>!!! Function linux-mod_src_compile, Line 505, Exitcode 2
>!!! Unable to make                                  KDIR=/usr/src/linux all.
>!!! If you need support, post the topmost build error, NOT this status message.
>
>gandalf src #
>
>   Most probably this is stuff the Gentoo devs will clean up when the
>real kernel comes out but I *think* you were asking for this sort of
>info so I'm posting it back.
>  
>
Mark-

You don't have to worry about this... Since ivtv is an out-of-tree 
kernel module, and 2.6.15 is not released to mainline yet, so you cant 
expect the distros to make their external driver packages compatable.

Anyhow, I believe that ivtv 0.5.x is meant to be built against 2.6.15 
...  We have been merging some of the modules from ivtv into v4l, and 
some of those modules have already made it into 2.6.15.  I think you 
will run into module collisions using ivtv 0.4.x with kernel 2.6.15, but 
i'm not sure about that.  Please see the ivtv mailing list / web site 
for more information about this, and how to get it to work with your kernel.

Eventually, the ivtv driver will entirely be merged into v4l (and the 
kernel), and things will be much easier.  Until then, you should try the 
new 0.5.x version of ivtv with Kernel 2.6.15

Cheers,

-Michael
