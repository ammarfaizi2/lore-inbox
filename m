Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSD2V40>; Mon, 29 Apr 2002 17:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315211AbSD2V4Z>; Mon, 29 Apr 2002 17:56:25 -0400
Received: from smtp0.nada.kth.se ([130.237.222.202]:36751 "EHLO
	smtp0.nada.kth.se") by vger.kernel.org with ESMTP
	id <S315210AbSD2V4Y>; Mon, 29 Apr 2002 17:56:24 -0400
Message-ID: <3CCDC0E0.6040807@nada.kth.se>
Date: Mon, 29 Apr 2002 23:53:36 +0200
From: "Andrew T. Miller" <amiller@nada.kth.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ide dma timeout error, linux 2.4.9, PIIX4 Ultra 100 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andre and others:
I recently installed RedHat's 2.4.9-31 on my 1Ghz/256MB Dell Inspiron 8000.
Now a week or so later, I'm noticing dma errors in my messages file and my disk
is having FS problems.  I'm really hope this a software issue and that my disk
isn't hosed.  What can I do?  I've appended as much pertinent info as I can
think of, but please let me know if you need more.

I am not on the linux-kernel mailing list, so please cc me when replying.

TIA,
  -Andrew Miller

=================Excerpts from: /var/log/messages============================
kernel: Linux version 2.4.9-31 (bhcompile@daffy.perf.redhat.com) (gcc version 
2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Tue Feb 26 07:11:02 EST 2002
...
kernel: Kernel command line: auto BOOT_IMAGE=linux ro root=302 
BOOT_FILE=/boot/vmlinuz-2.4.9-31
...
kernel: PCI: PCI BIOS revision 2.10 entry at 0xfc06e, last bus=8
kernel: PCI: Using configuration type 1
kernel: PCI: Probing PCI hardware
kernel: Unknown bridge resource 2: assuming transparent
kernel: Unknown bridge resource 2: assuming transparent
kernel: PCI: Using IRQ router PIIX [8086/244c] at 00:1f.0
...
kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
kernel: ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
kernel: PIIX4: IDE controller on PCI bus 00 dev f9
kernel: PIIX4: chipset revision 3
kernel: PIIX4: not 100%% native mode: will probe irqs later
kernel:     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
kernel: hda: IBM-DJSA-232, ATA DISK drive
kernel: hdb: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: blk: queue c0352660, I/O limit 4095Mb (mask 0xffffffff)
kernel: blk: queue c0352660, I/O limit 4095Mb (mask 0xffffffff)
kernel: hda: 62506080 sectors (32003 MB) w/1874KiB Cache, CHS=3890/255/63, UDMA(66)
kernel: Partition check:
kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
...
fsck: /: clean, 20163/78624 files, 220017/313267 blocks
fsck: /usr
fsck:  contains a file system with errors, check forced.
fsck: /usr: 119584/704512 files (2.6% non-contiguous), 755987/1407687 blocks
fsck: /var: clean, 1139/64256 files, 93985/257008 blocks
rc.sysinit: Checking filesystems succeeded
...
kernel: hda: timeout waiting for DMA
kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
kernel: blk: queue c0352660, I/O limit 4095Mb (mask 0xffffffff)
kernel: hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: hda: drive not ready for command
kernel: blk: queue c0352660, I/O limit 4095Mb (mask 0xffffffff)
...
kernel: EXT2-fs error (device ide0(3,5)): ext2_check_page: bad entry in 
directory #475434: directory entry across blocks - offset=0, inode=1074324436, 
rec_len=59264, name_len=25
kernel: hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: hda: drive not ready for command
kernel: hdb: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
kernel: Uniform CD-ROM driver Revision: 3.12

...[By now system had come up, but later, while using the machine, I got:]...

kernel: hda: timeout waiting for DMA
kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
kernel: blk: queue c0352660, I/O limit 4095Mb (mask 0xffffffff)
kernel: hda: status timeout: status=0xd0 { Busy }
kernel: hdb: DMA disabled
kernel: hda: drive not ready for command

================== hdparm -iv /dev/hda ==========================
/dev/hda:
  multcount    =  0 (off)
  I/O support  =  0 (default 16-bit)
  unmaskirq    =  0 (off)
  using_dma    =  1 (on)
  keepsettings =  0 (off)
  nowerr       =  0 (off)
  readonly     =  0 (off)
  readahead    =  8 (on)
  geometry     = 3890/255/63, sectors = 62506080, start = 0

  Model=IBM-DJSA-232, FwRev=JS8OAD0A, SerialNo=48W48LR7370
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
  BuffType=DualPortCache, BuffSize=1874kB, MaxMultSect=16, MultSect=off
  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=62506080
  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes: pio0 pio1 pio2 pio3 pio4
  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4

=================== /proc/ide/piix ==============================

                                 Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                  enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              no                no
UDMA enabled:   yes              yes             no                no
UDMA enabled:   4                4               X                 X
UDMA
DMA
PIO






