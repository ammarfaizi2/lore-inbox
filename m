Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAIWNs>; Tue, 9 Jan 2001 17:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRAIWNi>; Tue, 9 Jan 2001 17:13:38 -0500
Received: from macaulay.demon.co.uk ([194.222.190.183]:260 "EHLO
	macaulay.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129511AbRAIWNa>; Tue, 9 Jan 2001 17:13:30 -0500
Date: Tue, 9 Jan 2001 17:26:39 GMT
From: Tony Sumner <solon@macaulay.demon.co.uk>
Message-Id: <200101091726.f09HQd700480@macaulay.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Ftape bug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with ftape. What happened was that I had a backup on
QIC80 tape that I made from Red Hat 5.2 and I (foolishly?) installed
SuSE 7.0. I then found I could not read the tape with the newer version
of ftape. 

In the Ftape-HOWTO Claus Heine gives a check list of the things I
need to tell you about:

Kernel version: was 2.0.36, now 2.2.16

ftape version: 3.04d

model: Colorado Jumbo DJ-10/DJ-20

bus type: The motherboard has both ISA and PCI slots but I don't 
          think this is relevant because I wrote and read the tape 
          with the older kernel so it is not a matter of ftape not working. 

what I did: I copied tob to the SuSE system and ran it. I didn't recompile
            afio but used the SuSE version. All afio does is call ftape.

what went wrong: tob reported 'No input'. The log in /var/spool/messages
            had a report from ftape to say that it was looking at a 
            new cartridge. An extract from the log is below. It was not
            a new cartridge -- I have been able to read it by reloading
            kernel 2.0.36 and the corresponding version 2.08 of ftape. 

Current kernel: I still have it, and the file ftape.o

Another point: in Red Hat /dev/ftape is a link to /dev/rft0 while in SuSE
it is a link to /dev/qft0; Does that make any difference?

Before I try increasing the tracing level maybe you could let me know
whether this is a new thing or something you know about already. 

Tony Sumner

I am not a subscriber to this mailing list so I was advised to ask
you to Cc any reply to me at solon@macaulay.demon.co.uk
-----------------------------------------------------------------
Nov 25 20:23:54 macaulay kernel: ftape v3.04d 25/11/97
Nov 25 20:23:54 macaulay kernel: (c) 1993-1996 Bas Laarhoven (bas@vimec.nl)
Nov 25 20:23:54 macaulay kernel: (c) 1995-1996 Kai Harrekilde-Petersen (khp@dolphinics.no)
Nov 25 20:23:54 macaulay kernel: (c) 1996-1997 Claus-Justus Heine (claus@momo.math.rwth-aachen.de)
Nov 25 20:23:54 macaulay kernel: QIC-117 driver for QIC-40/80/3010/3020 floppy tape drives
Nov 25 20:23:54 macaulay kernel: Compiled for Linux version 2.2.16
Nov 25 20:23:54 macaulay kernel: [000] ftape-init.c (ftape_init) - installing QIC-117 floppy tape hardware drive ... .
Nov 25 20:23:54 macaulay kernel: [001] ftape-init.c (ftape_init) - ftape_init @ 0xc283a054.
Nov 25 20:23:54 macaulay kernel: [002]   ftape-buffer.c (add_one_buffer) - buffer nr #1 @ c0917220, dma area @ c0ab8000.
Nov 25 20:23:54 macaulay kernel: [003]   ftape-buffer.c (add_one_buffer) - buffer nr #2 @ c09172c0, dma area @ c0a80000.
Nov 25 20:23:54 macaulay kernel: [004]   ftape-buffer.c (add_one_buffer) - buffer nr #3 @ c0917040, dma area @ c09f8000.
Nov 25 20:23:54 macaulay kernel: [005]   ftape-calibr.c (time_inb) - inb() duration: 638 nsec.
Nov 25 20:23:54 macaulay kernel: [006]  ftape-calibr.c (ftape_calibrate) - TC for `ftape_udelay()' = 840 nsec (at 10239 counts).
Nov 25 20:23:54 macaulay kernel: [007]  ftape-calibr.c (ftape_calibrate) - TC for `fdc_wait()' = 1784 nsec (at 5119 counts).
Nov 25 20:23:54 macaulay kernel: zftape for ftape v3.04d 25/11/97
Nov 25 20:23:54 macaulay kernel: (c) 1996, 1997 Claus-Justus Heine (claus@momo.math.rwth-aachen.de)
Nov 25 20:23:54 macaulay kernel: vfs interface for ftape floppy tape driver.
Nov 25 20:23:54 macaulay kernel: Support for QIC-113 compatible volume table, dynamic memory allocation
Nov 25 20:23:54 macaulay kernel: and builtin compression (lzrw3 algorithm).
Nov 25 20:23:54 macaulay kernel: Compiled for Linux version 2.2.16
Nov 25 20:23:54 macaulay kernel: [008] zftape-init.c (zft_init) - zft_init @ 0xc2861538.
Nov 25 20:23:54 macaulay kernel: [009] zftape-init.c (zft_init) - installing zftape VFS interface for ftape driver ....
Nov 25 20:23:54 macaulay kernel: [010]     fdc-io.c (fdc_config) - fdc base: 0x3f0, irq: 6, dma: 2.
Nov 25 20:23:54 macaulay kernel: [011]     fdc-io.c (fdc_probe) - Type 8272A/765A compatible FDC found.
Nov 25 20:23:56 macaulay kernel: [012]    ftape-ctl.c (ftape_get_drive_status) - status: new cartridge.

etc


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
