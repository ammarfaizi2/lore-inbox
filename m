Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265874AbTGEIuq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 04:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbTGEIuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 04:50:46 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:18245 "EHLO
	mwinf0601.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265874AbTGEIuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 04:50:44 -0400
Date: Sat, 5 Jul 2003 10:54:42 +0200
From: Jean-Luc <jean-luc.coulon@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.5.74 compile error
Message-ID: <20030705085442.GA13606@tangerine>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get the following compile error :

   CPP     arch/i386/vmlinux.lds.s
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
drivers/built-in.o(.init.text+0x2443): In function `ide_setup':
: undefined référence to « cmd640_vlb »
drivers/built-in.o(.init.text+0x28e1): In function `probe_for_hwifs':
: undefined reference to « ide_probe_for_cmd640x »
make[1]: *** [.tmp_vmlinux1] Erreur 1
make[1]: Leaving directory `/usr/src/linux-2.5.74'
make: *** [stamp-build] Erreur 2

I use gCONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
# CONFIG_BLK_DEV_IDEPCI is not set
CONFIG_IDE_CHIPSETS=y

#
# Note: most of these also require special kernel boot parameters
#
# CONFIG_BLK_DEV_4DRIVES is not set
CONFIG_BLK_DEV_ALI14XX=y
# CONFIG_BLK_DEV_DTC2278 is not set
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_PDC4030 is not set
# CONFIG_BLK_DEV_QD65XX is not set
# CONFIG_BLK_DEV_UMC8672 is not set
CONFIG_BLK_DEV_IDE_MODES=y

cc 3.3

here is the .config part for the ide drivers:

---
Regards
	Jean-Luc
