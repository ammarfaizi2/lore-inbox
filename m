Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273515AbRJKHuF>; Thu, 11 Oct 2001 03:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRJKHtz>; Thu, 11 Oct 2001 03:49:55 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:30474 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S273515AbRJKHts>; Thu, 11 Oct 2001 03:49:48 -0400
Message-ID: <3BC55363.ABE2813B@namesys.com>
Date: Thu, 11 Oct 2001 12:08:03 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.4-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Ullrich <chris@chrullrich.de>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Can't mount reiserfs with 2.4.11, 2.4.10 works fine
In-Reply-To: <20011011061239.A990@christian.chrullrich.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Christian Ullrich wrote:

> Hello!
>
> After upgrading from 2.4.10 to 2.4.11, I can no longer
> mount one particular reiserfs; everything else works fine.
> The reiserfs in question uses the 3.6 disk format.
>
> I get the following messages in syslog:
>
> kernel: hdb6: bad access: block=128, count=2
> kernel: end_request: I/O error, dev 03:46 (hdb), sector 128
> kernel: read_super_block: bread failed (dev 03:46, block 64, size 1024)
> kernel: hdb6: bad access: block=16, count=2
> kernel: end_request: I/O error, dev 03:46 (hdb), sector 16
> kernel: read_super_block: bread failed (dev 03:46, block 8, size 1024)
>
> With 2.4.10, there is no problem, neither before nor after
> 2.4.11 failed.
>

http://www.kernel.org/pub/linux/kernel/v2.4/ChangeLog-2.4.11 says that pre1 and
pre2 got some block device changes. Although I am not sure they made block
device driver less persistent.
Have you tried to run badblocks under 2.4.10 and 2.4.11?

Anyway, I would not trust to this hard drive too much.

Thanks,
vs


> fstab:
>
> /dev/sda2       /                       reiserfs        defaults 1 1
> /dev/sda3       /usr                    reiserfs        defaults 1 2
> /dev/sda5       /opt                    reiserfs        defaults 1 2
> /dev/hda6       /boot                   ext2            defaults 1 2
> /dev/sda7       /var                    reiserfs        defaults 1 2
> /dev/sdb1       /home                   reiserfs        defaults 1 2
> /dev/hdb6       /home/chris/dmp3e       reiserfs        defaults 1 2
>
> reiserfs is built as a module, loaded from initrd. IDE is built in.
>
> More dmesg output (from 2.4.10, this is the first boot after
> 2.4.11):
>
> Unknown bridge resource 0: assuming transparent
> PCI: Using IRQ router VIA [1106/0686] at 00:04.0
> PCI: Found IRQ 10 for device 00:0b.0
> PCI: Sharing IRQ 10 with 00:11.0
> Applying VIA southbridge workaround.
>
> [...]
>
> VP_IDE: IDE controller on PCI bus 00 dev 21
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
>     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
>
> [...]
>
> hdb: FUJITSU MPG3409AT E, ATA DISK drive
>
> [...]
>
> hdb: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=79428/16/63, UDMA(100)
>  hdb: hdb1 hdb2 < hdb5 hdb6 > hdb3
>
> [...]
>
> reiserfs: checking transaction log (device 03:46) ...
> Using r5 hash to sort names
> ReiserFS version 3.6.25
>
> ---------------------------------------------------------------
>
> Please send replies to linux-kernel to me as well, I'm not
> currently subscribed. I am on reiserfs-list, though.
>
> --
> Christian Ullrich                    Registrierter Linux-User #125183
>
> "Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"

