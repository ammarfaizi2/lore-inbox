Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWEPUjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWEPUjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 16:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWEPUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 16:39:23 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:59660 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750745AbWEPUjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 16:39:22 -0400
Date: Tue, 16 May 2006 22:39:18 +0200
From: Willy Tarreau <willy@w.ods.org>
To: George Nychis <gnychis@cmu.edu>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: need help booting from SATA in 2.4.32
Message-ID: <20060516203917.GQ11191@w.ods.org>
References: <446A36B8.1060707@cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446A36B8.1060707@cmu.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 04:31:52PM -0400, George Nychis wrote:
> Hi,
> 
> I've booted from a SATA drive in 2.4.32 before, but for some reason
> 2.4.32 will not recognize this disk.  It is recognized when I boot 2.6.9
> though.
> 
> It uses the ata_piix module in both kernels.  Whenever I boot 2.6.9 I see:
> ----------------------------------------------------------------------
>  SCSI subsystem initialized
>  ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 7 (level, low) -> IRQ 7
>  ata: 0x170 IDE port busy
>  ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
>  ata1: dev 0 ATA, max UDMA/100, 78140160 sectors:
>  ata1(0): applying bridge limits
>  ata1: dev 0 configured for UDMA/100
>  scsi0 : ata_piix
>    Vendor: ATA       Model: FUJITSU MHV2040A  Rev: 0000
>    Type:   Direct-Access                      ANSI SCSI revision: 05
>  SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
>  SCSI device sda: drive cache: write back
>   sda: sda1 sda2 sda3 sda4 < sda5 >
>  Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
>  device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
> ------------------------------------------------------------------------
> 
> However in 2.4.32 all i see is:
> ----------------------------
>  SCSI subsystem initialized
> ----------------------------
> 
> I am positive that my 2.4.32 has been compiled with ata_piix as a
> module, and it does reside in /lib/modules/2.4.32/kernel/driver/scsi/
> 
> Any clues?

Could you retry with it statically linked in the kernel ? I vaguely
remember that if the original PIIX4 driver registers the device first,
then ata_piix cannot get it. You could also ensure that you have
properly removed CONFIG_IDE_PIIX4 (I believe it's called like this).

> Thanks!
> George

Regards,
Willy

