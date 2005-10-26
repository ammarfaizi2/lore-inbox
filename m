Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbVJZHXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbVJZHXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 03:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVJZHXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 03:23:41 -0400
Received: from i5-7.dnslinks.net ([66.98.167.159]:1751 "HELO ip01-web5.net")
	by vger.kernel.org with SMTP id S932574AbVJZHXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 03:23:40 -0400
Subject: LSI LOGIC I/O Error on 2.6.12.6
From: govind <garumuga@sahasrasolutions.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1130311510.3328.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 26 Oct 2005 12:55:10 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are trying to make use of a LSI LOGICS SAS drives in a customized
Linux distribution of 2.6.12.6 kernel version. We are hitting upon an
I/O Error on trying to access the drives. Have anybody faced this
problem?

The following are the details:


kernel version =2.6.12.6
mptsasdriver   =mptlinux-3.02.57
Processor      =Intel(R) Xeon(TM) CPU 3.20GHz

The relevant part of dmesg output on this server-
---------------------------------------

Fusion MPT base driver 3.02.57
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.02.57
Fusion MPT FC Host driver 3.02.57
Fusion MPT misc device (ioctl) driver 3.02.57
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)
Fusion MPT SAS Host driver 3.02.57
PCI: Enabling device 0000:06:03.0 (0116 -> 0117)
ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 98 (level, low) -> IRQ 98
mptbase: Initiating ioc0 bringup
ioc0: SAS1068: Capabilities={Initiator}
scsi1 : ioc0: LSISAS1068, FwRev=01030000h, Ports=1, MaxQ=267, IRQ=98
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 11W0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdb: drive cache: write back
 sdb:<6>SCSI error : <1 0 8 0> return code = 0x8000002
sdb: Current: sense key=0x3
    ASC=0x11 ASCQ=0x0
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
SCSI error : <1 0 8 0> return code = 0x8000002
sdb: Current: sense key=0x3
    ASC=0x11 ASCQ=0x0
end_request: I/O error, dev sdb, sector 0
Buffer I/O error on device sdb, logical block 0
 unable to read partition table
Attached scsi disk sdb at scsi1, channel 0, id 8, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 8, lun 0,  type 0
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: 11W0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 490234752 512-byte hdwr sectors (251000 MB)

The relevant part of the kernel .config file is as follows
------------------------------------------------------------

#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m


Thanks,
A.govind

