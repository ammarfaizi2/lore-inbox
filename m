Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTIHHOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 03:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTIHHOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 03:14:25 -0400
Received: from mx0.gmx.de ([213.165.64.100]:456 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S262070AbTIHHOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 03:14:23 -0400
Date: Mon, 8 Sep 2003 09:14:20 +0200 (MEST)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [2.6.0-test4] [BUG] ide floppy oops on probe...
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [81.107.201.188]
Message-ID: <13626.1063005260@www48.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting up with a floppy inserted in my LS-120 drive, or when accessing
the floppy after boot, the kernel oopses. Let me know if more information is
needed.

---

[snip]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5-SATA: IDE controller at PCI slot 0000:00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6Y080M0, ATA DISK drive
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LS-120 VER5 00 UHD Floppy, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
        current capacity is 160084415 sectors (81963 MB)
        native  capacity is 160086528 sectors (81964 MB)
hda: 160084415 sectors (81963 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(33)
 hda: hda1 hda2
ide-floppy driver 0.99.newide
hdc: 123264kB, 246528 blocks, 512 sector size
hdc: 123264kB, 963/8/32 CHS, 533 kBps, 512 sector size, 720 rpm
 hdc:<1>Unable to handle kernel paging request at virtual address f7411034
 printing eip:
c02f0b4d
*pde = 0060c067
*pte = 37411000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02f0b4d>]    Not tainted
EFLAGS: 00010046
EIP is at idefloppy_update_buffers+0x30/0x3e
eax: 00000000   ebx: f7411004   ecx: 00000000   edx: 00000001
esi: c05be170   edi: c05be170   ebp: c0539ea8   esp: c0539e94
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0538000 task=c04a60e0)
Stack: c05be170 00000001 00000000 c0538000 f74ae284 c0539ee0 c02f10c3
c05be170
       f74ae284 00000001 c0539ed4 c02f4741 f7411004 00000000 00000000
f74ae000
       c0538000 c05be170 f744c004 c0539f20 c02dcd0c c05be170 c04ab410
c0539f20
Call Trace:
 [<c02f10c3>] idefloppy_pc_intr+0x2f3/0x2f8
 [<c02f4741>] __ide_dma_test_irq+0x1e/0x57
 [<c02dcd0c>] ide_intr+0x2d2/0x5de
 [<c01138e3>] timer_interrupt+0x17f/0x3be
 [<c02f0dd0>] idefloppy_pc_intr+0x0/0x2f8
 [<c010d341>] handle_IRQ_event+0x39/0x62
 [<c010d948>] do_IRQ+0x144/0x3a4
 [<c0129d1b>] profile_hook+0x2f/0x4d
 [<c0108029>] default_idle+0x0/0x2c
 [<c0105000>] rest_init+0x0/0xf5
 [<c010b9a8>] common_interrupt+0x18/0x20
 [<c0108029>] default_idle+0x0/0x2c
 [<c0105000>] rest_init+0x0/0xf5
 [<c012007b>] __ioremap+0x9e/0xfa
 [<c0108050>] default_idle+0x27/0x2c
 [<c01080c1>] cpu_idle+0x31/0x3a
 [<c053a72a>] start_kernel+0x1bd/0x215
 [<c053a43f>] unknown_bootoption+0x0/0xfa

Code: 8b 4b 30 85 c9 75 e1 83 c4 0c 5b 5e 5d c3 55 89 e5 83 ec 18
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

-- 
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

