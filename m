Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277826AbRJWPzZ>; Tue, 23 Oct 2001 11:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277825AbRJWPzF>; Tue, 23 Oct 2001 11:55:05 -0400
Received: from AMontpellier-201-1-4-3.abo.wanadoo.fr ([217.128.205.3]:2322
	"EHLO awak") by vger.kernel.org with ESMTP id <S277826AbRJWPzC>;
	Tue, 23 Oct 2001 11:55:02 -0400
Subject: 2.4.12-ac5: IDE-SCSI kernel panic
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.22.19.14 (Preview Release)
Date: 23 Oct 2001 17:49:35 +0200
Message-Id: <1003852178.9892.51.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on a CD with a read error, using IDE-SCSI, there has always been lots of
problems (at least for me).
After tons of errors in the logs (medium error/unrecovered error), I
tried to kill-9 the process reading the mounted CD (xine) without
success (one thread stuck in lock_page, the other <defunct>). I then
tried to reboot, but even before init started kill-TERM processes, I got
this (hand-copied from screen):

scsi0: ERROR on channel 0, id 1, lun 0, CDB: Request Sense 00 00 00 40 00
Info fld=0x437ea, Current sd0b:00: sense key Medium Error
Additional sense indicates Unrecovered read error
 I/O error: dev 0b:00, sector 1105832
Incorrect segment count at 0xc01e4342nr_segments is 3f
counted segments is 19
Flags 0 0
Segment 0xd92e86c0, blocks 4, addr 0x1f983fff
Segment 0xd92e8660, blocks 4, addr 0x1f9847ff
[I'm not copying them all, around 25 of them]
Kernel panic: Ththththaats all folks. Too dangerous to continue.


	Xav

