Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268570AbRHAWiU>; Wed, 1 Aug 2001 18:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268556AbRHAWiK>; Wed, 1 Aug 2001 18:38:10 -0400
Received: from ns.suse.de ([213.95.15.193]:37394 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S268551AbRHAWhx>;
	Wed, 1 Aug 2001 18:37:53 -0400
Date: Thu, 2 Aug 2001 00:37:47 +0200
From: Stefan Reinauer <stepan@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] /dev/bios 0.3.1 released
Message-ID: <20010802003747.A7850@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
X-OS: Linux 2.4.7 ia64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear hackers,

weren't you ever frustrated about the fact that updating your hardware's
flash firmware needs proprietary closed source software installed?
There's a solution to this problem: a kernel driver for different kinds
of (Flash)BIOSs that are available in today's x86 or Alpha AXP hardware.

It's /dev/bios - and the latest version 0.3.1 was released recently.

There are well known BIOSs for 

   * System BIOS (resides at 0xe0000) 
   * graphics hardware (e.g. VGA-adapters at 0xc0000) 
   * SCSI host adapters 
   * networking interfaces with 'BOOT ROM' 
   * ... 

While in former times these BIOSs were implemented by using ROM or EPROM
(both can't be updated without opening your computer) today's PC hardware
is normally delivered with so called FLASH ROMs. These can simply be updated
by software. This driver has the approach to make Linux read and write flash
roms.

What's new in 0.3.1?

   * compiles and works with Linux kernel 2.4 
   * rewrote flash chip probing 
   * always use ioremap now 
   * flash chips above 128k should work transparent 
   * Support for newer VIA chipsets 

Devbios can be downloaded from http://www.freiburg.linux.de/~stepan/bios/

Please be sure to READ the README ;-) As long as you load the module without
special parameters, it's in readonly mode and can't mess up your system, so
please don't hesitate to try it out and mail me any test results 

Best regards,
   Stefan Reinauer, <stepan@suse.de>

--
OpenBIOS - free your system.
