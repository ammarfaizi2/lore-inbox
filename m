Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVHHXpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVHHXpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVHHXpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:45:23 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:40850 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932363AbVHHXpW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:45:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NLY22IEIdcyVCdvr52wWusUKYX80XMILffMmyMM4bSWMNyfn4dSBlgY/mWsNzuH26VvPJijCZynUMrqEil/0nBmCE+FDxwCRTLfDdHZx254V5f3bzhOISmg6uFr1qIFqmN6mFNBhAi3h4qXsZ1LvezVIkIiv5QWcbHK4wjOcNP0=
Message-ID: <7f45d9390508081645c1afd1c@mail.gmail.com>
Date: Mon, 8 Aug 2005 23:45:22 +0000
From: Shaun Jackman <sjackman@gmail.com>
To: debian-boot@lists.debian.org, debian-user@debian.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: SATALink Sil3112 and Linux woes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a Silicon Image SATALink Sil3112 PCI card connected to two 200
GB SATA Seagate drives.  I'm running into many problems with this
setup. Is this card well supported under Linux? If it's a black sheep,
could someone please recommend a PCI SATA card that works well?

First off, every 2.6 kernel I've tried distributed with Debian and
Knoppix stalls for about ten minutes immediately after booting and
without displaying anything. After waiting the ten minutes, the boot
up seems to continue without trouble. What's causing this delay, and
is there an option I can pass to the kernel line to avoid it?

The sarge installation CD (both the 2.4.27 kernel and the 2.6.8
kernel) hangs at the message
    Loading module 'sd_mod' for 'SCSI disk support'...

I downloading a recent 2005-Aug-05 Debian testing installation CD. I
was able to complete the entire installation up until rebooting for
the first time. The reboot failed displaying...
SCSI device sda: drive cache: write back
/dev/scsi/host0/bus0/target0/lun0: <3>ata1: command 0x25 timeout, stat
0x50 host_stat 0x4
p1 p2 p3 p4 <
The boot hung after displaying the left angle bracket. After ten
minutes, the screen blanked and I rebooted using ctrl-alt-del.

I booted the computer using a Knoppix 3.8.1 2005-April-08 CD with
Linux 2.6.11, mounted my newly installed Debian system, and chrooted
into it. I ran 'base-config new' and installed
kernel-image-2.6.11-1-k7. I removed the Knoppix CD and rebooted the
computer to the new Debian install using the 2.6.11 kernel. The boot
failed displaying...
pivot_root: No such file or directory
/sbin/init: 432: Cannot open dev/console: No such file
Kernel panic - not syncing: Attempted to kill init!

I am really having no luck. I would love to...
  solve the ten-minute boot delay issue
  replace the Sil3112 with a better supported card
  use Knoppix to somehow fix my newly installed Debian partition

If you have a suggestion as to how I might accomplish any of these
tasks, I'd love to hear from you!

Please cc me in your reply. Thanks!
Shaun

$ lspci
0000:00:00.0 Host bridge: nVidia Corporation nForce CPU bridge (rev b2)
0000:00:00.1 RAM memory: nVidia Corporation nForce 220/420 Memory
Controller (rev b2)
0000:00:00.2 RAM memory: nVidia Corporation nForce 220/420 Memory
Controller (rev b2)
0000:00:00.3 RAM memory: nVidia Corporation: Unknown device 01aa (rev b2)
0000:00:01.0 ISA bridge: nVidia Corporation nForce ISA Bridge (rev c3)
0000:00:01.1 SMBus: nVidia Corporation nForce PCI System Management (rev c1)
0000:00:02.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3)
0000:00:03.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce Ethernet
Controller (rev c2)
0000:00:05.0 Multimedia audio controller: nVidia Corporation: Unknown
device 01b0 (rev c2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce
Audio (rev c2)
0000:00:08.0 PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge (rev c2)
0000:00:09.0 IDE interface: nVidia Corporation nForce IDE (rev c3)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce AGP to PCI Bridge (rev b2)
0000:01:06.0 Ethernet controller: Accton Technology Corporation
SMC2-1211TX (rev 10)
0000:01:07.0 Multimedia video controller: Internext Compression Inc
iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
0000:01:08.0 Unknown mass storage controller: Silicon Image, Inc.
(formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA
Controller (rev 02)
0000:02:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550
AGP (rev 01)
