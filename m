Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271333AbTHRIpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 04:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271335AbTHRIpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 04:45:22 -0400
Received: from [195.70.253.128] ([195.70.253.128]:43392 "EHLO newmx4")
	by vger.kernel.org with ESMTP id S271333AbTHRIpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 04:45:17 -0400
Date: Mon, 18 Aug 2003 10:44:46 +0200
To: linux-kernel@vger.kernel.org
Subject: i865G chipset AGP support - report
Message-ID: <20030818084446.GI5732@marvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
From: VEGH Karoly <karoly.vegh@uta.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just found an interesting behaviour of the agpgart code in
the Linux kernel with a (quite new chipset) MSI 865PE motherboard.

in the /usr/src/linux/drivers/char/agp/agpgart_be.c 2 names are in, 
but AFAIK Jeff Hartmann doesn't actively maintain the code anymore,
(also couldn't reach him at jhartmann@precisioninsight.com), and 
I'm not quite sure if David Dawes got my report, so I decided to 
post here.

Please let me have a CC personally if you reply.

I have quite a new motherboard, (MSI 865PE) with an Sapphire
Radeon 9500 128Mb card.

The agpgart module I can load fine with the 2.4.22-pre10 kernel-version:

bh:/usr/src# uname -a 
Linux bh 2.4.22-pre10 #1 Sat Aug 2 09:38:38 CEST 2003 i686 GNU/Linux
bh:/usr/src# dmesg | grep -i agp
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: Detected Intel(R) 865G chipset
agpgart: AGP aperture is 64M @ 0xf8000000
bh:/usr/src# 

couldn't load it with 2.4.22-pre8 (that's why the upgrade), I thought 
it was fixed, but now with 2.4.22-rc2 I again get the same errormsg 
that i got with 2.4.22-pre8:

bh:~# uname -a 
Linux bh 2.4.22-rc2 #1 Wed Aug 13 19:28:57 CEST 2003 i686 GNU/Linux
bh:~# modprobe agpgart
/lib/modules/2.4.22-rc2/kernel/drivers/char/agp/agpgart.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-rc2/kernel/drivers/char/agp/agpgart.o: insmod /lib/modules/2.4.22-rc2/kernel/drivers/char/agp/agpgart.o failed
/lib/modules/2.4.22-rc2/kernel/drivers/char/agp/agpgart.o: insmod agpgart failed
bh:~# dmesg | grep -i agp
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: Detected an Intel(R) 865G, but could not find the secondary device. Assuming a non-integrated video card.
agpgart: unsupported bridge
agpgart: no supported devices found.
bh:~#

Question: Whom can I help you with more information? What info do you need
more from me that can help your work?

Is the Documentation up-to-date? Chipset 865 isn't mentioned in it, (although 
it works with -pre10)

Intel 440LX/BX/GX/815/820/830/840/845/850/860 support
CONFIG_AGP_INTEL
  This option gives you AGP support for the GLX component of the
  XFree86 4.x on Intel 440LX/BX/GX, 815, 820, 830, 840, 845, 850 and 860 chipsets.

and didnt find the ChangeLog as well...

bh:/usr/src/linux/drivers/char# find . -iname changelog -type f
./ChangeLog
bh:/usr/src/linux/drivers/char# grep -i agp ChangeLog 
bh:/usr/src/linux/drivers/char# 

TIA & HTH

charlie

-- 
Végh Károly -  System Engineer - UTA - TIS.SAS.BSS
Don't worry. Everything is getting nicely out of control.
