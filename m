Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266557AbUFQPgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266557AbUFQPgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUFQPgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:36:00 -0400
Received: from [61.49.235.7] ([61.49.235.7]:45046 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S266558AbUFQPdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:33:12 -0400
Date: Thu, 17 Jun 2004 23:29:55 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200406180629.i5I6Ttn04674@freya.yggdrasil.com>
To: hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: more files with licenses that aren't GPL-compatible
Cc: greg@kroah.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-06-15, Christoph Hellwig wrote:
>While I don't want to jump into the usual Debian wankfest whether Linux
>as GPL'ed project can distribute hex-images of firmware at all there are
>a few firmware C headers files that have a license statement that aren't
>GPL-compatible at all, namely the keyspan firmware in
>drivers/usb/serial/keyspan*_fw.h with the following license text:
>
>
>---------------------------- snip ----------------------------
>        The firmware contained herein as keyspan_mpr_fw.h is
>
>                Copyright (C) 1999-2001
>                Keyspan, A division of InnoSys Incorporated ("Keyspan")
>                
>        as an unpublished work. This notice does not imply unrestricted or
>        public access to the source code from which this firmware image is
>        derived.  Except as noted below this firmware image may not be 
>        reproduced, used, sold or transferred to any third party without 
>        Keyspan's prior written consent.  All Rights Reserved.
>
>        Permission is hereby granted for the distribution of this firmware 
>        image as part of a Linux or other Open Source operating system kernel 
>        in text or binary form as required. 
>
>        This firmware may not be modified and may only be used with  
>        Keyspan hardware.  Distribution and/or Modification of the 
>        keyspan.c driver which includes this firmware, in whole or in 
>        part, requires the inclusion of this statement."
>---------------------------- snip ----------------------------
>
>which makes the kernel as whole unredistributable.  A similar license
>was according to Greg also recently granted for
>drivers/usb/misc/emi62_fw_*.h which currently has even worse license
>statements in there.
>
>Does someone have good contacts to keyspan to get it under a more
>suitable license?

	I pointed out this problem years ago, during 2.4.  Some may
think this was going overboard, but, to avoid legal liability, I
closed the FTP area of the ftp.yggdrasil.com kernel mirror that
included the kernels with the infringing firmware (not that many
people used it then).

	At that time, I also posted patches to remove the code
and a GPL'ed utility to automatically load the right firmware
from userland on a hotplug event when the device is plugged in.  At
least one person posted that he tried the code and it worked fine.

	I believe that Greg Kroah-Hartmann said that the changes
should go into 2.5.  I'm still waiting, although I don't know if
I even have a copy of the user level helper code anymore.

	I am not a lawyer, so please do not take the following as
legal advice.

	I believe that distribution of Linux kernel binaries that
compile in this firmware is direct copyright infringment, and
that distribution of Linux kernel modules that compile in
this firmware is contributory copyright infringement (to the direct
infringmenet that occurs when the image is created in RAM, and
there are US court cases that say that copying into RAM is copying
for the purposes of copyright).

	The United States Copyright Office has issued a copyright
registration to Yggdrasil Computing for some software in the Linux
USB serial drivers.  Yggdrasil Computing has never given permission
for distribution of GPL-incompatible firmware with that software.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
