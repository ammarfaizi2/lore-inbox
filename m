Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVFII0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVFII0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 04:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVFII0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 04:26:32 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:45200 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262329AbVFII02 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 04:26:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MGeLQ9q97Wbg3x7d6iqU4JnvNsCZ4hP0Tv4l8kzCI+xLoxtrCsIszwmpzInX7RFkFAMjGmAbpm5DJGmSesE5GPyDtxB1CoFWq3W5lIElKMa/xnWc7/kAWSKagtEt/rg1AusqEE3mwwkmtACT1XafpceKvIo7zIPbDY9FFMSue3Y=
Message-ID: <4ad99e05050609012630a2ad3@mail.gmail.com>
Date: Thu, 9 Jun 2005 10:26:26 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Sonny Rao <sonnyrao@us.ibm.com>
Subject: Re: Fusion MPT driver version 3.01.20 VS. version 2.03.00
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050607224033.GA14108@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ad99e050506071428278c3018@mail.gmail.com>
	 <20050607224033.GA14108@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/05, Sonny Rao <sonnyrao@us.ibm.com> wrote:
> Hi, I have an x335 here that I'm using on 2.6.11.11
> 
> <from dmesg>
> 
> Fusion MPT base driver 3.01.18
> Copyright (c) 1999-2004 LSI Logic Corporation
> ACPI: PCI interrupt 0000:01:01.0[A] -> GSI 22 (level, low) -> IRQ 22
> mptbase: Initiating ioc0 bringup
> ioc0: 53C1030: Capabilities={Initiator}
> Fusion MPT SCSI Host driver 3.01.18
> scsi0 : ioc0: LSI53C1030, FwRev=01000e00h, Ports=1, MaxQ=222, IRQ=22
>   Vendor: IBM-ESXS  Model: MAS3367NC     FN  Rev: C901
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
> SCSI device sda: drive cache: write through
> SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
> SCSI device sda: drive cache: write through
>  /dev/scsi/host0/bus0/target0/lun0: p1 p2
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
>   Vendor: IBM-ESXS  Model: MAS3367NC     FN  Rev: C901
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
> SCSI device sdb: drive cache: write through
> SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
> SCSI device sdb: drive cache: write through
>  /dev/scsi/host0/bus0/target1/lun0: unknown partition table
> Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
>   Vendor: IBM       Model: 25P3495a S320  1  Rev: 1
>   Type:   Processor                          ANSI SCSI revision: 02
> 
> Drive is a 15k 36GB disk:
> 
> hdparm -t /dev/sda
> 
> /dev/sda:
>  Timing buffered disk reads:  226 MB in  3.01 seconds =  75.07 MB/sec
> 
> So I'm not seeing that problem, does your dmesg output from the driver
> pretty much match what I have?
> 
> Sonny
> 

Our is a 10K drive - this is my dmesg output (from 2.6.12-rc5) - only
difference I can see is the ANSI SCSI revision (I have never
investigated the SCSI subsystem much in the kernel so how does one
interpreted the ANSI SCSI revision number ?).


Fusion MPT base driver 3.01.20
Copyright (c) 1999-2004 LSI Logic Corporation
ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 22 (level, low) -> IRQ 169
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
Fusion MPT SCSI Host driver 3.01.20
scsi0 : ioc0: LSI53C1030, FwRev=01032715h, Ports=1, MaxQ=222, IRQ=169
  Vendor: IBM-ESXS  Model: CBR036C31210ESFN  Rev: DFQ8
  Type:   Direct-Access                      ANSI SCSI revision: 04
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sda: drive cache: write through
  /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: IBM       Model: 25P3495a S320  1  Rev: 1
  Type:   Processor                          ANSI SCSI revision: 02
Fusion MPT misc device (ioctl) driver 3.01.20


I have tried switching the 335 for another one but the performance is
till very low so I am quite sure that it is not a hardware problem.
Also compiling the driver as a module does not make any difference.


Regards.

Lars Roland
