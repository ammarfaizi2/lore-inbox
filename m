Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTKVQqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 11:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTKVQqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 11:46:38 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:10258 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S262356AbTKVQqf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 11:46:35 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: modular IDE in 2.4.23
Date: Sat, 22 Nov 2003 17:46:03 +0100
User-Agent: KMail/1.5.93
Cc: Alan Cox <alan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200311221746.03690.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Modular IDE no longer works in 2.4.23 (I'm testing rc3). I'm getting

depmod: *** Unresolved symbols 
in /lib/modules/2.4.23-0.1/kernel/drivers/ide/ide-core.o
depmod:         init_cmd640_vlb
depmod:         ide_wait_hwif_ready
depmod:         ide_probe_for_drive
depmod:         ide_probe_reset
depmod:         ide_tune_drives

This is regression since in 2.4.21 and 2.4.22 modular IDE was working fine on 
my x86.

Is anyone working on fixing that regression?

_BLK_ options from config

CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_PS2=m
CONFIG_BLK_DEV_XD=m
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_BLK_DEV_DAC960=m
CONFIG_BLK_DEV_UMEM=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_NWD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_STATS=y
CONFIG_BLK_DEV_MD=m
CONFIG_BLK_DEV_LVM=m
CONFIG_BLK_DEV_DM=m
CONFIG_BLK_DEV_DM_MIRROR=m
CONFIG_BLK_DEV_DM_BBR=m
CONFIG_BLK_DEV_DM_SPARSE=m
CONFIG_BLK_DEV_IDE=m
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_OFFBOARD=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA100=m
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=m
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_TRIFLEX=m
CONFIG_BLK_DEV_CY82C693=m
CONFIG_BLK_DEV_CS5530=m
CONFIG_BLK_DEV_HPT34X=m
CONFIG_BLK_DEV_HPT366=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_PDC202XX_OLD=m
CONFIG_BLK_DEV_PDC202XX_NEW=m
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_SC1200=m
CONFIG_BLK_DEV_SVWKS=m
CONFIG_BLK_DEV_SIIMAGE=m
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_BLK_DEV_4DRIVES=y
CONFIG_BLK_DEV_ALI14XX=m
CONFIG_BLK_DEV_DTC2278=m
CONFIG_BLK_DEV_HT6560B=m
CONFIG_BLK_DEV_PDC4030=m
CONFIG_BLK_DEV_QD65XX=m
CONFIG_BLK_DEV_UMC8672=m
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_PDC=m
CONFIG_BLK_DEV_ATARAID_HPT=m
CONFIG_BLK_DEV_ATARAID_SII=m
CONFIG_BLK_DEV_SD=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_BLK_DEV_3W_XXXX_RAID=m

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
