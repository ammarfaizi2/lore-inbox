Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263015AbSJBJ1O>; Wed, 2 Oct 2002 05:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263017AbSJBJ1N>; Wed, 2 Oct 2002 05:27:13 -0400
Received: from ulima.unil.ch ([130.223.144.143]:45189 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S263015AbSJBJ1L>;
	Wed, 2 Oct 2002 05:27:11 -0400
Date: Wed, 2 Oct 2002 11:32:40 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi ooops with 2.5.40 (PIIX4 and DVD)
Message-ID: <20021002093240.GB3247@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>From dmesg:

---
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALL CX13.6A, ATA DISK drive
Debug: sleeping function called from illegal context at slab.c:1374
d7fdde14 d7fdde34 c013750b c02e67df 0000055e c03d483c c03d4874 c03d483c 
       d7fdde6c c01ec775 d7ff6b2c 000001d0 0000e307 c03d4888 00000000 00000206 
       00000042 00000000 00000042 c03d483c c03d482c c03d4780 d7fddeb4 c01ec81a 
Call Trace: [<c013750b>] [<c01ec775>] [<c01ec81a>] [<c0109ed9>] [<c01fe289>] [<c0205da0>] [<c01fe4c3>] [<c0206160>] [<c01fe958>] [<c01fe176>] [<c020fdfe>] [<c01fd487>] [<c010507d>] [<c0105040>] [<c0105675>]
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Pioneer DVD-ROM ATAPIModel DVD-103S 011, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
Debug: sleeping function called from illegal context at slab.c:1374
d7fdde14 d7fdde34 c013750b c02e67df 0000055e c03d4df8 c03d4e30 c03d4df8 
       d7fdde6c c01ec775 d7ff6b2c 000001d0 000000b0 c03d4e44 00000000 00000202 
       00000042 00000000 00000042 c03d4df8 c03d4de8 c03d4d3c d7fddeb4 c01ec81a 
Call Trace: [<c013750b>] [<c01ec775>] [<c01ec81a>] [<c0109ed9>] [<c01fe289>] [<c0205da0>] [<c01fe4c3>] [<c0206160>] [<c01fe958>] [<c01fe176>] [<c020fe1d>] [<c01fd487>] [<c010507d>] [<c0105040>] [<c0105675>]
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 26760384 sectors (13701 MB) w/418KiB Cache, CHS=1665/255/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2
ide-floppy driver 0.99.newide
hdd: 244766kB, 489532 blocks, 512 sector size
hdd: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
hdd: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
hdd: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
 /dev/ide/host0/bus1/target1/lun0: unknown partition table
 /dev/ide/host0/bus1/target1/lun0: unknown partition table
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
scsi_eh_offline_sdevs: Device set offline - notready or command retry failedafter error recovery: host0 channel 0 id 0 lun 0

---

ksymoops -m /usr/src/linux/System.map  -v /usr/src/linux/vmlinux  -K -O -L < dmesg-2.5.40
ksymoops 2.3.5 on i686 2.5.40.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux/System.map (specified)

cpu: 0, clocks: 99683, slice: 49841
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
d7fdde14 d7fdde34 c013750b c02e67df 0000055e c03d483c c03d4874 c03d483c 
       d7fdde6c c01ec775 d7ff6b2c 000001d0 0000e307 c03d4888 00000000 00000206 
       00000042 00000000 00000042 c03d483c c03d482c c03d4780 d7fddeb4 c01ec81a 
Call Trace: [<c013750b>] [<c01ec775>] [<c01ec81a>] [<c0109ed9>] [<c01fe289>] [<c0205da0>] [<c01fe4c3>] [<c0206160>] [<c01fe958>] [<c01fe176>] [<c020fdfe>] [<c01fd487>] [<c010507d>] [<c0105040>] [<c0105675>]
d7fdde14 d7fdde34 c013750b c02e67df 0000055e c03d4df8 c03d4e30 c03d4df8 
       d7fdde6c c01ec775 d7ff6b2c 000001d0 000000b0 c03d4e44 00000000 00000202 
       00000042 00000000 00000042 c03d4df8 c03d4de8 c03d4d3c d7fddeb4 c01ec81a 
Call Trace: [<c013750b>] [<c01ec775>] [<c01ec81a>] [<c0109ed9>] [<c01fe289>] [<c0205da0>] [<c01fe4c3>] [<c0206160>] [<c01fe958>] [<c01fe176>] [<c020fe1d>] [<c01fd487>] [<c010507d>] [<c0105040>] [<c0105675>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c013750b <__kmem_cache_alloc+10b/110>
Trace; c01ec775 <blk_init_free_list+65/f0>
Trace; c01ec81a <blk_init_queue+1a/110>
Trace; c0109ed9 <setup_irq+a9/e0>
Trace; c01fe289 <ide_init_queue+39/a0>
Trace; c0205da0 <do_ide_request+0/30>
Trace; c01fe4c3 <init_irq+1d3/3a0>
Trace; c0206160 <ide_intr+0/190>
Trace; c01fe958 <hwif_init+d8/260>
Trace; c01fe176 <probe_hwif_init+26/80>
Trace; c020fdfe <ide_setup_pci_device+4e/80>
Trace; c01fd487 <piix_init_one+37/40>
Trace; c010507d <init+3d/170>
Trace; c0105040 <init+0/170>
Trace; c0105675 <kernel_thread_helper+5/10>
Trace; c013750b <__kmem_cache_alloc+10b/110>
Trace; c01ec775 <blk_init_free_list+65/f0>
Trace; c01ec81a <blk_init_queue+1a/110>
Trace; c0109ed9 <setup_irq+a9/e0>
Trace; c01fe289 <ide_init_queue+39/a0>
Trace; c0205da0 <do_ide_request+0/30>
Trace; c01fe4c3 <init_irq+1d3/3a0>
Trace; c0206160 <ide_intr+0/190>
Trace; c01fe958 <hwif_init+d8/260>
Trace; c01fe176 <probe_hwif_init+26/80>
Trace; c020fe1d <ide_setup_pci_device+6d/80>
Trace; c01fd487 <piix_init_one+37/40>
Trace; c010507d <init+3d/170>
Trace; c0105040 <init+0/170>
Trace; c0105675 <kernel_thread_helper+5/10>


1 warning issued.  Results may not be reliable.
Exit 1

---

I have put the dmesg here:
http://ulima.unil.ch/greg/linux/dmesg-2.5.40
And the config file I used to compil the kernel here:
http://ulima.unil.ch/greg/linux/config-2.5.40
The output of ver_linux:
http://ulima.unil.ch/greg/linux/ver_linux
Finaly lspci -v:
http://ulima.unil.ch/greg/linux/lspci

I don't know if other info are needed...

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
