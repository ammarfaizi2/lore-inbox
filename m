Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135266AbRDRTgT>; Wed, 18 Apr 2001 15:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135268AbRDRTgA>; Wed, 18 Apr 2001 15:36:00 -0400
Received: from granada.iram.es ([150.214.224.100]:1298 "EHLO granada.iram.es")
	by vger.kernel.org with ESMTP id <S135266AbRDRTf5>;
	Wed, 18 Apr 2001 15:35:57 -0400
Date: Wed, 18 Apr 2001 21:35:48 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Grant Erickson <erick205@umn.edu>
cc: Linux I2C Mailing List <linux-i2c@pelican.tk.uni-linz.ac.at>,
        Linux/PPC Embedded Mailing List 
	<linuxppc-embedded@lists.linuxppc.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Real Time Clock (RTC) Support for I2C Devices
In-Reply-To: <Pine.SOL.4.20.0104181408540.10793-100000@garnet.tc.umn.edu>
Message-ID: <Pine.HPX.4.10.10104182129390.11443-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Apr 2001, Grant Erickson wrote:

> >From the looks of drivers/char/rtc.c it would appear that this kernel
> driver only supports bus-attached RTCs such as the mentioned MC146818. Is
> this correct?

I think so. 

> 
> What is the correct access method / kernel tie-in for supporting such an
> I2C-based RTC device using the "standard" interfaces?

Adding a new kind of clock to the kernel and setting the correct pointers
in ppc_md seems the right (if not necessarily simple) solution to your
problem.  

I wonder how you calibrate the decrementer frequency on this machine, I2C
is too slow to get any precision, unless you accept to wait for one minute
or so at boot. I still have problems of reproducibility of clock frequency
measurements with bus attached RTC (on machines on which the RTC is the
only moderately precise timing source and its interrupt line is
unfortunately not connected).

> 
> My hope is to use 'hwclock' from util-linux w/o modification. Is this
> reasonable?

No.

	Regards,
	Gabriel.

