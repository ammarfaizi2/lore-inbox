Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262191AbSJASyU>; Tue, 1 Oct 2002 14:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262204AbSJASyU>; Tue, 1 Oct 2002 14:54:20 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:3687 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S262191AbSJASxi>; Tue, 1 Oct 2002 14:53:38 -0400
Message-ID: <3D9A530D.4050608@hotmail.com>
Date: Tue, 01 Oct 2002 18:59:41 -0700
From: walt <wa1ter@hotmail.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 Compile error in ppa.o (Zip drive support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to compile parallel-port Zip Drive support into the kernel.
This is my first attempt at anything > 2.4.19:
----------------------------------------------------

gcc -Wp,-MD,./.ppa.o.d -D__KERNEL__ -I/10/kernel/linux-2.5.39/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-p
ointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 
-I/10/kernel/linux-2.5.39/arch/i386/mach-gen
eric -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ppa   -c -o 
ppa.o ppa.c
drivers/scsi/ppa.c: In function `ppa_interrupt':
drivers/scsi/ppa.c:804: warning: implicit declaration of function 
`queue_task'
drivers/scsi/ppa.c:804: `tq_timer' undeclared (first use in this function)
drivers/scsi/ppa.c:804: (Each undeclared identifier is reported only once
drivers/scsi/ppa.c:804: for each function it appears in.)
drivers/scsi/ppa.c: In function `ppa_queuecommand':
drivers/scsi/ppa.c:989: `tq_immediate' undeclared (first use in this 
function)
drivers/scsi/ppa.c:990: warning: implicit declaration of function `mark_bh'
drivers/scsi/ppa.c:990: `IMMEDIATE_BH' undeclared (first use in this 
function)
   ld -m elf_i386  -r -o sd_mod.o sd.o
    ld -m elf_i386  -r -o built-in.o scsi_mod.o ppa.o sd_mod.o
ld: cannot open ppa.o: No such file or directory
make[2]: *** [built-in.o] Error

======================================================
Extracts from .confg :
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=y
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONF# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set
IG_SCSI_SIM710 is not set

