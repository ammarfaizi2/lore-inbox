Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbTDHLcH (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 07:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTDHLcH (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 07:32:07 -0400
Received: from mail.hot.ee ([194.126.101.94]:23701 "EHLO hot.ee")
	by vger.kernel.org with ESMTP id S261470AbTDHLcC (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 07:32:02 -0400
From: Nestor Aaro <lkernel@hot.ee>
Reply-To: lkernel@hot.ee
To: linux-kernel@vger.kernel.org
Subject: PPPoE is not working with 2.5.65-67
Date: Tue, 8 Apr 2003 14:43:36 +0300
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304081443.36186.lkernel@hot.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!
I have problem starting PPPoE (rp-pppoe) on linux-2.5.65-67

System:
Slackware-9.0
GCC-3.2.2
Glibc-2.3.1

Config:
#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_KMOD is not set
-----------------------------------------------------
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=m
----------------------------------------------------
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set #- doesn't need it with rp-pppoe
# CONFIG_SLIP is not set
----------------------------------------------------

# Pseudo filesystems 
#
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVFS_DEBUG=y
# CONFIG_DEVPTS_FS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
------------------------------------------------------------------------

LOGS: 
Kernel messages:
Apr  8 14:24:12 localhost kernel: eth0: 3c5x9 at 0x300, 10baseT port, address  
00 a0 24 1d f4 7e, IRQ 10.
Apr  8 14:24:12 localhost kernel: 3c509.c:1.19b 08Nov2002 becker@scyld.com
Apr  8 14:24:12 localhost kernel: http://www.scyld.com/network/3c509.html
>
Apr  8 14:24:22 localhost kernel: eth0: Setting 3c5x9/3c5x9B half-duplex mode 
if_port: 0, sw_info: 1321
Apr  8 14:24:22 localhost kernel: CSLIP: code copyright 1989 Regents of the 
University of California
Apr  8 14:24:22 localhost kernel: PPP generic driver version 2.4.2
Apr  8 14:24:22 localhost kernel: Module ppp_async cannot be unloaded due to 
unsafe usage in include/linux/module.h:428

Syslog:
Apr  8 14:24:22 localhost kernel: eth0: Setting 3c5x9/3c5x9B half-duplex mode 
if_port: 0, sw_info: 1321
Apr  8 14:24:22 localhost kernel: Module ppp_async cannot be unloaded due to 
unsafe usage in include/linux/module.h:428
Apr  8 14:24:53 localhost pppd[158]: LCP: timeout sending Config-Requests
Apr  8 14:24:57 localhost pppoe[159]: Timeout waiting for PADO packets
Apr  8 14:27:32 localhost pppd[429]: LCP: timeout sending Config-Requests
Apr  8 14:27:36 localhost pppoe[430]: Timeout waiting for PADO packets


--------------------------------------------------------------------------
All was working fine in 2.5.52

Nastor



