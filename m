Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261792AbSIXUr1>; Tue, 24 Sep 2002 16:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261790AbSIXUrK>; Tue, 24 Sep 2002 16:47:10 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:45244 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S261796AbSIXUp7>; Tue, 24 Sep 2002 16:45:59 -0400
Message-ID: <3D91413C.1050603@goingware.com>
Date: Wed, 25 Sep 2002 00:53:16 -0400
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.0.0) Gecko/20020622 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Conserving memory for an embedded application
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am helping my client design an embedded hardware device that we may run Linux 
on.  An important concern is to minimize the amount of ROM and flash ram that 
the device has, both to save manufacturing cost and to minimize power consumption.

One question I have is whether it is possible to burn an uncompressed image of 
the kernel into flash, and then boot the kernel in-place, so that it is not 
copied to RAM when it runs.  Of course the kernel would need RAM for its data 
structures and user programs, but it would seem to me I should be able to run 
the kernel without making a RAM copy.

It would be OK if I had to mess with the bootloader to do this.

It would also be helpful if a filesystem image containing a user program could 
be burned into flash, and then the program run directly out of flash.  Some 
amount of RAM would be saved if the executing code were run from the flash ROM 
rather than being copied into RAM as would normally be the case when executing a 
demand-paged executable.

This last is probably not as important as running the kernel out of flash as I 
don't think the user program would be very large.

Also, what is the minimum amount of physical ram that you think I can get any 
version of the kernel later than 2.0 or so to run in?  I heard somewhere that 
someone can boot an x86 system with as little as 2MB of RAM.  Is that the case?

Thank you,

Mike
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

      Tilting at Windmills for a Better Tomorrow.

