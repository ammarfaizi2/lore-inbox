Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132337AbRDCC5G>; Mon, 2 Apr 2001 22:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132459AbRDCC45>; Mon, 2 Apr 2001 22:56:57 -0400
Received: from [204.130.184.93] ([204.130.184.93]:40851 "EHLO
	mars.starshine.org") by vger.kernel.org with ESMTP
	id <S132370AbRDCC4s>; Mon, 2 Apr 2001 22:56:48 -0400
Message-Id: <200104030257.TAA20765@mars.starshine.org>
To: "Green" <greeen@iii.org.tw>
cc: "LinuxKernelMailList" <linux-kernel@vger.kernel.org>,
        "MipsMailList" <linux-mips@fnet.fr>,
        "LinuxEmbeddedMailList" <linux-embedded@waste.org>
X-From: Jim Dennis <jimd@starshine.org> 
X-Mailer: NMH 
X-GnuPG-Fingerprint: 66A0 25A0 57AF 963C 414C  0DD7 2065 7DEC 123E C631
X-Content-Type: application/pgp; format=text; x-action=sign
Subject: Re: Serial Console!! 
In-Reply-To: <001201c0bb3f$4dd65600$4c0c5c8c@trd.iii.org.tw> 
	Message Apparently From "Green" <greeen@iii.org.tw> 
	Dated Mon, 02 Apr 2001 14:36:50 +0800.
Date: Mon, 02 Apr 2001 19:57:38 -0700
From: Jim Dennis <jimd@starshine.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apparently "Green" <greeen@iii.org.tw>  wrote:

> Hi all,
 
> I want to login to my MIPS box through serial port.
> I execute 'make menuconfig' and select the 'serial console'.
> But I can't see the login prompt in my window(I use netterm).
 
> May I ask how serial console work?
> Or I forget something?
 
> P.S I skip /sbin/init program.

 In order for you to have full serial console port you 
 must do more than simply enable the option in your kernel.

 Your BIOS/firmware should have serial console support of
 its own (most PCs don't, most other systems, even most 
 PowerPC based Macs and workstations do, in the form of 
 OpenFirmware --- formerly known as Sun's FCODE).  

 Your MIPS box might have a firmware with serial console
 support, or it might not.

 That should allow you to access any pre-boot configuration
 options or diagnostics (including providing some mechanism
 to reset the NVRAM and to set the boot device or sequence)

 Your bootloader would have to support serial console
 to allow you to select which kernel you want to load
 and/or to pass kernel command line options and set
 initial environment variable/value pairs (a feature
 that seems unique to Linux).

 Of course, the Linux kernel support must be enabled,
 though that *only* applies to whether the kernel messages
 are copied to that device.  If you would see it from 
 dmesg, then it won't get copied to the console.

 To enable logins on a serial device you must spawn 
 some form of getty process (normally done by init).  That
 will listen for connections (normallly by taking login names)
 and exec() your login program (usually with the login name passed
 on its argument list).

 Since you specify that you're not running init, it's obvious
 why you can't "login."

 So, please tell me that you didn't actually think that 
 logins and shells were handled directly by UNIX and Linux
 kernels!
 
 
--
Jim Dennis               
Software Analyst		
Axis Personal Trainers			http://www.axispt.com

