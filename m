Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbULHSFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbULHSFL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbULHSCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:02:47 -0500
Received: from smtp.infolink.com.br ([200.187.64.6]:21009 "EHLO
	smtp.infolink.com.br") by vger.kernel.org with ESMTP
	id S261289AbULHSBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:01:46 -0500
Subject: sata_sil problems
From: Haroldo Gamal <haroldo.gamal@infolink.com.br>
Reply-To: haroldo.gamal@infolink.com.br
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Organization: Infolink LTDA
Message-Id: <1102528904.11078.13.camel@gamal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Dec 2004 16:01:44 -0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, 

I have a machine equipped with 3 sata interfaces, Intel, promise and
silicon Image. 

[root@backup01 hgamal]# lsmod
Module                  Size  Used by
md5                     4161  1
ipv6                  237569  12
e1000                  77901  0
floppy                 58609  0
sg                     32609  0
microcode               6497  0
dm_mod                 55253  0
uhci_hcd               31577  0
ehci_hcd               31685  0
button                  6609  0
battery                 8645  0
ac                      4933  0
ext3                  121033  8
jbd                    75481  1 ext3
sata_promise            9797  3
ata_piix                8645  2
sata_sil                8005  1
libata                 41541  3 sata_promise,ata_piix,sata_sil
sd_mod                 16449  12
scsi_mod              119697  4 sg,sata_promise,libata,sd_mod


The machine has 6 Seagate ST3200822AS disks (3 on promise, 2 on Intel
and 1 in sata_sil).

[root@backup01 hgamal]# cat /proc/scsi/scsi
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3200822AS      Rev: 3.01
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3200822AS      Rev: 3.01
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3200822AS      Rev: 3.01
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3200822AS      Rev: 3.01
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3200822AS      Rev: 3.01
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi8 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3200822AS      Rev: 3.01
  Type:   Direct-Access                    ANSI SCSI revision: 05

I am having the following problems with sata_sil:


Dec  8 16:04:47 backup01 kernel: ata1: command 0x35 timeout, stat 0xd8
host_stat 0x61
Dec  8 16:04:47 backup01 kernel: ata1: status=0xd8 { Busy }
Dec  8 16:04:47 backup01 kernel: SCSI error : <0 0 0 0> return code =
0x8000002
Dec  8 16:04:47 backup01 kernel: EOM Current sda: sense = 70 4b
Dec  8 16:04:47 backup01 kernel: ASC=87 ASCQ=42
Dec  8 16:04:47 backup01 kernel: end_request: I/O error, dev sda, sector
277822631
Dec  8 16:04:47 backup01 kernel: Buffer I/O error on device sda1,
logical block 34727821
Dec  8 16:04:47 backup01 kernel: lost page write due to I/O error on
sda1
Dec  8 16:04:47 backup01 kernel: ATA: abnormal status 0xD8 on port
0x42862087


The kernel version is 2.6.9 (Fedora Core 2 - 2.6.9-1.6_FC2).

Any suggestion?

Thanks in advance,

-- 
Haroldo Gamal
Departamento Técnico
haroldo.gamal@infolink.com.br
http://www.infolink.com.br

