Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTEYRsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 13:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263673AbTEYRsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 13:48:10 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:9991 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S263680AbTEYRsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 13:48:08 -0400
Date: Sun, 25 May 2003 19:00:46 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Message-ID: <20030525170046.GA649@alpha.home.local>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva> <20030525173642.GA1365@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525173642.GA1365@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again !

the system could boot without DMA. It displayed lots of messages, but it seems
to work :


Linux version 2.4.21-rc3 (root@alpha) (gcc version 3.2.3) #4 Sun May 25 19:16:43 CEST 2003
Booting on Tsunami variation Webbrick using machine vector Webbrick from SRM
Command line: root=/dev/hda2 console=tty0 console=ttyS0,9600 bootdevice=scd0 bootfile=2.4.21-rc3/vmlinux
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end    32655
memcluster 2, usage 1, start    32655, end    32768
freeing pages 256:384
freeing pages 805:32655
reserving pages 805:806
On node 0 totalpages: 32655
zone(0): 32655 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda2 console=tty0 console=ttyS0,9600 bootdevice=scd0 bootfile=2.4.21-rc3/vmlinux
Using epoch = 1952
Console: colour VGA+ 80x25
Calibrating delay loop... 921.84 BogoMIPS
Memory: 252720k/261240k available (2094k kernel code, 6472k reserved, 451k data, 320k init)
Dentry cache hash table entries: 32768 (order: 6, 524288 bytes)
Inode cache hash table entries: 16384 (order: 5, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 8192 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 65536 bytes)
Page-cache hash table entries: 32768 (order: 5, 262144 bytes)
POSIX conformance testing by UNIFIX
PCI: dev Adaptec AIC-7892A U160/m type 64-bit
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
srm_env: version 0.0.5 loaded successfully
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
rtc: Digital UNIX epoch (1952) detected
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 2.88M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: WDC AC23200L, ATA DISK drive
hdc: Maxtor 6Y120L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: host protected area => 1
hda: 6346368 sectors (3249 MB) w/256KiB Cache, CHS=6296/16/63
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63
Partition check:
 hda: hda1 hda2 hda3 hda7
 hdc: hdc1
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

blk: queue fffffc00002214e8, no I/O memory limit
  Vendor: HP        Model: C1537A            Rev: L706
  Type:   Sequential-Access                  ANSI SCSI revision: 02
blk: queue fffffc00002216e8, no I/O memory limit
  Vendor: COMPAQ    Model: BD01864552        Rev: 3B04
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue fffffc00002218e8, no I/O memory limit
  Vendor: COMPAQ    Model: BD01864552        Rev: 3B04
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue fffffc0000221ae8, no I/O memory limit
  Vendor: COMPAQ    Model: BD01864552        Rev: 3B04
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue fffffc0000221ce8, no I/O memory limit
  Vendor: COMPAQ    Model: BD01864552        Rev: 3B04
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue fffffc000feee128, no I/O memory limit
------
After that, nothing special. I'm amazed by the number of "blk: queue..."
messages. This time, it only appears on SCSI, and not on IDE anymore.

So it seems as the IDE problem is in the ALI 1543 / DMA code. I have an old
K6/2 notebook somewhere with the same IDE controller, so I may retry on it.

I'm interested in any suggestion, of course ;-)

Willy

