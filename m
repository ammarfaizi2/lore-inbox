Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130879AbRANJFH>; Sun, 14 Jan 2001 04:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130839AbRANJE5>; Sun, 14 Jan 2001 04:04:57 -0500
Received: from lolita.speakeasy.net ([216.254.0.13]:619 "HELO
	lolita.speakeasy.net") by vger.kernel.org with SMTP
	id <S129967AbRANJEs>; Sun, 14 Jan 2001 04:04:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14945.27564.129240.650281@Max.B2Pi.com>
Date: Sun, 14 Jan 2001 04:04:44 -0500 (EST)
From: "Brent B. Powers" <lk!no-spam!@b2pi.com>
To: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: asus a7v 2.40 kernel crash
X-Mailer: VM 6.72 under 21.2  (beta34) "Molpe" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm currently experiencing a kernel panic on a newly compiled
(actually, a number of new compiled) 2.4.0 kernels. My suspicion is
that it's ide related, but I've nothing but gut to base that on. *I'm
also somewhat limited in that I can't get a dump to file of the actual
dump message.

Background:
    Base Hardware: Asus a7v, 800 Mhz TBird (athlon stepping 2) 128M
    Cards: AGP ATI Video (8M generic), realtek ether
    Disks: hda: st3144AT (ancient, but does well for root)
           hdc: generic udma-2 cdrom
	   hde: fujitsu 13M udma100

Compiler egcs-2.91.66

This setup does work under a stock (with the exception of the commonly
known ide flags for the promise controller) 2.2.14-5.0 kernel

Relevant console dump: (Please be patient, I'm typing this in by hand)

pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native code: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hda:DMA, hdb:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ7 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native code: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hde:pio, hdf:pio
    ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdg:DMA, hdh:pio
hda: st3144AT, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: set_drive_speed_status: status=0x51 {DriveReady SeekComplete Error }
hda: set_drive_speed_status: status=0x10 { SectorIdNotFound }, CHS=910/0/5<1>Unable to handle keren NULL pointer dereference at virtual address 00000014
 printing eip:
c018a613
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c018a613>]
EFLAGS: 00010282
eax: 00000000 ebx: c02a6a8e ecx: 00000001 edx: 00000001
esi: c02a6ba8 edi: c02a6ac0 ebp: c02a6a80 esp: c7fe3e40
ds: 0018 es: 0018 ss: 0018
Process  swapper (pid: 1, stackpage=c7fe3000)
Stack: c02a6a51 c02a6a80 c02a6ac0 c02a6a80 0000008e 0000038e c02a6a51 00000210
       00000286 c018e3c0 c02a6ac0 c020c912 00000051 00000154 0000001e 00000011
       00000001 0000000a c02a6a80 04000053 00000206 00000154 00000000 00000001
Call Trace: [<c018e3c0>] [<c0190f5e>] [<c0191081>] [<c019109e>] [<c019e51a>] [<c0193f5b>] [<c0105000>]
     [<c0107007>] [<c010744f>]

Code: 8b 48 14 85 c9 74 11 8b 41 28 50 68 6d ba 20 c0 e8 e4 8d f8
Kernel panic: Attempted to kill init!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
