Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTFBUcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTFBUcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:32:17 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:7149 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S263922AbTFBUcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:32:12 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@gmx.net>
Subject: Re: ide problem - is this a known problem, or is the disk dead?
References: <20030601222857.GA1116@mur.org.uk> <20030601222857.GA1116@mur.org.uk> <1054567577.7771.42.camel@dhcp22.swansea.linux.org.uk>
Organization: Who, me?
User-Agent: tin/1.5.18-20030527 ("Peephole") (UNIX) (Linux/2.4.21-rc3-gzp2 (i686))
Message-ID: <42fc.3edbb770.a202c@gzp1.gzp.hu>
Date: Mon, 02 Jun 2003 20:45:36 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:

|> Jun  1 06:28:00 r2d2 kernel: hdc: dma_timer_expiry: dma status == 0x21
|> Jun  1 06:28:10 r2d2 kernel: hdc: timeout waiting for DMA
|> Jun  1 06:28:10 r2d2 kernel: hdc: timeout waiting for DMA
|> Jun  1 06:28:10 r2d2 kernel: hdc: (__ide_dma_test_irq) called while not waiting
|> Jun  1 06:28:10 r2d2 kernel: hdc: status timeout: status=0xd0 { Busy }
|> Jun  1 06:28:10 r2d2 kernel:
|> Jun  1 06:28:10 r2d2 kernel: hdc: drive not ready for command
|> Jun  1 06:28:40 r2d2 kernel: ide1: reset timed-out, status=0xd0
|> Jun  1 06:28:40 r2d2 kernel: hdc: status timeout: status=0xd0 { Busy }
|> Jun  1 06:29:11 r2d2 kernel:
| 
| Its hard to tell if thats a dead disk or just terminally confused. The
| drive stopped taking to us, set itself Busy and never came back even
| after we tried to reset it.

I'm running 2.4.21-rc3 on the host where i got this today:

hdc: dma_timer_expiry: dma status == 0x20
hdc: timeout waiting for DMA
hdc: timeout waiting for DMA
hdc: (__ide_dma_test_irq) called while not waiting
hdc: status timeout: status=0xd0 { Busy }

hdc: drive not ready for command
ide1: reset timed-out, status=0xd0
hdc: status timeout: status=0xd0 { Busy }

hdc: drive not ready for command
ide1: reset timed-out, status=0xd0
end_request: I/O error, dev 16:01 (hdc), sector 78496
end_request: I/O error, dev 16:01 (hdc), sector 78496
end_request: I/O error, dev 16:01 (hdc), sector 20328
end_request: I/O error, dev 16:01 (hdc), sector 20336
end_request: I/O error, dev 16:01 (hdc), sector 20344
end_request: I/O error, dev 16:01 (hdc), sector 20352
end_request: I/O error, dev 16:01 (hdc), sector 20360
end_request: I/O error, dev 16:01 (hdc), sector 20368
end_request: I/O error, dev 16:01 (hdc), sector 25427984
end_request: I/O error, dev 16:01 (hdc), sector 20376
end_request: I/O error, dev 16:01 (hdc), sector 20384
end_request: I/O error, dev 16:01 (hdc), sector 20392
end_request: I/O error, dev 16:01 (hdc), sector 20400
end_request: I/O error, dev 16:01 (hdc), sector 20408
end_request: I/O error, dev 16:01 (hdc), sector 20416
end_request: I/O error, dev 16:01 (hdc), sector 20424
end_request: I/O error, dev 16:01 (hdc), sector 16
end_request: I/O error, dev 16:01 (hdc), sector 37486592
end_request: I/O error, dev 16:01 (hdc), sector 37486608
end_request: I/O error, dev 16:01 (hdc), sector 54788120
end_request: I/O error, dev 16:01 (hdc), sector 0
end_request: I/O error, dev 16:01 (hdc), sector 37486608
EXT3-fs error (device ide1(22,1)): ext3_get_inode_loc: unable to read inode block - inode=2338338, block=4685826
Aborting journal on device ide1(22,1).
end_request: I/O error, dev 16:01 (hdc), sector 4176
Remounting filesystem read-only
end_request: I/O error, dev 16:01 (hdc), sector 0
EXT3-fs error (device ide1(22,1)) in ext3_reserve_inode_write: IO failure
EXT3-fs error (device ide1(22,1)) in ext3_orphan_add: IO failure
EXT3-fs error (device ide1(22,1)) in ext3_truncate: IO failure
EXT3-fs error (device ide1(22,1)) in start_transaction: Journal has aborted

My setup looks like:

Memory: 516616k/524204k available (1051k kernel code, 7200k reserved, 228k data, 76k init, 0k highmem)
CPU: Intel(R) Celeron(TM) CPU                1400MHz stepping 01
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 17
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
blk: queue c0278660, I/O limit 4095Mb (mask 0xffffffff)
hdc: IC25N040ATCS04-0, ATA DISK drive
blk: queue c0278ab4, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=4864/255/63, UDMA(100)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=77520/16/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
 /dev/ide/host0/bus1/target0/lun0: p1

Now I'm trying heavy reads/writes on the drive which failed,
but I'm unable to generate any error (yet). I had more than
2 weeks of uptime with this kernel.

/dev/hda: IC25N040ATCS04-0: 40 C
/dev/hdc: IC25N040ATCS04-0: 42 C

