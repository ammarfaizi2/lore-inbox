Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLDVE3>; Mon, 4 Dec 2000 16:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLDVET>; Mon, 4 Dec 2000 16:04:19 -0500
Received: from 213.237.11.204.adsl.vbr.worldonline.dk ([213.237.11.204]:12601
	"HELO 213.237.11.204.adsl.vbr.worldonline.dk") by vger.kernel.org
	with SMTP id <S129183AbQLDVER>; Mon, 4 Dec 2000 16:04:17 -0500
Date: Mon, 4 Dec 2000 21:33:48 +0100
From: Henrik Størner <henrik@storner.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12pre4: parport / lp problems
Message-ID: <20001204213348.A932@storner.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered yesterday that printing does not work in 2.4.0-test12-pre4.

This is a pretty stock PC system with a printer on the parallel port.
Both parport and lp is compiled into the kernel - and the parport
appears to be detected OK, but the lp driver for some reason refuses
to use it:

[snip /var/log/dmesg]
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP]
parport0: irq 7 detected
[later]
pty: 256 Unix98 ptys configured
parport0: no more devices allowed
lp: driver loaded but no devices found

In lilo, I have tried different configuration parameters. The current
setup has no parport or lp settings, but I have also tried
  "parport=0x378,7 lp=parport0"
with no apparent effect. This setting used to work in earlier 2.4
configurations (cannot say exactly which worked and which didn't).


Kernel config:

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set
[snip]
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set


Suggestions ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
