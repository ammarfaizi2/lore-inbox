Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQKFRyQ>; Mon, 6 Nov 2000 12:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129635AbQKFRyH>; Mon, 6 Nov 2000 12:54:07 -0500
Received: from moot.mb.ca ([64.4.83.10]:19219 "EHLO moot.cdir.mb.ca")
	by vger.kernel.org with ESMTP id <S129524AbQKFRx7>;
	Mon, 6 Nov 2000 12:53:59 -0500
Date: Mon, 6 Nov 2000 11:53:56 -0600 (CST)
From: "Michael J. Dikkema" <mjd@moot.mb.ca>
To: linux-kernel@vger.kernel.org
Subject: Yikes!! messages in aic7xxx.c
Message-ID: <Pine.LNX.4.21.0011061148370.567-100000@sliver.moot.mb.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm hitting a message that looks similar to this: (I wrote it down..)

Yikes!! There is a loop in the free list
No active SCB for reconnecting target
Issuing BUS DEVICE RESET
  SAVED_TCL=0x0, ARG_1=0x3, SEQADR=0x11d

There is more, but this server needs to be running. 

These are the scsi devices attached:

(scsi0) <Adaptec AIC-7890/1 Ultra2 SCSI host adapter> found at PCI 0/6/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7890/1 Ultra2 SCSI host adapter>
scsi : 1 host.
(scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 16.
  Vendor: AccuRAID  Model:  AR-8600          Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:0:2:0) Synchronous at 20.0 Mbyte/sec, offset 8.
  Vendor: OnStream  Model: ADR50 Drive       Rev: 2.20
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi tape st0 at scsi0, channel 0, id 2, lun 0
scsi : detected 2 SCSI generics 1 SCSI tape 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 180076544 [87928 MB]
[87.9 GB]


I can reliably hit this whenever I copy 200-600mb of data from a windows
machine to this box over samba. We've tried changing the ram in the RAID
array, but that has had no effect.

Any help would be appreciated. Thanks.

,.;::
: Michael J. Dikkema
| Systems / Network Admin - Internet Solutions, Inc.
| http://www.moot.mb.ca   Work: (204) 982-1060
; mjd@moot.mb.ca
',.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
