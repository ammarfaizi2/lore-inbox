Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130671AbRBGAmM>; Tue, 6 Feb 2001 19:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130673AbRBGAmC>; Tue, 6 Feb 2001 19:42:02 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:28945 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S130671AbRBGAlx>; Tue, 6 Feb 2001 19:41:53 -0500
Date: Tue, 6 Feb 2001 19:41:51 -0500 (EST)
From: Ivan Borissov Ganev <ganev@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.[01] lockups
In-Reply-To: <Pine.LNX.4.20.0102070207300.1226-500000@gamspc7.ihep.su>
Message-ID: <Pine.SOL.4.21.0102061907230.7348-100000@tuomotu.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I am experiencing a problem with both 2.4.0 and 2.4.1. The problem is that
at seemingly random times the console locks up. After the lockup I can no
longer type and the mouse is frozen. As far as I can tell, other systems
services are not affected, i.e. programs continue to run, music is being
played, I/O is fine. It looks like _only_ the console devices are locked
up.

I work under X most of the time, but this has happened on a bare VC once
also. The frequency of occurrence varies from 0 to a few times a day, with
an average about 1 time/day.

When it happens I use my UPS to power the machine down gracefully and then
reboot, however, it is a nuisance. After reboot the system log does not
have anything out of the ordinary in it. I think this might be related to
the other reports of lockups with 2.4.1 (by Ed Tomlinson and Alexander
Zvyagin).

The system specs are the following:

motherboard: ABIT BH6 rev 1.0
	the BH6 is based on Intel's 440BX chipset
	(chipset BIOS updated to the latest available one)

CPU: Pentium II (Deschutes) stepping 02 @ 400MHz

RAM: 256MB SDRAM

HDD: 3 hard drives:
	hda: QUANTUM BIGFOOT TS8.4A, ATA DISK drive	( 8GB)
	hdb: WDC WD205AA, ATA DISK drive		(30GB)
	hdc: WDC AC21200H, ATA DISK drive		( 1GB)

CD-ROM:
	hdd: CR-801NP, ATAPI CD/DVD-ROM drive

FDC:
	Floppy drive(s): fd0 is 1.44M
	FDC 0 is a post-1991 82077

ttyS:
	two serial ports on the motherboard

video:
	Matrox Millenium G200 (8MB SDRAM)

eth:
	Intel EtherExpressPro 10/100 (connected to DSL)

sound:
	Creative SB AWE64 (ISA device)

modem:
	USR3030/2729371324[0]{U.S. Robotics 56K FAX INT}

I also have a Hauppauge bt848-based TV tuner card but the driver for it
is compiled as a module and not loaded or used.

All hard drives use DMA by default but the kernel usually switches to PIO
for the CD-ROM after I start using it.

Any ideas as to the cause for the lockups would be greatly appreciated. I
am also willing to experiment/troubleshoot/test possible solutions, except
that I have no idea where to start from.

Cheers,
--Ivan


------------------------------------------------------------------------------
        Ivan Ganev                           327236 Georgia Tech Station
   College of Computing                           Atlanta,  GA 30332
Georgia Institute of Technology                    1-(404)-365-8694
    ganev@cc.gatech.edu                     http://www.cc.gatech.edu/~ganev     
------------------------------------------------------------------------------
             Learning is not compulsory. Neither is survival.
                        -- W. Edwards Deming




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
