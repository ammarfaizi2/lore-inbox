Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSGWXm0>; Tue, 23 Jul 2002 19:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318259AbSGWXm0>; Tue, 23 Jul 2002 19:42:26 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:60866 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316161AbSGWXmZ>; Tue, 23 Jul 2002 19:42:25 -0400
Message-Id: <5.1.0.14.2.20020724000719.00af2ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 24 Jul 2002 00:45:45 +0100
To: aragorn@vime.prv.pl
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: Linux Device Driver Development Tool Kit
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020723165510.GA2673@mocosa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:55 23/07/02, Marcin Stepnicki wrote:
>I'd like to ask about http://www.jungo.com/linux.html. Do you consider
>this tool  "acceptable"? Do you think it is worth mentioning to
>companies releasing new hardware if they don't want to make their
>drivers not only open-source, but simply available (as long as Linux is
>concerned)?
>
>Please cc: me as I'm not subscribed.

I didn't go as far as downloading their trial version but a few points:

1) It doesn't produce native drivers. This is a Bad Thing(TM). Having a 
kernel driver exist in user space is not good for stability. Neither for 
speed for that matter.

2) From their own docs: "CAUTION: Since /dev/windrvr gives direct hardware 
access to user programs, it may compromise kernel stability on multi-user 
Linux systems. Please restrict access to the DriverWizard and the device 
file /dev/windrvr to trusted users." This is an ugly hack if I ever saw one.

3) The driver will be x86 only. Native drivers can be cross platform.

4) Such a driver will never be able to become part of the kernel, so the 
hardware will never be supported by default in Linux.

5) There would be no community support for the driver. The power of Linux 
is exactly the large community helping with open source drivers. This gets 
bugs fixed in a jiffie. In comparison to binary drivers or weird stuff like 
this one...

6) Did you see the prices they charge?!?

Having said all that, their hardware debugger features look quite nice. A 
gui to allow you to peek around the hardware. That can be very useful.

My conclusion would be that, no, I would not recommend people to use this 
to write Linux drivers unless they are particularly desperate... But their 
tools can be valuable to understand and test the hardware which can be an 
essential part of driver development, after all you can't write the code 
unless you understand the hardware...

Just my 2p.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

