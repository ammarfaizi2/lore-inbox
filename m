Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267024AbSL3SNZ>; Mon, 30 Dec 2002 13:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbSL3SNZ>; Mon, 30 Dec 2002 13:13:25 -0500
Received: from tomts26.bellnexxia.net ([209.226.175.189]:47583 "EHLO
	tomts26-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267024AbSL3SNX>; Mon, 30 Dec 2002 13:13:23 -0500
Date: Mon, 30 Dec 2002 13:18:04 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: linux-kernel@vger.kernel.org
Subject: my observations about 2.4.21-pre2
Message-ID: <Pine.LNX.4.44.0212301304150.25855-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  since my list is not all that lengthy, i figured i'd
just post my observations here.

  based on building a 2.4.21-pre2 kernel on a stock
red hat 8.0 system:


General setup -> Power management support
  Disabling Power management support still leaves the *suboptions*
  under APM BIOS support active, even thought the option
  for APM BIOS support itself is grayed out.  is this meaningful?
  there seems to some weird dysfunctional relationship between
  the options for general power management support, and the
  specific ACPI and APM support options.
    

Under Parallel port support, there are duplicated entries for
  "Support for PCMCIA management for PC-style ports", with the
  first entry being grayed out, although i'm sure many folks
  have already noticed this.


Why can't I deactivate all gigabit ethernet settings in one click,
  like I can with 10/100 Mbit settings?  as the choices for 
  gigabit ethernet grow, that list is going to get inconveniently
  long.  a single top option to deselect all of them would be nice.


If i deselect "Joysticks" completely under "Input core", there are
  still a number of available features i can pick under "Joysticks".
  granted, some of them appear to be more than just simple joystick
  options, but perhaps these screens could be better arranged?
  what does it mean to deselect joysticks, only to be able to 
  still pick some of them later?


finally, firewire compilation error(had to deselect firewire to build):

	 make -C ieee1394 modules
make[2]: Entering directory `/usr/src/linux-2.4.21-pre2/drivers/ieee1394'
ld -m elf_i386 -e stext -r -o ieee1394.o ieee1394_core.o ieee1394_transactions.o hosts.o highlevel.o csr.o nodemgr.o
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.21-pre2/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=sbp2  -c -o sbp2.o sbp2.c
sbp2.c:1515: conflicting types for `sbp2_handle_physdma_write'
sbp2.h:508: previous declaration of `sbp2_handle_physdma_write'
sbp2.c:1531: conflicting types for `sbp2_handle_physdma_read'
sbp2.h:510: previous declaration of `sbp2_handle_physdma_read'
make[2]: *** [sbp2.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.21-pre2/drivers/ieee1394'
make[1]: *** [_modsubdir_ieee1394] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21-pre2/drivers'
make: *** [_mod_drivers] Error 2


  someone else emailed me that he could get firewire to build by
replacing the stock gcc-3.2-7 that came with red hat with 
gcc-3.2.1, but i just deselected firewire for the time being.

  anyway, that's my contribution, for what it's worth.

rday

