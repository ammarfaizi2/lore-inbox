Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUH0MtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUH0MtF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 08:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUH0MtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 08:49:04 -0400
Received: from staging.airflowsciences.com ([66.178.220.191]:9088 "EHLO
	staging.airflowsciences.com") by vger.kernel.org with ESMTP
	id S264750AbUH0MsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 08:48:02 -0400
Message-ID: <412F2C0B.1030405@airflowsciences.com>
Date: Fri, 27 Aug 2004 08:41:47 -0400
From: "Robert K. Nelson" <rnelson@airflowsciences.com>
Reply-To: rnelson@airflowsciences.com
Organization: Airflow Sciences Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: Re: SCSI Bus Parity errors with all Kernels after 2.4.26
References: <41210601.6090202@airflowsciences.com> <41236C21.40102@airflowsciences.com>
In-Reply-To: <41236C21.40102@airflowsciences.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert K. Nelson wrote:
>  >> I have a machine conf. which runs fine under a variety of older
>  >> kernels and fails under a variety of newer ones. I was hoping someone
>  >> could direct me to a person who would like to look further into this.
> ...
> 
>  >What are the exact error messages? CC linux-scsi@xxxxxxxxxxxxxxx
> 
> Under SuSE 9.1 the output during module loading is as follows:
> -------------------------------------------------------
> SCSI subsystem initialized
> PCI: Found IRQ 5 for device 0000:00:0a.0
> sym0: <875> rev 0x4 at pci 0000:00:0a.0 irq 5
> sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
> sym0: open drain IRQ line driver, using on-chip SRAM
> sym0: using LOAD/STORE-based firmware.
> sym0: SCSI BUS has been reset.
> scsi0 : sym-2.1.18i
>   Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> sym0:5:0:phase change 6-7 6@3738cf84 resid=4.
> Attached scsi removable disk sda at scsi0, channel 0, id 5, lin0
> Attached scsi generic sg0 at scsi0, channel 0, id 5, lun 0,  type 0
>   Vendor: PIONEER   Model: CD-ROM DR-U065    Rev: 1.05
>   Type:  CD-ROM                              ANSI SCSI revision: 02
> sym0:6: FAST-20 SCSI 19.2 MB/s ST (52.0 ns, offset 16)
> Uniform CD-ROM driver Revision: 3.20
> Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 5
> PCI: Found IRQ 11 for device 0000:00:0c.0
> sym1: <895> rev 0x1 at pci 0000:00:0c.0 irq 11
> sym1: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
> sym1: open drain IRQ line driver, using on-chip SRAM
> sym1: using LOAD/STORE-based firmware.
> sym1: SCSI BUS has been reset.
> scsi1 : sym-2.1.18i
>   Vendor: QUANTUM   Model: VIKING II 4.5WLS  Rev: 4110
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> sym1:0:0: tagged command queuind enabled, command queue depth 16.
> sym1:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
> SCSI device sdb: 8910423 512-byte hdwr sectors (4562 MB)
> SCSI device sdb: drive cache: write back
>  sdb: sdb1 sdb2
> Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
> Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
>   Vendor: IBM       Model: DNES-309170W      Rev: SAH0
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> sym1:6:0: tagged command queuing enabled, command queue depth 16.
> sym1:6: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 30)
> SCSI: device sdc: 17916240 512-byte hdwr sectors (9173 MB)
> SCSI device sdc: drive cache: write back
>  sdc: sdc1 sdc2
> Attached scsi disk sdc at scsi1, channel 0, id 6, lun 0
> Attached scsi generic sg3 at scsi1, channel 0, id 6, lun 0,  type 0
> sym0: SCSI parity error detected: SCR1=1 DBC=50000000 SBCL=0
> sym0:15: ERROR (a0:0) (8-0-0) (0/5/0) @ (mem cd800020:cd800020).
> sym0: regdump: da 00 00 05 47 00 0f 0e 00 08 00 00 80 00 0f 02 ff ff ff 
> 00 02 ff ff ff.
> sym0: PCI STATUS = 0x20000
> sym0: SCSI BUS reset detected.
> sym0: SCSI BUS has been reset.
> sym1: SCSI parity error detected: SCR1=1 DBC=50000000 SBCL=0
> sym1: SCSI phase error fixup: CCB already dequeued.
> sym1:15: ERROR (81:0) (8-0-0) (0/7/0) @ (scripta 48:a9100786).
> sym1: script cmd = f31c0004
> sym1: regdump: da 00 00 07 47 00 0f 0a 00 08 86 00 80 00 0f 02 28 71 01 
> 37 02 ff ff ff.
> sym1: SCSI BUS reset detected.
> sym1: SCSI BUS has been reset.
> ---------------------------------------------------
> Please cc: rnelson@airflwosciences.com since I do not subscribe.  Note 
> that I will be out of town for the next 5 days.
> 
> Bob Nelson
> 

This issue seemed to die while I was off taking my daughter to college. 
  Any help out there or ideas about how to proceed?

Bob
-- 
Robert K. Nelson
Airflow Sciences Corporation
37501 Schoolcraft Road, Livonia, MI  48150-1009
(734) 464-8900   FAX (734) 464-5879  www.airflowsciences.com

