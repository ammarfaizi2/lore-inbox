Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155054AbQD0JNc>; Thu, 27 Apr 2000 05:13:32 -0400
Received: by vger.rutgers.edu id <S155037AbQD0JKE>; Thu, 27 Apr 2000 05:10:04 -0400
Received: from vaak.stack.nl ([131.155.140.140]:3140 "HELO mailhost.stack.nl") by vger.rutgers.edu with SMTP id <S155051AbQD0JJY>; Thu, 27 Apr 2000 05:09:24 -0400
Date: Thu, 27 Apr 2000 11:15:32 +0200 (CEST)
From: Jos Hulzink <josh@stack.nl>
To: Linux Kernel Mailinglist <linux-kernel@vger.rutgers.edu>
Subject: [Bug] 2.3.99-pre5 SMP locks up processor
Message-ID: <Pine.BSF.4.21.0004271046410.28731-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

This will be a bugreport in a way not very useful for I have been unable
to track down the problem completely, but anyway:

Description:

2.3.99-pre5 causes an NMI watchdog timer overflow (processor seems
crashed) when the system is under some load. (Compiling kernel with make
-j2, updating huge RedHat packages with rpm -U, playing Quake3 (r_smp
feature enabled by default))

The kernel also returns some data, but except the processor number that
locks up (0, i.e. not the boot-processor on this system), I could not find
any consequent values, so I guess it is of no use.

After the report, the system _seems_ to continue running on one processor
(keyboard interrupts are handled, proven by my CAPS-lock-crash-check-led),
though the system console is unusable (virtual console switching is
possible, though logging in or typing commands is inpossible). A magic
SysRQ followed by the hardware reset button is all there is left. 

2.3.99-non-SMP runs fine, as does 2.2.14 SMP (besides the lack of decent
motherboard support, causing some interrupt problems with MPS 1.4
enabled in BIOS). Also MS Windows 2000 has run for a long time on this
system, so hardware problems are unlikely.

Hardware:
2 x Intel Pentium 2 @ 333 MHz
Asus P 97 LX DS (Dual Proc, Wide SCSI, 66 MHz chipset) 
320 MB RAM
Soundblaster 16 PNP
2 x DLink Tulip network cards (obsolete, module NOT loaded)
Diamond Viper 550 AGP videocard.
Quantum Fireball KA 9.1 GB Harddisk
Quantum Atlas 9.1 GB Harddisk

Software:
RedHat 6.1 for Intel, besides kernel and kernel related issues unmodified.

--------------

Jos Hulzink


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
