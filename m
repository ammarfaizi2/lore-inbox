Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267438AbTACKFr>; Fri, 3 Jan 2003 05:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267340AbTACKFr>; Fri, 3 Jan 2003 05:05:47 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:27645 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267306AbTACKFp>;
	Fri, 3 Jan 2003 05:05:45 -0500
Date: Fri, 3 Jan 2003 15:46:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: aic7xxx broken in 2.5.53/54 ?
Message-ID: <20030103101618.GB8582@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the aic7xxx driver in 2.5.53 and 54 are broken on my hardware.
The older driver works fine. The new driver used to work until 2.5.52.
Does this look familiar to anyone ?

hda: ATAPI 48X CD-ROM drive, 120kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hda, sector 0
aic7xxx: PCI Device 0:1:0 failed memory mapped test.  Using PIO.
Uhhuh. NMI received for unknown reason 25 on CPU 0.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
aic7xxx: PCI Device 0:1:1 failed memory mapped test.  Using PIO.
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.25
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi0: PCI error Interrupt at seqaddr = 0x2
scsi0: Signaled a Target Abort
scsi1: PCI error Interrupt at seqaddr = 0x2
scsi1: Signaled a Target Abort
Uhhuh. NMI received for unknown reason 25 on CPU 0.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
(scsi1:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
(scsi1:A:1): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
(scsi1:A:2): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.25
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: IBM-ESXS  Model: ST318305LC    !#  Rev: B245
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: IBM-ESXS  Model: ST318305LC    !#  Rev: B245
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:1:0: Tagged Queuing enabled.  Depth 253
  Vendor: IBM-ESXS  Model: ST318305LC    !#  Rev: B245
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:2:0: Tagged Queuing enabled.  Depth 253
  Vendor: IBM       Model: AuSaV1S2          Rev: 0
  Type:   Processor                          ANSI SCSI revision: 02

The hardware [4-CPU P3 xeon] -

[root@llm04 root]# lspci
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 21)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006
00:00.3 Host bridge: ServerWorks: Unknown device 0006
00:01.0 SCSI storage controller: Adaptec AIC-7896U2/7897U2
00:01.1 SCSI storage controller: Adaptec AIC-7896U2/7897U2
00:05.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] )00:06.0 VGA compatible controller: S3 Inc. Trio 64 3D (rev 01)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 04)
02:03.0 RAID bus controller: IBM Netfinity ServeRAID controller
02:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
02:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)

Thanks
Dipankar
