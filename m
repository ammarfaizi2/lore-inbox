Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264882AbUEKREp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264882AbUEKREp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUEKRD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:03:59 -0400
Received: from fmr02.intel.com ([192.55.52.25]:44512 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264915AbUEKRBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:01:16 -0400
Subject: Re: Long boot delay with 2.6 on Tyan S2464 Dual Athlon
From: Len Brown <len.brown@intel.com>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FB091@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FB091@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1084294867.12359.109.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 May 2004 13:01:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 10:35, Bill Rugolsky Jr. wrote:
> When booting 2.6 on a Tyan S2464 dual Athlon, the kernel pauses
> for about two minutes before the first boot message appears.
> This does not occur with 2.4 kernels.

$0.05 says it is related to SCSI

> ACPI: Subsystem revision 20040326
>     ACPI-0352: *** Error: Looking up [Z00Q] in namespace, AE_NOT_FOUND
> search_node f7ec7abc start_node f7ec7abc return_node 00000000
>     ACPI-1133: *** Error: Method execution failed
> [\_SB_.PCI0.ISA_.SIO_.COM1._STA] (Node f7ec7abc), AE_NOT_FOUND
>     ACPI-0352: *** Error: Looking up [Z00Q] in namespace, AE_NOT_FOUND
> search_node f7ec593c start_node f7ec593c return_node 00000000
>     ACPI-1133: *** Error: Method execution failed
> [\_SB_.PCI0.ISA_.SIO_.COM2._STA] (Node f7ec593c), AE_NOT_FOUND
>     ACPI-0352: *** Error: Looking up [Z00Q] in namespace, AE_NOT_FOUND
> search_node f7ec573c start_node f7ec573c return_node 00000000
>     ACPI-1133: *** Error: Method execution failed
> [\_SB_.PCI0.ISA_.SIO_.LPT_._STA] (Node f7ec573c), AE_NOT_FOUND

BTW. you got the latest BIOS on this box?

> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem).
> SCSI subsystem initialized
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>         <Adaptec aic7899 Ultra160 SCSI adapter>
>         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> 
> scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>         <Adaptec aic7899 Ultra160 SCSI adapter>
>         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
> 
> 3ware Storage Controller device driver for Linux v1.26.00.039.
> scsi2 : Found a 3ware Storage Controller at 0x1c50, IRQ: 17, P-chip:
> 1.3
> scsi2 : 3ware Storage Controller
>   Vendor: 3ware     Model: Logical Disk 0    Rev: 1.2 
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> SCSI device sda: drive cache: write through
>  sda:
> Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
>   Vendor: 3ware     Model: Logical Disk 1    Rev: 1.2 
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
> SCSI device sdb: drive cache: write through
>  sdb:
> Attached scsi disk sdb at scsi2, channel 0, id 1, lun 0
>   Vendor: 3ware     Model: Logical Disk 2    Rev: 1.2 
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
> SCSI device sdc: drive cache: write through
>  sdc:
> Attached scsi disk sdc at scsi2, channel 0, id 2, lun 0
>   Vendor: 3ware     Model: Logical Disk 3    Rev: 1.2 
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> SCSI device sdd: 156301488 512-byte hdwr sectors (80026 MB)
> SCSI device sdd: drive cache: write through
>  sdd:
> Attached scsi disk sdd at scsi2, channel 0, id 3, lun 0

if you slap an IDE drive on this box and disable the SCSI does the delay
go away?

-Len


