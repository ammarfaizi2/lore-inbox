Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSGXHAn>; Wed, 24 Jul 2002 03:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSGXHAn>; Wed, 24 Jul 2002 03:00:43 -0400
Received: from rj.SGI.COM ([192.82.208.96]:40864 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S316896AbSGXHAl>;
	Wed, 24 Jul 2002 03:00:41 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Build Errors] kernel version 2.5.27 
In-reply-to: Your message of "Tue, 23 Jul 2002 11:14:38 +0200."
             <20020723091438.GB3455@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Jul 2002 17:03:43 +1000
Message-ID: <19423.1027494223@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002 11:14:38 +0200, 
Jose Luis Domingo Lopez <linux-kernel@24x7linux.org> wrote:
>.config file was created the "easy" way: going to all options shown in a
>"make menuconfig" session, enabling everything to be built-in (when
>possible)

make allyesconfig

>Of course, if someone is doing something similar, the process is
>badly thought of, or simply nobody sees it as useful, plese speak :).

Use .force_default with all{yes,mod}config to ignore options that are
known not to build.  My 2.5.27 .force_default contains

# Need _MODULE for a full test
CONFIG_MODULES=y

# CML1 has problems with _PROC_FS, with forward references that get
# confused if it changes in mid flight.
CONFIG_PROC_FS=y

# A full kernel is too big for _[B]ZIMAGE, stop after _VMLINUX
CONFIG_VMLINUX=y

# Default filenames for testing
CONFIG_INSTALL_PREFIX_NAME="/var/tmp"
CONFIG_INSTALL_SCRIPT_NAME="true"

# Sound firmware files
CONFIG_MSNDCLAS_INIT_FILE="/home/kaos/sound/msndinit.bin"
CONFIG_MSNDCLAS_PERM_FILE="/home/kaos/sound/msndperm.bin"
CONFIG_MSNDPIN_INIT_FILE="/home/kaos/sound/pndspini.bin"
CONFIG_MSNDPIN_PERM_FILE="/home/kaos/sound/pndsperm.bin"
CONFIG_TRIX_BOOT_FILE="/home/kaos/sound/trxpro.hex"
CONFIG_PSS_BOOT_FILE="/home/kaos/sound/dsp001.ld"
CONFIG_MAUI_BOOT_FILE="/home/kaos/sound/oswf.mot"

# Broken code, will not compile
CONFIG_AIRONET4500_CS=n
CONFIG_AIRONET4500=n
CONFIG_AIRONET4500_NONCS=n
CONFIG_BLK_CPQ_DA=n
CONFIG_BLK_DEV_ATARAID_HPT=n
CONFIG_BLK_DEV_ATARAID=n
CONFIG_BLK_DEV_ATARAID_PDC=n
CONFIG_BLK_DEV_DAC960=n
CONFIG_BLK_DEV_LVM=n
CONFIG_CYCLADES=n
CONFIG_DEFXX=n
CONFIG_FB_ATY128=n
CONFIG_FB_PM2=n
CONFIG_FB_VIRTUAL=n
CONFIG_FTL=n
CONFIG_I2C=n
CONFIG_I2O=n
CONFIG_INTERMEZZO_FS=n
CONFIG_IPHASE5526=n
CONFIG_ISDN_DRV_ACT2000=n
CONFIG_PCMCIA_FDOMAIN=n
CONFIG_PCMCIA_NINJA_SCSI=n
CONFIG_PHONE_IXJ=n
CONFIG_RADIO_MIROPCM20=n
CONFIG_RCPCI=n
CONFIG_ROADRUNNER=n
CONFIG_SCSI_ACARD=n
CONFIG_SCSI_AHA1740=n
CONFIG_SCSI_AM53C974=n
CONFIG_SCSI_BUSLOGIC=n
CONFIG_SCSI_CPQFCTS=n
CONFIG_SCSI_DC390T=n
CONFIG_SCSI_DMX3191D=n
CONFIG_SCSI_DPT_I2O=n
CONFIG_SCSI_DTC3280=n
CONFIG_SCSI_EATA_DMA=n
CONFIG_SCSI_EATA_PIO=n
CONFIG_SCSI_FD_MCS=n
CONFIG_SCSI_FUTURE_DOMAIN=n
CONFIG_SCSI_GDTH=n
CONFIG_SCSI_GENERIC_NCR5380=n
CONFIG_SCSI_IBMMCA=n
CONFIG_SCSI_IN2000=n
CONFIG_SCSI_INITIO=n
CONFIG_SCSI_NCR53C406A=n
CONFIG_SCSI_NCR53C7xx=n
CONFIG_SCSI_PAS16=n
CONFIG_SCSI_PCI2000=n
CONFIG_SCSI_PCI2220I=n
CONFIG_SCSI_SEAGATE=n
CONFIG_SCSI_SYM53C416=n
CONFIG_SCSI_T128=n
CONFIG_SERIO_Q40KBD=n
CONFIG_SOUND_MSNDCLAS=n
CONFIG_SOUND_MSNDPIN=n
CONFIG_TLAN=n
CONFIG_TR=n
CONFIG_VIDEO_STRADIS=n

# All for ad1848_lib.c
CONFIG_SND_CMI8330=n
CONFIG_SND_SGALAXY=n
CONFIG_SND_AD1848=n
CONFIG_SND_OPTI92X_AD1848=n

# Duplicate symbol dev_list in drivers/bluetooth/bluecard_cs.o and dtl1_cs.o
CONFIG_BLUEZ_HCIBLUECARD=n

# Duplicate symbol smc_init in smc9194, smc-ircc
CONFIG_SMC_IRCC_FIR=n

# net/socket.c refers to bluez_init but that function is static.
CONFIG_BLUEZ=n

# Unresolved symbols
CONFIG_HOTPLUG_PCI_IBM=n
CONFIG_HOTPLUG_PCI_COMPAQ=n
CONFIG_SK98LIN=n

