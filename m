Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbRF1QFT>; Thu, 28 Jun 2001 12:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266008AbRF1QFJ>; Thu, 28 Jun 2001 12:05:09 -0400
Received: from sparrow.ists.dartmouth.edu ([129.170.249.49]:8606 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S266006AbRF1QE6>; Thu, 28 Jun 2001 12:04:58 -0400
Date: Thu, 28 Jun 2001 12:04:38 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: <wstearns@sparrow.websense.net>
Reply-To: William Stearns <wstearns@pobox.com>
To: Alan Cox <laughing@shared-source.org>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac20
In-Reply-To: <20010628164212.A27412@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0106281158070.3807-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, Alan, all,

make[1]: Entering directory `/usr/src/linux-2.4.5/scripts'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o tkparse.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkcond.o tkcond.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o tkgen.c
gcc -o tkparse tkparse.o tkcond.o tkgen.o
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/net/Config.in: 149: can't handle dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.5/scripts'
make: *** [xconfig] Error 2
XXXXXXXXXX make xconfig failed. Please fix the problem and restart.

	Line 149 is

   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI

	, which I think would normally have a dependancy after the symbol.
	The relevant part of the patch appears to be:

-   bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
+   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI

	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Man who say it cannot be done should not interrupt man doing
it."
	-- Old Chinese Proverb
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts,
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------


