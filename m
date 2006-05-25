Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbWEYMWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWEYMWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWEYMWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:22:43 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:65225 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965127AbWEYMWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:22:43 -0400
Date: Thu, 25 May 2006 14:22:40 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 3ware 7500 not working in 2.6.16.18, 2.6.17-rc5
Message-ID: <20060525122240.GG19612@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

I have a 3ware 75xx P-ATA controller, which has been working in 2.6.15-rc2.
Today I have tried to upgrade to 2.6.16.18, and it cannot boot - the
controller cannot access the drives, with the attached messages.
I have also tried 2.6.17-rc5 with the same results.

[...]
3ware Storage Controller device driver for Linux v1.26.02.001.
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 28 (level, low) -> IRQ 18
scsi0 : 3ware Storage Controller
3w-xxxx: scsi0: Found a 3ware Storage Controller at 0x8c00, IRQ: 18.
  Vendor: 3ware     Model: Logical Disk 0    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 1    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 2    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 3    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 4    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 5    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 6    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 7    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back w/ FUA
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back w/ FUA
 sda:<3>nommu_map_sg: overflow 2053d9000+4096 of device mask ffffffff
3w-xxxx: tw_map_scsi_sg_data(): pci_map_sg() failed.
nommu_map_sg: overflow 2053d9000+4096 of device mask ffffffff
3w-xxxx: tw_map_scsi_sg_data(): pci_map_sg() failed.
nommu_map_sg: overflow 2053d9000+4096 of device mask ffffffff
3w-xxxx: tw_map_scsi_sg_data(): pci_map_sg() failed.
nommu_map_sg: overflow 2053d9000+4096 of device mask ffffffff
3w-xxxx: tw_map_scsi_sg_data(): pci_map_sg() failed.
nommu_map_sg: overflow 2053d9000+4096 of device mask ffffffff
3w-xxxx: tw_map_scsi_sg_data(): pci_map_sg() failed.
nommu_map_sg: overflow 2053d9000+4096 of device mask ffffffff
3w-xxxx: tw_map_scsi_sg_data(): pci_map_sg() failed.
sd 0:0:0:0: SCSI error: return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
nommu_map_sg: overflow 2053d9000+4096 of device mask ffffffff
3w-xxxx: tw_map_scsi_sg_data(): pci_map_sg() failed.
[... and so on, the same for all eight drives sda to sdh ...]

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> I will never go to meetings again because I think  face to face meetings <
> are the biggest waste of time you can ever have.        --Linus Torvalds <
