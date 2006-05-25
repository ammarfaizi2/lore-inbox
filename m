Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbWEYNZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbWEYNZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 09:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWEYNZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 09:25:53 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:60067 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965128AbWEYNZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 09:25:53 -0400
Message-ID: <4475B05E.5080101@garzik.org>
Date: Thu, 25 May 2006 09:25:50 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jan Kasprzak <kas@fi.muni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3ware 7500 not working in 2.6.16.18, 2.6.17-rc5
References: <20060525122240.GG19612@fi.muni.cz>
In-Reply-To: <20060525122240.GG19612@fi.muni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
> 	Hi all,
> 
> I have a 3ware 75xx P-ATA controller, which has been working in 2.6.15-rc2.
> Today I have tried to upgrade to 2.6.16.18, and it cannot boot - the
> controller cannot access the drives, with the attached messages.
> I have also tried 2.6.17-rc5 with the same results.
> 
> [...]
> 3ware Storage Controller device driver for Linux v1.26.02.001.
> GSI 18 sharing vector 0xB9 and IRQ 18
> ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 28 (level, low) -> IRQ 18
> scsi0 : 3ware Storage Controller
> 3w-xxxx: scsi0: Found a 3ware Storage Controller at 0x8c00, IRQ: 18.
>   Vendor: 3ware     Model: Logical Disk 0    Rev: 1.2
>   Type:   Direct-Access                      ANSI SCSI revision: 00
>   Vendor: 3ware     Model: Logical Disk 1    Rev: 1.2
>   Type:   Direct-Access                      ANSI SCSI revision: 00
>   Vendor: 3ware     Model: Logical Disk 2    Rev: 1.2
>   Type:   Direct-Access                      ANSI SCSI revision: 00
>   Vendor: 3ware     Model: Logical Disk 3    Rev: 1.2
>   Type:   Direct-Access                      ANSI SCSI revision: 00
>   Vendor: 3ware     Model: Logical Disk 4    Rev: 1.2
>   Type:   Direct-Access                      ANSI SCSI revision: 00
>   Vendor: 3ware     Model: Logical Disk 5    Rev: 1.2
>   Type:   Direct-Access                      ANSI SCSI revision: 00
>   Vendor: 3ware     Model: Logical Disk 6    Rev: 1.2
>   Type:   Direct-Access                      ANSI SCSI revision: 00
>   Vendor: 3ware     Model: Logical Disk 7    Rev: 1.2
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
> sda: Write Protect is off
> SCSI device sda: drive cache: write back w/ FUA
> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
> sda: Write Protect is off
> SCSI device sda: drive cache: write back w/ FUA
>  sda:<3>nommu_map_sg: overflow 2053d9000+4096 of device mask ffffffff
> 3w-xxxx: tw_map_scsi_sg_data(): pci_map_sg() failed.
> nommu_map_sg: overflow 2053d9000+4096 of device mask ffffffff
> 3w-xxxx: tw_map_scsi_sg_data(): pci_map_sg() failed.

Can you narrow down which kernel version first introduces the breakage, 
between 2.6.15-rc2 and 2.6.16.x?

And we will need much more information on your platform, what patches 
(if any) you have applied, your .config, dmesg, etc.

	Jeff


