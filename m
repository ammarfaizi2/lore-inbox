Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVHAPd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVHAPd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVHAPdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:33:40 -0400
Received: from mail0.lsil.com ([147.145.40.20]:48811 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262100AbVHAPcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:32:10 -0400
Message-ID: <91888D455306F94EBD4D168954A9457C035CB64A@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: Holger Kiehl <Holger.Kiehl@dwd.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: RE: As of 2.6.13-rc1 Fusion-MPT very slow
Date: Mon, 1 Aug 2005 09:31:45 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I provided an application called getspeed as an attachment
in the email I sent last Friday. Did you receive that, or do 
I need to resend?  If possible, can run that application 
and send me the output.

Regards,
Eric Moore

On Monday, August 01, 2005 4:16 AM, Holger Kiehl wrote:

> On Fri, 29 Jul 2005, Andrew Morton wrote:
> 
> > "Moore, Eric Dean" <Eric.Moore@lsil.com> wrote:
> >>
> >>  Regarding the 1st issue, can you try this patch out.  It 
> maybe in the
> >>  -mm branch. Andrew cc'd on this email can confirm.
> >>
> >>  
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/
> 2.6.13-rc3/2.6
> >>  .13-rc3-mm3/broken-out/mpt-fusion-dv-fixes.patch
> >
> > Yes, that's part of 2.6.13-rc3-mm3.
> >
> The patch makes no difference. Still get the following 
> results when fusion
> is compiled in:
> 
>        sdc   74MB/s
>        sdd    2MB/s
>        sde    2MB/s
>        sdf    2MB/s
> 
> On second channel:
> 
>        sdg   74MB/s
>        sdh   74MB/s
>        sdi   74MB/s
>        sdj   74MB/s
> 
> The patch was applied to linux-2.6.13-rc4-git3.
> 
> Here part of dmesg output:
> 
>     Fusion MPT base driver 3.03.02
>     Copyright (c) 1999-2005 LSI Logic Corporation
>     Fusion MPT SPI Host driver 3.03.02
>     ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 24 (level, 
> low) -> IRQ 217
>     mptbase: Initiating ioc0 bringup
>     ioc0: 53C1030: Capabilities={Initiator,Target}
>     scsi4 : ioc0: LSI53C1030, FwRev=01032700h, Ports=1, 
> MaxQ=255, IRQ=217
>       Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
>       Type:   Direct-Access                      ANSI SCSI 
> revision: 03
>     SCSI device sdc: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdc: drive cache: write back
>     SCSI device sdc: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdc: drive cache: write back
>      sdc: sdc1
>     Attached scsi disk sdc at scsi4, channel 0, id 0, lun 0
>       Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
>       Type:   Direct-Access                      ANSI SCSI 
> revision: 03
>     SCSI device sdd: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdd: drive cache: write back
>     SCSI device sdd: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdd: drive cache: write back
>      sdd: sdd1
>     Attached scsi disk sdd at scsi4, channel 0, id 1, lun 0
>       Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
>       Type:   Direct-Access                      ANSI SCSI 
> revision: 03
>     SCSI device sde: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sde: drive cache: write back
>     SCSI device sde: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sde: drive cache: write back
>      sde: sde1
>     Attached scsi disk sde at scsi4, channel 0, id 2, lun 0
>       Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
>       Type:   Direct-Access                      ANSI SCSI 
> revision: 03
>     SCSI device sdf: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdf: drive cache: write back
>     SCSI device sdf: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdf: drive cache: write back
>      sdf: sdf1
>     Attached scsi disk sdf at scsi4, channel 0, id 3, lun 0
>     ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 25 (level, 
> low) -> IRQ 225
>     mptbase: Initiating ioc1 bringup
>     ioc1: 53C1030: Capabilities={Initiator,Target}
>     scsi5 : ioc1: LSI53C1030, FwRev=01032700h, Ports=1, 
> MaxQ=255, IRQ=225
>       Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
>       Type:   Direct-Access                      ANSI SCSI 
> revision: 03
>     SCSI device sdg: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdg: drive cache: write back
>     SCSI device sdg: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdg: drive cache: write back
>      sdg: sdg1
>     Attached scsi disk sdg at scsi5, channel 0, id 0, lun 0
>       Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
>       Type:   Direct-Access                      ANSI SCSI 
> revision: 03
>     SCSI device sdh: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdh: drive cache: write back
>     SCSI device sdh: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdh: drive cache: write back
>      sdh: sdh1
>     Attached scsi disk sdh at scsi5, channel 0, id 1, lun 0
>       Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
>       Type:   Direct-Access                      ANSI SCSI 
> revision: 03
>     SCSI device sdi: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdi: drive cache: write back
>     SCSI device sdi: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdi: drive cache: write back
>      sdi: sdi1
>     Attached scsi disk sdi at scsi5, channel 0, id 2, lun 0
>       Vendor: FUJITSU   Model: MAS3735NP         Rev: 0104
>       Type:   Direct-Access                      ANSI SCSI 
> revision: 03
>     SCSI device sdj: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdj: drive cache: write back
>     SCSI device sdj: 143552136 512-byte hdwr sectors (73499 MB)
>     SCSI device sdj: drive cache: write back
>      sdj: sdj1
>     Attached scsi disk sdj at scsi5, channel 0, id 3, lun 0
> 
> Anything else I can try or provide?
> 
> Holger
> 
