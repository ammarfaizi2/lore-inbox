Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263435AbUD3KnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUD3KnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 06:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264823AbUD3KnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 06:43:16 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:40898 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263435AbUD3KnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 06:43:13 -0400
Date: Fri, 30 Apr 2004 12:42:29 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: 2.6.6-rc3 scsi symbios prevents booting
Message-ID: <20040430104229.GA595@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Seen: false
X-ID: Th0hd6Zr8eAbCgWR1avGHuUUZG8HMvo7X7++2EvVxzXGWiKvHx1k4g
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting kernel-2.6.6-rc3 hangs because of the Symbios scsi-driver.
No errors with kernel-2.6.5.

(Mobo Tyan S2665, Dawicontrol DC-2964F (Chip used is AM53C974)

I get this messages .. (copied by hand from bootscreen).

Beginning Domain Validation
sym0:5 FAST SCSI 10 MB/s ST (100.0ns,offset 15)
scsi(2:0:5:0) ECHO BUFFER SIZE 5924 ist too big, trimming to 4096 
scsi(2:0:5:0) Domain Validation detected failure, dropping back.
sym0:5 FAST SCSI 6.8 MB/s ST (148.0ns,offset 15)
scsi(2:0:5:0) Domain Validation detected failure, dropping back.
sym0:5:0 asynchronous
# This appeares two times
sym0:5:0 ABORT OPERATION started
sym0:5:0 ABORT OPERATION timed out
sym0:5:0 BUS RESET started
sym0:5:0 BUS RESET timed out
sym0:5:0 DEVICE RESET started
sym0:5:0 DEVICE RESET timed out

The system then hangs.

In contrast to this the messages from from kernel-2.6.5.
No errors here. All scsi-devices are working.

scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

(scsi0:A:9): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
(scsi0:A:10): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
  Vendor: FUJITSU   Model: MAP3367NC         Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:9:0: Tagged Queuing enabled.  Depth 32
  Vendor: FUJITSU   Model: MAP3367NC         Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:10:0: Tagged Queuing enabled.  Depth 32
scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

sym0: <875> rev 0x4 at pci 0000:05:01.0 irq 22
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi2 : sym-2.1.18i
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: EPSON     Model: Perfection1640    Rev: 1.06
  Type:   Processor                          ANSI SCSI revision: 02
st: Version 20040318, fixed bufsize 32768, s/g segs 256
SCSI device sda: 71775284 512-byte hdwr sectors (36749 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 9, lun 0
SCSI device sdb: 71775284 512-byte hdwr sectors (36749 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 10, lun 0
sym0:2: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 16)
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi2, channel 0, id 2, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 9, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 10, lun 0,  type 0
Attached scsi generic sg2 at scsi2, channel 0, id 2, lun 0,  type 5
Attached scsi generic sg3 at scsi2, channel 0, id 5, lun 0,  type 3

Hope this helps to find the bug(s).

--
Klaus
