Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263806AbRFWJGP>; Sat, 23 Jun 2001 05:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265671AbRFWJFy>; Sat, 23 Jun 2001 05:05:54 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:46852 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S263806AbRFWJFo>; Sat, 23 Jun 2001 05:05:44 -0400
To: linux-kernel@vger.kernel.org
Cc: Dylan_G@bigfoot.com
Subject: Re: Annoying kernel behaviour
In-Reply-To: <9h0r6s$fe7$1@ns1.clouddancer.com>
In-Reply-To: <3B33EFC0.D9C930D5@bigfoot.com> <9h0r6s$fe7$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010623090542.6019D7846F@mail.clouddancer.com>
Date: Sat, 23 Jun 2001 02:05:42 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>	I upgraded a fileserver to 2.4.5 because of the RAID support (the 0.90
>patch I grabbed did not apply cleanly to 2.2.19, despite it being a fresh
>copy).

Look in the people/mingo directory for a patch

>  Besides a nice speed increase (the EEPro now pumps 10 megs a second,
>instead of 2 or 3), there is a problem with the video4linux in it.  The box
>has a bttv card hooked up to a camera.  Under 2.2.19, Apache had mod_video
>installed, which would produce a jpeg of the composite in on the card (a
>cheapy CCD camera is hooked up).  Upon insmoding:

I have:

Linux video capture interface: v1.00
bttv: driver version 0.7.63 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Host bridge needs ETBF enabled.
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 00:0b.0, irq: 10, latency: 32, memory: 0xe3000000
bttv0: subsystem: 144f:3000  =>  TView 99 (CPH063)  =>  card=38
bttv0: model: BT878(TView99 CPH063) [autodetected]
bttv0: enabling ETBF (430FX/VP3 compatibilty)
i2c-core.o: adapter bt848 #0 registered as adapter 0.

 working in 2.4.5-ac12 SMP+RAID.  I used

Bttv-0.7.63-2.4.3.patch.bz2

from the website.  Video4linux has always worked in the various 2.4
kernels I've tried.


>and accesing mod_video, the box locked up hard (not even sysrq worked).  And

I don't run mod_video, but xawtv works fine.  Did you try that or
rebuilding mod_video?


>when I rebooted, I found that some files is /etc were eaten -- even though

You must have grues.


-- 
"Or heck, let's just make the VM a _real_ Neural Network, that self
trains itself to the load you put on the system. Hideously complex and
evil?  Well, why not wire up that roach on the floor, eating that stale
cheese doodle. It can't do any worse job on VM that some of the VM
patches I've seen..."  -- Jason McMullan

ditto
