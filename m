Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVJKLak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVJKLak (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 07:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVJKLak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 07:30:40 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:31391 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S932069AbVJKLaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 07:30:39 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.97,198,1125871200"; 
   d="scan'208"; a="17612379:sNHT49186592"
Message-ID: <434BA25C.2040309@fujitsu-siemens.com>
Date: Tue, 11 Oct 2005 13:30:36 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Errors while initializing mptspi on 53C1030
Content-Type: multipart/mixed;
 boundary="------------020008030609090604000303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020008030609090604000303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a server running SuSE-SLES9 from a RAID1 on 53C1030. There are two
physical disks configured to make up one logical drive. Now I upgraded the
machine to kernel 2.6.14-rc3.

With 2.6.14-rc3 on each boot some errors occur while mptspi (mptscsih,
mptbase) is initializing. AFAICS, having done some unsuccessful retries the
driver resets the HW again and after that the system seems to run normally.

I've attached the relevant part of the logging.

Please CC me, I'm not on the lists.

Regards
	Bodo


BTW, the "Release failed" messages in the driver are missing the '\n'.

--------------020008030609090604000303
Content-Type: text/plain;
 name="dmesg_mpt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_mpt"

Linux version 2.6.14-rc3 (root@abg4507s) (gcc version 3.3.3 (SuSE Linux)) #1 SMP Tue Oct 11 11:34:10 CEST 2005

... snip ...

SCSI subsystem initialized
Fusion MPT base driver 3.03.03
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.03
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 24 (level, low) -> IRQ 19
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
scsi0 : ioc0: LSI53C1030, FwRev=01032571h, Ports=1, MaxQ=222, IRQ=19
  Vendor: LSILOGIC  Model: 1030          IM  Rev: 1000
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 142131200 512-byte hdwr sectors (72771 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 142131200 512-byte hdwr sectors (72771 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: SDR       Model: GEM318P           Rev: 1   
  Type:   Processor                          ANSI SCSI revision: 02
ACPI: PCI Interrupt 0000:02:08.1[B] -> GSI 25 (level, low) -> IRQ 20
mptbase: Initiating ioc1 bringup
mptscsih: ioc0: DV: Release failed. id 0<6>ioc1: 53C1030: Capabilities={Initiator}
scsi1 : ioc1: LSI53C1030, FwRev=01032571h, Ports=1, MaxQ=222, IRQ=20
mptscsih: ioc0: attempting task abort! (sc=f748b380)
scsi0 : destination target 0, lun 0
        command: Read (10): 28 00 00 80 34 4d 00 00 02 00
mptscsih: ioc0: task abort: SUCCESS (sc=f748b380)
mptscsih: ioc0: attempting task abort! (sc=f748b380)
scsi0 : destination target 0, lun 0
        command: Test Unit Ready: 00 00 00 00 00 00
mptscsih: ioc0: task abort: SUCCESS (sc=f748b380)
mptscsih: ioc0: attempting target reset! (sc=f748b380)
scsi0 : destination target 0, lun 0
        command: Read (10): 28 00 00 80 34 4d 00 00 02 00
mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
mptscsih: ioc0: target reset: SUCCESS (sc=f748b380)
mptscsih: ioc0: attempting task abort! (sc=f748b380)
scsi0 : destination target 0, lun 0
        command: Test Unit Ready: 00 00 00 00 00 00
mptscsih: ioc0: task abort: SUCCESS (sc=f748b380)
mptscsih: ioc0: attempting bus reset! (sc=f748b380)
scsi0 : destination target 0, lun 0
        command: Read (10): 28 00 00 80 34 4d 00 00 02 00
mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
mptscsih: ioc0: bus reset: SUCCESS (sc=f748b380)
mptscsih: ioc0: attempting task abort! (sc=f748b380)
scsi0 : destination target 0, lun 0
        command: Test Unit Ready: 00 00 00 00 00 00
mptscsih: ioc0: task abort: SUCCESS (sc=f748b380)
mptscsih: ioc0: Attempting host reset! (sc=f748b380)
mptbase: Initiating ioc0 recovery
EXT2-fs warning (device sda2): ext2_fill_super: mounting ext3 filesystem as ext2

... snip ... (now the system runs fine! AFAICS ...)

--------------020008030609090604000303--
