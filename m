Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135273AbRDRTku>; Wed, 18 Apr 2001 15:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135274AbRDRTkl>; Wed, 18 Apr 2001 15:40:41 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:26373 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135273AbRDRTkX>; Wed, 18 Apr 2001 15:40:23 -0400
To: Grant Erickson <erick205@umn.edu>
Cc: Linux I2C Mailing List <linux-i2c@pelican.tk.uni-linz.ac.at>,
        Linux/PPC Embedded Mailing List 
	<linuxppc-embedded@lists.linuxppc.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Kernel Real Time Clock (RTC) Support for I2C Devices 
X-Mailer: exmh version 2.2
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: Your message of "Wed, 18 Apr 2001 14:13:33 CDT."
             <Pine.SOL.4.20.0104181408540.10793-100000@garnet.tc.umn.edu> 
Date: Wed, 18 Apr 2001 21:40:32 +0200
Message-Id: <20010418194037.C55DB2792B@denx.denx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Grant,

in message <Pine.SOL.4.20.0104181408540.10793-100000@garnet.tc.umn.edu> you wrote:
> 
> >From the looks of drivers/char/rtc.c it would appear that this kernel
> driver only supports bus-attached RTCs such as the mentioned MC146818. Is
> this correct?

This is correct; however, you can replace this driver by one of  your
own  (see for instance drivers/char/ip860_rtc.c in our version of the
2.4.x Linux sources which implements the RTC driver for a  V3021  RTC
on a IP860 VMEBus system [MPC860 based]).

Right now I'm writing another driver for  the  Philips  PCF8563  RTC,
which is much closer to what you have in mind.

> What is the correct access method / kernel tie-in for supporting such an
> I2C-based RTC device using the "standard" interfaces?

Assuming you have a working I2C driver, just add the necessary "glue"
code to provide the same interface as that of drivers/char/rtc.c .

> My hope is to use 'hwclock' from util-linux w/o modification. Is this
> reasonable?

Yes, this will work (it does for me on the MPC8xx).

Hope this helps,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The universe does not have laws - it has habits, and  habits  can  be
broken.
