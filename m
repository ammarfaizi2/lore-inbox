Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbTF1Lrv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 07:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbTF1Lrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 07:47:51 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:24739 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265161AbTF1Lrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 07:47:48 -0400
Message-Id: <5.1.0.14.2.20030628135540.00af33a8@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 28 Jun 2003 14:02:34 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.5.73 - SCSI cache data unavailable messages
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: ZkDi02ZdYesMO6yIEszr3DWnbiMiSfGWWsoMnhV2IAJIx+7A5YfTUm@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peculiar "cache data unavailable" messages in 2.5.73.
Didn't happen in 2.5.71.
Snips from 2.5.73 and 2.5.71 below.

Margit

--SNIP 2.5.73--
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
<4>        <Adaptec 3960D Ultra160 SCSI adapter>
<4>        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
<4>
<4>(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
<4>(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
<5>  Vendor: FUJITSU   Model: MAN3184MP         Rev: 0108
<5>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
<5>  Vendor: FUJITSU   Model: MAN3184MP         Rev: 0108
<5>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
<6>scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
<4>        <Adaptec 3960D Ultra160 SCSI adapter>
<4>        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
<4>
<4>(scsi1:A:2): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
<4>(scsi1:A:3): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
<5>  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
<5>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi1:A:2:0: Tagged Queuing enabled.  Depth 32
<5>  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
<5>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi1:A:3:0: Tagged Queuing enabled.  Depth 32
<6>scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
<4>        <Adaptec 2940A Ultra SCSI adapter>
<4>        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs
<4>
<4>(scsi2:A:4): 20.000MB/s transfers (20.000MHz, offset 8)
<4>(scsi2:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
<5>  Vendor: PIONEER   Model: DVD-ROM DVD-303   Rev: 1.09
<5>  Type:   CD-ROM                             ANSI SCSI revision: 02
<5>  Vendor: HP        Model: C1537A            Rev: L812
<5>  Type:   Sequential-Access                  ANSI SCSI revision: 02
<6>st: Version 20030622, fixed bufsize 32768, s/g segs 256
<4>Attached scsi tape st0 at scsi2, channel 0, id 5, lun 0
<4>st0: try direct i/o: yes, max page reachable by HBA 1048575
<5>SCSI device sda: 35885448 512-byte hdwr sectors (18373 MB)
<5>sda: cache data unavailable
<3>sda: assuming drive cache: write through
<6> /dev/scsi/host0/bus0/target0/lun0: p1 p2
<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<5>SCSI device sdb: 35885448 512-byte hdwr sectors (18373 MB)
<5>sdb: cache data unavailable
<3>sdb: assuming drive cache: write through
<6> /dev/scsi/host0/bus0/target1/lun0: p1
<5>Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
<5>SCSI device sdc: 35843670 512-byte hdwr sectors (18352 MB)
<5>sdc: cache data unavailable
<3>sdc: assuming drive cache: write through
<6> /dev/scsi/host1/bus0/target2/lun0: p1
<5>Attached scsi disk sdc at scsi1, channel 0, id 2, lun 0
<5>SCSI device sdd: 35843670 512-byte hdwr sectors (18352 MB)
<5>sdd: cache data unavailable
<3>sdd: assuming drive cache: write through
<6> /dev/scsi/host1/bus0/target3/lun0: p1
<5>Attached scsi disk sdd at scsi1, channel 0, id 3, lun 0
--END SNIP --


--SNIP 2.5.71 --
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
<4>        <Adaptec 3960D Ultra160 SCSI adapter>
<4>        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
<4>
<4>(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
<4>(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
<5>  Vendor: FUJITSU   Model: MAN3184MP         Rev: 0108
<5>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
<5>  Vendor: FUJITSU   Model: MAN3184MP         Rev: 0108
<5>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
<6>scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
<4>        <Adaptec 3960D Ultra160 SCSI adapter>
<4>        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
<4>
<4>(scsi1:A:2): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
<4>(scsi1:A:3): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
<5>  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
<5>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi1:A:2:0: Tagged Queuing enabled.  Depth 32
<5>  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
<5>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi1:A:3:0: Tagged Queuing enabled.  Depth 32
<6>scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
<4>        <Adaptec 2940A Ultra SCSI adapter>
<4>        aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs
<4>
<4>(scsi2:A:4): 20.000MB/s transfers (20.000MHz, offset 8)
<4>(scsi2:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
<5>  Vendor: PIONEER   Model: DVD-ROM DVD-303   Rev: 1.09
<5>  Type:   CD-ROM                             ANSI SCSI revision: 02
<5>  Vendor: HP        Model: C1537A            Rev: L812
<5>  Type:   Sequential-Access                  ANSI SCSI revision: 02
<6>st: Version 20030413, fixed bufsize 32768, s/g segs 256
<4>Attached scsi tape st0 at scsi2, channel 0, id 5, lun 0
<4>st0: try direct i/o: yes, max page reachable by HBA 1048575
<5>SCSI device sda: 35885448 512-byte hdwr sectors (18373 MB)
<5>SCSI device sda: drive cache: write back
<6> /dev/scsi/host0/bus0/target0/lun0: p1 p2
<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<5>SCSI device sdb: 35885448 512-byte hdwr sectors (18373 MB)
<5>SCSI device sdb: drive cache: write back
<6> /dev/scsi/host0/bus0/target1/lun0: p1
<5>Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
<5>SCSI device sdc: 35843670 512-byte hdwr sectors (18352 MB)
<5>SCSI device sdc: drive cache: write back
<6> /dev/scsi/host1/bus0/target2/lun0: p1
<5>Attached scsi disk sdc at scsi1, channel 0, id 2, lun 0
<5>SCSI device sdd: 35843670 512-byte hdwr sectors (18352 MB)
<5>SCSI device sdd: drive cache: write back
<6> /dev/scsi/host1/bus0/target3/lun0: p1
<5>Attached scsi disk sdd at scsi1, channel 0, id 3, lun 0
--END SNIP--


Margit

