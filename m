Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132361AbRBRNRa>; Sun, 18 Feb 2001 08:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132883AbRBRNRU>; Sun, 18 Feb 2001 08:17:20 -0500
Received: from cauchy.fie.us.es ([150.214.141.179]:29312 "HELO
	cauchy.fie.us.es") by vger.kernel.org with SMTP id <S132361AbRBRNRP>;
	Sun, 18 Feb 2001 08:17:15 -0500
Date: Sun, 18 Feb 2001 14:16:41 +0100 (CET)
From: Manuel Cepedello Boiso <manuel@cauchy.fie.us.es>
To: <linux-kernel@vger.kernel.org>
cc: Gadi Oxman <gadio@netvision.net.il>
Subject: Error reading last audio track under ide-scsi emulation.
Message-ID: <Pine.LNX.4.33.0102181343400.19183-100000@cauchy.fie.us.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



My system has a IDE ATAPI CD-RW (Matshita CW 7586) and has a serious
problem reading the last audio track of an audio CD. Reading the rest of
the tracks is Ok, but when trying to rip the last one I get the following
error:

[With cdda2wav, versions 1.9 and 1.10a13]

CDB:  47 00 00 3D 0D 3C 3D 0D 3D 00
Sense Bytes: F0 00 03 00 04 34 4F 0A 00 00 00 00 02 00 00 00
Sense Key: 0x3 Medium Error, Segment 0
Sense Code: 0x02 Qual 0x00 (no seek complete) Fru 0x0
Sense flags: Blk 275535 (valid)
cmd finished after 0.418s timeout 300s
recording 135.07599 seconds stereo with 16 bits @ 44100.0 Hz
->'track-19'...
cdda2wav: Input/output error. ReadCD MMC 12: scsi sendcmd: retryable error
CDB:  BE 04 00 04 0E 44 00 00 4B 10 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: F0 00 03 00 04 0E 8B 0A 00 00 00 00 02 00 00 00
Sense Key: 0x3 Medium Error, Segment 0
Sense Code: 0x02 Qual 0x00 (no seek complete) Fru 0x0
Sense flags: Blk 265867 (valid)
cmd finished after 0.379s timeout 300s

... and it keeps on like that.

[With cdparanoia III rel. 9.7]

Ripping from sector  265204 (track 19 [0:00.00])
          to sector  275385 (track 19 [2:15.56])

outputting to cdda.wav

scsi_read error: sector=265204 length=3 retry=0
                 Sense key: 3 ASC: 2 ASCQ: 0
                 Transport error: Medium reading data from medium
                 System error: Input/output error
scsi_read error: sector=265207 length=13 retry=0
                 Sense key: 3 ASC: 2 ASCQ: 0
                 Transport error: Medium reading data from medium
                 System error: Input/output error
scsi_read error: sector=265207 length=6 retry=1
                 Sense key: 3 ASC: 2 ASCQ: 0
                 Transport error: Medium reading data from medium
                 System error: Input/output error

... and so on.

Both kernel versions 2.4.1 and 2.2.18 have this problem and, of course,
(I think) this is not a hardware problem since ripping only with IDE
CDROM support is perfect and clean.

My /proc/scsi/scsi says:
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MATSHITA Model: CD-RW  CW-7586   Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02


Thanks in advance,

Manuel Cepedello Boiso
E-mail: manuel@cauchy.fie.us.es

P.D. BTW, I've got full of

'kernel: VFS: Disk change detected on device sr(11,0)'

on my syslog. Is it normal?

