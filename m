Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbTC3Rp7>; Sun, 30 Mar 2003 12:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbTC3Rp7>; Sun, 30 Mar 2003 12:45:59 -0500
Received: from mail.hot.ee ([194.126.101.94]:14277 "EHLO hot.ee")
	by vger.kernel.org with ESMTP id <S261505AbTC3Rp5>;
	Sun, 30 Mar 2003 12:45:57 -0500
From: Nestor Aaro <lkernel@hot.ee>
Reply-To: lkernel@hot.ee
To: linux-kernel@vger.kernel.org
Subject: Problem with PPP on 2.5.65-66
Date: Sun, 30 Mar 2003 20:57:14 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303302057.14704.lkernel@hot.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all!
I have problem starting ADSL connection on 2.5.65-66 kernels. Using roaring 
penguins software (rp-pppoe).
Configuration: 
Slackware linux.
GCC-3.2.2
GlibC-2.3.1
module-init-tools-0.9.10
Kernel Config:
----------------
#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set
-----------------
#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=m
# CONFIG_3C515 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
--------------
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set
------------------------------------------------------------------------------

Logs:
kernelmessages:
Mar 30 20:01:13 localhost kernel: 3c509.c:1.19b 08Nov2002 becker@scyld.com
Mar 30 20:01:13 localhost kernel: http://www.scyld.com/network/3c509.html
Mar 30 20:01:13 localhost kernel: loop: loaded (max 8 devices)
Mar 30 20:01:13 localhost kernel: Linux video capture interface: v1.00
Mar 30 20:01:13 localhost kernel: Gemtek PCI Radio (rev. 1) found at 
0x9800-0x9803.
Mar 30 20:01:13 localhost kernel: i2c-proc.o version 2.7.0 (20021208)
Mar 30 20:01:13 localhost kernel: i2c-piix4 version 2.7.0 (20021208)
Mar 30 20:01:13 localhost kernel: piix4 smbus 00:07.3: Found Intel Corp. 
82371AB/EB/MB PIIX4  device
Mar 30 20:01:13 localhost kernel: spurious 8259A interrupt: IRQ7.
Mar 30 20:01:25 localhost kernel: eth0: Setting 3c5x9/3c5x9B half-duplex mode 
if_port: 0, sw_info: 1321
Mar 30 20:01:25 localhost kernel: CSLIP: code copyright 1989 Regents of the 
University of California
Mar 30 20:01:25 localhost kernel: PPP generic driver version 2.4.2
Mar 30 20:01:25 localhost kernel: Module ppp_async cannot be unloaded due to 
unsafe usage in include/linux/module.h:432

messages:
Mar 30 20:01:25 localhost kernel: eth0: Setting 3c5x9/3c5x9B half-duplex mode 
if_port: 0, sw_info: 1321
Mar 30 20:01:25 localhost kernel: CSLIP: code copyright 1989 Regents of the 
University of California
Mar 30 20:01:25 localhost kernel: PPP generic driver version 2.4.2
Mar 30 20:01:25 localhost pppd[154]: pppd 2.4.1 started by root, uid 0
Mar 30 20:01:25 localhost kernel: Module ppp_async cannot be unloaded due to 
unsafe usage in include/linux/module.h:432
Mar 30 20:01:25 localhost pppd[154]: Using interface ppp0
Mar 30 20:01:25 localhost pppd[154]: Connect: ppp0 <--> /dev/pts/0
Mar 30 20:01:56 localhost pppd[154]: LCP: timeout sending Config-Requests 
Mar 30 20:01:56 localhost pppd[154]: Connection terminated.
Mar 30 20:02:00 localhost pppoe[155]: Timeout waiting for PADO packets
Mar 30 20:02:00 localhost pppd[154]: Exit.

syslog:
Mar 30 20:01:25 localhost kernel: eth0: Setting 3c5x9/3c5x9B half-duplex mode 
if_port: 0, sw_info: 1321
Mar 30 20:01:25 localhost kernel: Module ppp_async cannot be unloaded due to 
unsafe usage in include/linux/module.h:432
Mar 30 20:01:56 localhost pppd[154]: LCP: timeout sending Config-Requests 
Mar 30 20:02:00 localhost pppoe[155]: Timeout waiting for PADO packets

-----------------------------------------------------------------------------------------------
Compiling ppp modules in to the kernel gives the same result.
I have no problems on 2.4.20

Sorry for my english! :)

Nestor



