Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVEBJwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVEBJwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 05:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVEBJwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 05:52:55 -0400
Received: from mail.dif.dk ([193.138.115.101]:3498 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261183AbVEBJwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 05:52:51 -0400
Date: Mon, 2 May 2005 11:52:23 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: kconfig: trying to assign nonexistent symbol (2.6.12-rc3-mm2)
Message-ID: <Pine.LNX.4.62.0505021148100.15343@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I usually reuse my .config between kernel versions with make oldconfig, 
but a few minutes ago I desided to build a new config from scratch and 
noticed these messages when running "make menuconfig" without an existing 
.config .

jju@jjulnx:~/download/kernel/linux-2.6.12-rc3-mm2$ make menuconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  SHIPPED scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  HOSTCC  scripts/kconfig/mconf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/mconf
  HOSTCC  scripts/lxdialog/checklist.o
  HOSTCC  scripts/lxdialog/inputbox.o
  HOSTCC  scripts/lxdialog/lxdialog.o
  HOSTCC  scripts/lxdialog/menubox.o
  HOSTCC  scripts/lxdialog/msgbox.o
  HOSTCC  scripts/lxdialog/textbox.o
  HOSTCC  scripts/lxdialog/util.o
  HOSTCC  scripts/lxdialog/yesno.o
  HOSTLD  scripts/lxdialog/lxdialog
scripts/kconfig/mconf arch/i386/Kconfig
#
# using defaults found in arch/i386/defconfig
#
arch/i386/defconfig:174: trying to assign nonexistent symbol PCI_USE_VECTOR
arch/i386/defconfig:219: trying to assign nonexistent symbol PARPORT_PC_CML1
arch/i386/defconfig:223: trying to assign nonexistent symbol PARPORT_OTHER
arch/i386/defconfig:250: trying to assign nonexistent symbol BLK_DEV_CARMEL
arch/i386/defconfig:271: trying to assign nonexistent symbol IDE_TASKFILE_IO
arch/i386/defconfig:290: trying to assign nonexistent symbol BLK_DEV_ADMA
arch/i386/defconfig:363: trying to assign nonexistent symbol SCSI_MEGARAID
arch/i386/defconfig:404: trying to assign nonexistent symbol SCSI_QLA6322
arch/i386/defconfig:475: trying to assign nonexistent symbol NETLINK_DEV
arch/i386/defconfig:567: trying to assign nonexistent symbol NET_FASTROUTE
arch/i386/defconfig:568: trying to assign nonexistent symbol NET_HW_FLOWCONTROL
arch/i386/defconfig:718: trying to assign nonexistent symbol SOUND_GAMEPORT
arch/i386/defconfig:774: trying to assign nonexistent symbol QIC02_TAPE
arch/i386/defconfig:996: trying to assign nonexistent symbol USB_STORAGE_HP8200e
arch/i386/defconfig:1022: trying to assign nonexistent symbol USB_HPUSBSCSI
arch/i386/defconfig:1057: trying to assign nonexistent symbol USB_TIGL
arch/i386/defconfig:1244: trying to assign nonexistent symbol X86_STD_RESOURCES


*** End of Linux kernel configuration.
*** Execute 'make' to build the kernel or try 'make help'.



Everything seems to be OK, just wanted to report it in case there's an 
actual problem somewhere.


-- 
Jesper Juhl

