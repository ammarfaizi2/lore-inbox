Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286135AbRLJBlT>; Sun, 9 Dec 2001 20:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286131AbRLJBlJ>; Sun, 9 Dec 2001 20:41:09 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:25534 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S286137AbRLJBkz>; Sun, 9 Dec 2001 20:40:55 -0500
Date: Mon, 10 Dec 2001 02:41:52 +0100
From: Steffen Evers <mlkernel@forevers.de>
To: linux-kernel@vger.kernel.org
Subject: cdrom read errors with aic7xxx/ide-scsi but not ide
Message-ID: <20011210014152.GA3083@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have experienced read errors using SCSI drivers (aic7xxx, aic7xxx_old,
ide-scsi) for two cdroms (Toshiba XM-6201TA SCSI, TEAC CD-W512EB IDE).
For testing I have used 'cat /dev/scd0 > /dev/null'. This fails on all
burned CD-Rs and CD-RWs I have found. but works for regular CDs.

Error messages always look like this:
Dec 10 02:09:38 localhost kernel: scsi0: ERROR on channel 0, id 2, lun
0, CDB: Read (10) 00 00 03 3c 22 00 00 3c 00
Dec 10 02:09:38 localhost kernel: Info fld=0x33c5d, Current sd0b:00:
sense key Medium Error
Dec 10 02:09:38 localhost kernel: Additional sense indicates Random
positioning error
Dec 10 02:09:38 localhost kernel:  I/O error: dev 0b:00, sector 848244
Dec 10 02:09:38 localhost kernel: attempt to access beyond end of device
Dec 10 02:09:38 localhost kernel: 0b:00: rw=0, want=424124, limit=424122

The medias are all high quality and from different vendors burned with
several different writers containing mainly images produced by mkisofs.

I have used two different computer systems and only moved my SCSI
controller with the Toshiba drive. Motherboards: ASUS P2B-F and
ASUS A7V133

Additionally, I have tried the TEAC CD-W512EB IDE writer to test the
ide-scsi driver on the ASUS A7V133. The same errors, but running 'cat
/dev/scd1 > /dev/null' a second time on the same burned CD and than it
works!

Simply not using the ide-scsi driver and accessing the drive via
regular ide driver and 'cat /dev/hdc > /dev/null' works without any
problem (same disc, same drive).

I have tried custom compiled kernels and/or Debian kernel-images of:
2.2.18, 2.2.19, 2.2.20, 2.4.12, 2.4.16

The environment was most of the time a current Debian Woody, but I have
tested some 2.2.x on Debian Potato r3 as well.

Always the same thing.

However, I can mount all these CDs and read all data then, but this
does not help with on-the-fly copying ...

Any suggestion, hints, solution? Thanks in advance.

I was thinking of simply buying a new IDE CDROM and thereby avoiding SCSI
for reading, but that is not really a satisfying solution ...

I can provide more info, just tell me what you need ...

Bye, Steffen

