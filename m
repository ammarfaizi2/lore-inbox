Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263935AbRFNDhh>; Wed, 13 Jun 2001 23:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263975AbRFNDh1>; Wed, 13 Jun 2001 23:37:27 -0400
Received: from f23.law3.hotmail.com ([209.185.241.23]:59658 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S263935AbRFNDhW>;
	Wed, 13 Jun 2001 23:37:22 -0400
X-Originating-IP: [65.25.189.2]
From: "John William" <jw2357@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: kurt@garloff.de
Subject: tmscsim.o INQUIRY inconsistency in 2.2.19
Date: Thu, 14 Jun 2001 03:37:15 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F23vEbjkyqU7a0xtAEH000007a3@hotmail.com>
X-OriginalArrivalTime: 14 Jun 2001 03:37:16.0088 (UTC) FILETIME=[4E79EB80:01C0F483]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this a known bug in tmscsim.o (2.0f, included with 2.2.19):

I have the following devices (cat /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST15230N         Rev: 0638
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-3601TA Rev: 0725
  Type:   CD-ROM                           ANSI SCSI revision: 02

cat /proc/scsi/tmscsim/0

Tekram DC390/AM53C974 PCI SCSI Host Adapter, Driver Version 2.0f 2000-12-20
SCSI Host Nr 0, AM53C974 Adapter Nr 0
IOPortBase 0xff00, IRQ 10
MaxID 7, MaxLUN 8, AdapterID 7, SelTimeout 250 ms, DelayReset 1 s
TagMaxNum 16, Status 0x00, ACBFlag 0x00, GlitchEater 24 ns
Statistics: Cmnds 257518, Cmnds not sent directly 25959, Out of SRB conds 0
            Lost arbitrations 6240, Sel. connected 0, Connected: No
Nr of attached devices: 2, Nr of DCBs: 2
Map of attached LUNs: 01 00 00 00 01 00 00 00
Idx ID LUN Prty Sync DsCn SndS TagQ NegoPeriod SyncSpeed SyncOffs MaxCmd
00  00  00  Yes  Yes  Yes  Yes  Yes   100 ns    10.0 M      15      16
01  04  00  Yes  Yes  Yes  Yes  No    236 ns     4.0 M      15      01
Commands in Queues: Query: 0:

Often (but not always), on boot, I get Sync as "No" for the hard drive (Idx 
0). Doing "echo 'inquiry 0' > 0" always fixes the problem after boot but for 
some reason, the driver doesn't (always) pick up on this at boot time. It 
doesn't seem to matter if it's a boot up from power-off or soft reboot.

The drive, Seagate Hawk, support synchronous operation and sync negotiation.

- John

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

