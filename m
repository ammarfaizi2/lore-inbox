Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbVINIOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVINIOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 04:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbVINIOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 04:14:04 -0400
Received: from [210.76.114.20] ([210.76.114.20]:51179 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S965079AbVINIOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 04:14:01 -0400
Message-ID: <4327DBBB.7090108@ccoss.com.cn>
Date: Wed, 14 Sep 2005 16:13:47 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rajat.noida.india@gmail.com
CC: Linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Problem booting 2.6.13 on RHEL 4
References: <b115cb5f05091321082a3ffc24@mail.gmail.com>
In-Reply-To: <b115cb5f05091321082a3ffc24@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seem that kernel have no time to probe your disk, and do not
read parttion table.

I use kernel 2.6.12 and SATA disk on FC3, also failed to boot.
but after some experiment, I found if we place 'sleep 5'
statement between insmod commands in linuxrc or init, it will
boot up!

However, this idea is too HACK.

Maybe, I guest, kernel need some time to probe scsi disk?
but I can not explain that kernel say unresoluting symbol XXXXX
use this reason. 
                                                                                           


May be also, there have one problem in older mkinitrd. but
I looked its source (more roughly), it only include some scriptes.

Any more clear idea on it ??



Rajat Jain wrote:

>Hi list,
>
>I am using RHEL4 distribution, and am trying to boot with vanilla
>2.6.13 stock kernel. My system has two onboard Adaptec SCSI
>controllers. I am booting using initrd, and passing the correct
>"root=" option. The following message pops up while trying to boot
>with 2.6.13:
>
>Loading scsi_mod.ko module
>Loading sd_mod.ko module
>Loading scsi_transport_spi.ko module
>SCSI subsystem initialized
>Loading aic7xxx.ko module
>Creating root device
>umount /sys failed: 16
>Mounting root filesystem
>Mount: error 6 mounting ext3
>Mount: error 2 mounting none
>Switching to new root
>switchroot: mount failed: 22
>umount /initrd/dev failed: 2
>Kernel panic - not syncing: Attempted to kill init!
>
>When I boot the default kernel supplied with RHEL 4, it boots successfully:
>
>Loading scsi_mod.ko module
>SCSI subsystem initialized
>Loading sd_mod.ko module
>Loading scsi_transport_spi.ko module
>Loading aic7xxx.ko module
>ACPI: PCI interrupt 0000:05:09.0[A] -> GSI 18 (level, low) -> IRQ 201
>ACPI: PCI interrupt 0000:05:09.1[B] -> GSI 19 (level, low) -> IRQ 169
>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>        <Adaptec aic7899 Ultra160 SCSI adapter>
>        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
>
>(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 126, 16bit)
>  Vendor: HITACHI   Model: DK32CJ-18MW       Rev: JTN1
>  Type:   Direct-Access                      ANSI SCSI revision: 03
>scsi0:A:0:0: Tagged Queuing enabled.  Depth 4
>SCSI device sda: 35520512 512-byte hdwr sectors (18187 MB)
>SCSI device sda: drive cache: write back
> sda: sda1 sda2 sda3 sda4 < sda5 >
>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
>scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>        <Adaptec aic7899 Ultra160 SCSI adapter>
>        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
>
>Can some one please suggest me what could be the problem? I doubt if
>there is any option I need to enable in the kernel configuration?
>
>Any pointers are welcome,
>
>TIA,
>
>Rajat Jain
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

