Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbVINEII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVINEII (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 00:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVINEIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 00:08:07 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:60230 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932584AbVINEIG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 00:08:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=k9EK26LGb5CM/cg5Sw7q+INEIGtOIeccdymmtkju/n2LT5ybyM+ZDAEtFGQOME62uFiWzrdKFGWGMavW85a5HzuA2yqm6HeeEUv6wmcKCqETZk2e1++cXN9IbXB7+axAZdpu+KWAoaLBJpPFRqICVSUtz+PdtMOWx4tM6Tsx29M=
Message-ID: <b115cb5f05091321082a3ffc24@mail.gmail.com>
Date: Wed, 14 Sep 2005 13:08:05 +0900
From: Rajat Jain <rajat.noida.india@gmail.com>
Reply-To: rajat.noida.india@gmail.com
To: Linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Problem booting 2.6.13 on RHEL 4
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I am using RHEL4 distribution, and am trying to boot with vanilla
2.6.13 stock kernel. My system has two onboard Adaptec SCSI
controllers. I am booting using initrd, and passing the correct
"root=" option. The following message pops up while trying to boot
with 2.6.13:

Loading scsi_mod.ko module
Loading sd_mod.ko module
Loading scsi_transport_spi.ko module
SCSI subsystem initialized
Loading aic7xxx.ko module
Creating root device
umount /sys failed: 16
Mounting root filesystem
Mount: error 6 mounting ext3
Mount: error 2 mounting none
Switching to new root
switchroot: mount failed: 22
umount /initrd/dev failed: 2
Kernel panic - not syncing: Attempted to kill init!

When I boot the default kernel supplied with RHEL 4, it boots successfully:

Loading scsi_mod.ko module
SCSI subsystem initialized
Loading sd_mod.ko module
Loading scsi_transport_spi.ko module
Loading aic7xxx.ko module
ACPI: PCI interrupt 0000:05:09.0[A] -> GSI 18 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:05:09.1[B] -> GSI 19 (level, low) -> IRQ 169
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 126, 16bit)
  Vendor: HITACHI   Model: DK32CJ-18MW       Rev: JTN1
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 4
SCSI device sda: 35520512 512-byte hdwr sectors (18187 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

Can some one please suggest me what could be the problem? I doubt if
there is any option I need to enable in the kernel configuration?

Any pointers are welcome,

TIA,

Rajat Jain
