Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263731AbSIVGu7>; Sun, 22 Sep 2002 02:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276646AbSIVGu5>; Sun, 22 Sep 2002 02:50:57 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:27402 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263731AbSIVGu4>; Sun, 22 Sep 2002 02:50:56 -0400
Date: Sun, 22 Sep 2002 08:55:04 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi problems (identical) in 2.5.38 and 2.4.20-pre7-ac3: CoD != 0 in idescsi_pc_intr
Message-ID: <20020922065504.GA1009@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

selected parts of dmesg:

hdg: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
ide-cd: passing drive hdg to ide-scsi emulation.
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-40125W        Rev: WS05
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr3: scsi3-mmc drive: 12x/12x writer cd/rw xa/form2 cdda tray

After writing for a while, it says:
ide-scsi: CoD != 0 in idescsi_pc_intr
hdg: ATAPI reset complete

and cdrdao mentions:

sudo cdrdao simulate --device 1,0,0 --driver generic-mmc --speed 12 test.cue
Cdrdao version 1.1.5 - (C) Andreas Mueller <andreas@daneb.de>
  SCSI interface library - (C) Joerg Schilling
  L-EC encoding library - (C) Heiko Eissfeldt
  Paranoia DAE library - (C) Monty

Check http://cdrdao.sourceforge.net/drives.html#dt for current driver tables.

Using libscg version 'schily-0.5'

1,0,0: LITE-ON LTR-40125W       Rev: WS05
Using driver: Generic SCSI-3/MMC - Version 1.2 (options 0x0000)

Starting write simulation at speed 12...
Pausing 10 seconds - hit CTRL-C to abort.
Process can be aborted with QUIT signal (usually CTRL-\).
Turning BURN-Proof on
Writing track 01 (mode MODE2_RAW/MODE2_RAW)...
Writing track 02 (mode MODE2_RAW/MODE2_RAW)...
?: Input/output error.  : scsi sendcmd: no error
CDB:  2A 00 00 01 58 88 00 00 1B 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 06 00 00 00 00 0A 00 00 00 00 29 00 00 00
Sense Key: 0x6 Unit Attention, Segment 0
Sense Code: 0x29 Qual 0x00 (power on, reset, or bus device reset occurred) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 3.160s timeout 180s
ERROR: Write data failed.
ERROR: Writing failed - buffer under run?
ERROR: Simulation failed.

Both 2.4.20-pre7-ac3 and 2.5.38 fail in this way.

Kind regards,
Jurriaan
-- 
Lightspeed is too slow. We're going to have to go right to Ludicrous Speed.
        Spaceballs - The Movie
GNU/Linux 2.5.37 SMP/ReiserFS 2x1380 bogomips load av: 0.18 0.74 0.57
