Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbSKFBSe>; Tue, 5 Nov 2002 20:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSKFBSe>; Tue, 5 Nov 2002 20:18:34 -0500
Received: from pcp02781107pcs.eatntn01.nj.comcast.net ([68.85.61.149]:60910
	"EHLO linnie.riede.org") by vger.kernel.org with ESMTP
	id <S265276AbSKFBSb>; Tue, 5 Nov 2002 20:18:31 -0500
Date: Tue, 5 Nov 2002 20:25:06 -0500
From: Willem Riede <wriede@riede.org>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi problem in 2.5.44
Message-ID: <20021106012506.GE3664@linnie.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realize Linus doesn't like ide-scsi, but while it exists I need it to work 
:-)

In 2.5.44 ide-scsi doesn't work with my OnStream DI-30 IDE Tape Drive.
Works fine with 2.4.18 on the same hardware. It's not an osst (the driver
for these devices, which I maintain) problem, the error comes from the
scsi host (ide-scsi).

When I try it, I get the following errors:

Nov  5 17:54:58 fallguy kernel: osst :I: Tape driver with OnStream support 
version 0.9.10
Nov  5 17:54:58 fallguy kernel: osst :I: $Id: osst.c,v 1.65 2001/11/11 
20:38:56 riede Exp $
Nov  5 17:54:58 fallguy kernel: osst :I: Attached OnStream SC-30 tape at 
scsi0, channel 0, id 0, lun 0 as osst0
Nov  5 17:54:58 fallguy kernel: osst :I: Attached OnStream DI-30 tape at 
scsi4, channel 0, id 1, lun 0 as osst1
Nov  5 17:55:10 fallguy kernel: osst1:W: Warning 2 (sugg. bt 0x0, driver bt 
0x0, host bt 0x0).
Nov  5 17:55:10 fallguy kernel: osst1:I: This warning may be caused by your 
scsi controller,
Nov  5 17:55:10 fallguy kernel: osst1:I: it has been reported with some 
Buslogic cards.
Nov  5 17:55:10 fallguy kernel: hdc: status error: status=0x50 { DriveReady 
SeekComplete }
Nov  5 17:55:10 fallguy kernel: ide-scsi: Strange, packet command initiated 
yet DRQ isn't asserted
Nov  5 17:55:10 fallguy kernel: osst1:W: Warning 2 (sugg. bt 0x0, driver bt 
0x0, host bt 0x0).
Nov  5 17:55:10 fallguy kernel: osst1:W: Warning 2 (sugg. bt 0x0, driver bt 
0x0, host bt 0x0).
Nov  5 17:55:10 fallguy kernel: osst1:I: Device did not become Ready in open
Nov  5 18:08:54 fallguy kernel: osst :I: Unloaded.

Note the "hdc:" and the "ide-scsi:" lines.

Does anyone know what ide-scsi's status is, and what might have gone wrong for 
me?

Thanks, Willem Riede.

