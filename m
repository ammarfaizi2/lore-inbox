Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUF3CBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUF3CBq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 22:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266191AbUF3CBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 22:01:46 -0400
Received: from [212.160.87.90] ([212.160.87.90]:5640 "EHLO
	trinity.nova-trading.com") by vger.kernel.org with ESMTP
	id S266189AbUF3CBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 22:01:41 -0400
Message-ID: <008e01c45e46$5ad47050$0264a8c0@rck>
From: "bm" <b.melnicki@nova-trading.com>
To: "Alan Cox" <alan@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20040616210455.GA13385@devserv.devel.redhat.com>
Subject: Re: PATCH: Further aacraid work
Date: Wed, 30 Jun 2004 04:02:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Setup:
Tyan Thunder K8S Pro S2882, 2xAMD Opteron 248, 4GB RAM
Adaptec 2200S
5xFUJITSU MAS3184NC RAID0
(I've disconnected second enclosure to speed-up reboots)

Currently it boots from another disk via Tekram  390U2W so I have full
control
of aacraid module.

applied patches:
cset-alan@redhat.com_ChangeSet_20040618145535_60089.txt
cset-janitor@sternwelten.at_ChangeSet_20040622163213_10244.txt
cset-jejb@mulgrave.(none)_ChangeSet_20040622162621_09621.txt
cset-jejb@mulgrave.(none)_ChangeSet_20040622163045_09435.txt
cset-markh@osdl.org_ChangeSet_20040621214511_06962.txt

on increased file activity I'm getting this:

Jun 30 04:08:15 crusher Bootdata ok (command line is root=/dev/sda1 vga=788)
Jun 30 04:08:15 crusher Linux version 2.6.7-gentoo-r6 (root@crusher) (gcc
version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #1
SMP Mon Jun 28 09:52:04 CEST 2004
<snip>
Jun 30 04:08:35 crusher Red Hat/Adaptec aacraid driver (1.1.2-lk2 Jun 30
2004)
Jun 30 04:08:36 crusher AAC0: kernel 4.1.4 build 7244
Jun 30 04:08:36 crusher AAC0: monitor 4.1.4 build 7244
Jun 30 04:08:36 crusher AAC0: bios 4.1.0 build 7244
Jun 30 04:08:36 crusher AAC0: serial b74e68fafaf001
Jun 30 04:08:36 crusher AAC0: 64bit support enabled.
Jun 30 04:08:36 crusher AAC0: 64 Bit PAE enabled
Jun 30 04:08:36 crusher scsi1 : aacraid
Jun 30 04:08:36 crusher Vendor: ADAPTEC   Model: Adaptec Stripe    Rev: V1.0
Jun 30 04:08:36 crusher Type:   Direct-Access                      ANSI SCSI
revision: 02
Jun 30 04:08:36 crusher SCSI device sdc: 178699520 512-byte hdwr sectors
(91494 MB)
Jun 30 04:08:36 crusher sdc: Write Protect is off
Jun 30 04:08:36 crusher sdc: Mode Sense: 03 00 00 00
Jun 30 04:08:36 crusher SCSI device sdc: drive cache: write through
Jun 30 04:08:36 crusher /dev/scsi/host1/bus0/target0/lun0: p1
Jun 30 04:08:36 crusher Attached scsi removable disk sdc at scsi1, channel
0, id 0, lun 0
Jun 30 04:08:36 crusher Attached scsi generic sg2 at scsi1, channel 0, id 0,
lun 0,  type 0
Jun 30 04:09:59 crusher kjournald starting.  Commit interval 5 seconds
Jun 30 04:09:59 crusher EXT3 FS on sdc1, internal journal
Jun 30 04:09:59 crusher EXT3-fs: recovery complete.
Jun 30 04:09:59 crusher EXT3-fs: mounted filesystem with ordered data mode.
Jun 30 04:11:13 crusher write_callback: write failed, status = 5
Jun 30 04:11:13 crusher SCSI error : <1 0 0 0> return code = 0x8000002
Jun 30 04:11:13 crusher Info fld=0x0, Current sdc: sense key Hardware Error
Jun 30 04:11:13 crusher Additional sense: Internal target failure
Jun 30 04:11:13 crusher end_request: I/O error, dev sdc, sector 47395279
Jun 30 04:11:13 crusher Buffer I/O error on device sdc1, logical block
5924402
Jun 30 04:11:13 crusher lost page write due to I/O error on sdc1
Jun 30 04:11:14 crusher write_callback: write failed, status = 5
Jun 30 04:11:14 crusher SCSI error : <1 0 0 0> return code = 0x8000002
Jun 30 04:11:14 crusher Info fld=0x0, Current sdc: sense key Hardware Error
Jun 30 04:11:14 crusher Additional sense: Internal target failure
Jun 30 04:11:14 crusher end_request: I/O error, dev sdc, sector 47393319
Jun 30 04:11:14 crusher Buffer I/O error on device sdc1, logical block
5924157
Jun 30 04:11:14 crusher lost page write due to I/O error on sdc1
Jun 30 04:11:14 crusher write_callback: write failed, status = 5
Jun 30 04:11:14 crusher SCSI error : <1 0 0 0> return code = 0x8000002
Jun 30 04:11:14 crusher Info fld=0x0, Current sdc: sense key Hardware Error
Jun 30 04:11:14 crusher Additional sense: Internal target failure
Jun 30 04:11:14 crusher end_request: I/O error, dev sdc, sector 47397239
Jun 30 04:11:14 crusher Buffer I/O error on device sdc1, logical block
5924647
Jun 30 04:11:14 crusher lost page write due to I/O error on sdc1
Jun 30 04:11:14 crusher write_callback: write failed, status = 5
Jun 30 04:11:14 crusher SCSI error : <1 0 0 0> return code = 0x8000002
Jun 30 04:11:14 crusher Info fld=0x0, Current sdc: sense key Hardware Error
Jun 30 04:11:14 crusher Additional sense: Internal target failure
Jun 30 04:11:14 crusher end_request: I/O error, dev sdc, sector 47390183
Jun 30 04:11:14 crusher Buffer I/O error on device sdc1, logical block
5923765
Jun 30 04:11:14 crusher lost page write due to I/O error on sdc1
Jun 30 04:11:43 crusher aacraid: Host adapter reset request. SCSI hang ?
Jun 30 04:11:44 crusher aacraid: Host adapter appears dead
Jun 30 04:11:44 crusher scsi: Device offlined - not ready after error
recovery: host 1 channel 0 id 0 lun 0
Jun 30 04:11:44 crusher scsi: Device offlined - not ready after error
recovery: host 1 channel 0 id 0 lun 0

<snip>
Jun 30 04:11:45 crusher scsi: Device offlined - not ready after error
recovery: host 1 channel 0 id 0 lun 0
Jun 30 04:11:45 crusher scsi: Device offlined - not ready after error
recovery: host 1 channel 0 id 0 lun 0
Jun 30 04:11:45 crusher SCSI error : <1 0 0 0> return code = 0x6000000
Jun 30 04:11:45 crusher end_request: I/O error, dev sdc, sector 47389407
Jun 30 04:11:45 crusher Buffer I/O error on device sdc1, logical block
5923668
Jun 30 04:11:45 crusher lost page write due to I/O error on sdc1
Jun 30 04:11:45 crusher scsi1 (0:0): rejecting I/O to offline device
Jun 30 04:11:45 crusher Buffer I/O error on device sdc1, logical block
5923669
Jun 30 04:11:45 crusher lost page write due to I/O error on sdc1
Jun 30 04:11:45 crusher Buffer I/O error on device sdc1, logical block
5923670
Jun 30 04:11:45 crusher lost page write due to I/O error on sdc1


What can I do ? I'm so desperate that I'm thinking switching to another
RAID controller. BTW which one of dual-channel U320 with cache have stable
drivers for x86_64 platform ?

regards,
Bartholomew Melnicki



