Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278085AbRJKENX>; Thu, 11 Oct 2001 00:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278087AbRJKENN>; Thu, 11 Oct 2001 00:13:13 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:5734 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S278085AbRJKENA>; Thu, 11 Oct 2001 00:13:00 -0400
Date: Thu, 11 Oct 2001 06:12:39 +0200
From: Christian Ullrich <chris@chrullrich.de>
To: linux-kernel@vger.kernel.org
Cc: reiserfs-list@namesys.com
Subject: Can't mount reiserfs with 2.4.11, 2.4.10 works fine
Message-ID: <20011011061239.A990@christian.chrullrich.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
X-Current-Uptime: 0 d, 00:14:30 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

After upgrading from 2.4.10 to 2.4.11, I can no longer
mount one particular reiserfs; everything else works fine.
The reiserfs in question uses the 3.6 disk format.

I get the following messages in syslog:

kernel: hdb6: bad access: block=128, count=2
kernel: end_request: I/O error, dev 03:46 (hdb), sector 128
kernel: read_super_block: bread failed (dev 03:46, block 64, size 1024)
kernel: hdb6: bad access: block=16, count=2
kernel: end_request: I/O error, dev 03:46 (hdb), sector 16
kernel: read_super_block: bread failed (dev 03:46, block 8, size 1024)

With 2.4.10, there is no problem, neither before nor after
2.4.11 failed.

fstab:

/dev/sda2       /                       reiserfs        defaults 1 1
/dev/sda3       /usr                    reiserfs        defaults 1 2
/dev/sda5       /opt                    reiserfs        defaults 1 2
/dev/hda6       /boot                   ext2            defaults 1 2
/dev/sda7       /var                    reiserfs        defaults 1 2
/dev/sdb1       /home                   reiserfs        defaults 1 2
/dev/hdb6       /home/chris/dmp3e       reiserfs        defaults 1 2

reiserfs is built as a module, loaded from initrd. IDE is built in.

More dmesg output (from 2.4.10, this is the first boot after
2.4.11):

Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Found IRQ 10 for device 00:0b.0
PCI: Sharing IRQ 10 with 00:11.0
Applying VIA southbridge workaround.

[...]

VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio

[...]

hdb: FUJITSU MPG3409AT E, ATA DISK drive

[...]

hdb: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=79428/16/63, UDMA(100)
 hdb: hdb1 hdb2 < hdb5 hdb6 > hdb3

[...]

reiserfs: checking transaction log (device 03:46) ...
Using r5 hash to sort names
ReiserFS version 3.6.25

---------------------------------------------------------------

Please send replies to linux-kernel to me as well, I'm not 
currently subscribed. I am on reiserfs-list, though.

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
