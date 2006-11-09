Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424121AbWKIQzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424121AbWKIQzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424125AbWKIQzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:55:24 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:45888 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1424121AbWKIQzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:55:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pSYsJ92wJ50t6c+e2QGUzhJj/wkTisKEV/U3tC0uTzbIYPUOyMIVfsMgsyUKiimwkCnbGOTFEufgcJdYa2GhPdpql8yUt9rtbBbVCiwOKTBb5u1ySwuEH9jDViXsMNNwRxbUnm/yNigFMWHP4kmJLR3P+HbvEDy0sO/CfWCSHpY=
Message-ID: <d9a083460611090855w3b3a9eb6w347a24b1e704ca61@mail.gmail.com>
Date: Thu, 9 Nov 2006 17:55:20 +0100
From: Jano <jasieczek@gmail.com>
To: "Jiri Slaby" <jirislaby@gmail.com>
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Cc: "Phillip Susi" <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <45534D2C.6080509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>
	 <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>
	 <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/11/9, Jiri Slaby <jirislaby@gmail.com>:
> Jano: please, do not remove Cc people, when replying (i.e. reply to all)
>

Oops, apologise, I'm getting used to a different mail client
interface. I'll try to do my best to follow the etiquette.

>
> Phillip Susi wrote:
> > Ubuntu uses an initramfs, so unless he has rebuilt his kernel to get
> > around that, he should still be using one.
>

I've compiled it into the kernel, but it doesn't work.

> > OP, please check dmesg for any new errors after you attempt to mount
> > something on hdb.  Also what is the output of a mount command with no
> > options?

Mount haven't changed. And here's my dmesg acquired after the last
compilation. It's a diff from the previous version I posted, which can
be found here: http://lkml.org/lkml/2006/11/08/322

--- 2.6.18.1	2006-11-08 22:07:53.000000000 +0100
+++ 2.6.18.1b	2006-11-09 18:32:26.000000000 +0100
@@ -51,7 +51,7 @@
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
 Memory: 906300k/917504k available (1813k kernel code, 10728k
reserved, 571k data, 172k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 3682.73 BogoMIPS (lpj=7365468)
+Calibrating delay using timer specific routine.. 3682.72 BogoMIPS (lpj=7365441)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000
00000000 00000000 00000000 00000000
 CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
00000000 00000000 00000000
@@ -150,31 +150,16 @@
 Freeing unused kernel memory: 172k freed
 input: ImExPS/2 Logitech Wheel Mouse as /class/input/input1
 NET: Registered protocol family 1
-hdc: ATAPI 52X DVD-ROM drive, 256kB Cache
-Uniform CD-ROM driver Revision: 3.20
 eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
 Linux agpgart interface v0.101 (c) Dave Jones
 agpgart: Detected VIA KT400/KT400A/KT600 chipset
 agpgart: AGP aperture is 64M @ 0xf8000000
-usbcore: registered new driver usbfs
-usbcore: registered new driver hub
-ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 17
-PCI: VIA IRQ fixup for 0000:00:10.3, from 0 to 1
-ehci_hcd 0000:00:10.3: EHCI Host Controller
-ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
-ehci_hcd 0000:00:10.3: irq 17, io mem 0xbe000000
-ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
-usb usb1: configuration #1 chosen from 1 choice
-hub 1-0:1.0: USB hub found
-hub 1-0:1.0: 6 ports detected
 Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
 serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
-hdd: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache
-ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 18
+ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 17
 ACPI: PCI interrupt for device 0000:00:0d.0 disabled
-usb 1-1: new high speed USB device using ehci_hcd and address 2
-usb 1-1: configuration #1 chosen from 1 choice
-ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 18 (level, low) -> IRQ 19
+hdc: ATAPI 52X DVD-ROM drive, 256kB Cache
+Uniform CD-ROM driver Revision: 3.20
 VP_IDE: IDE controller at PCI slot 0000:00:11.1
 ACPI: Unable to derive IRQ for device 0000:00:11.1
 ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
@@ -185,10 +170,25 @@
 VP_IDE: port 0x01f0 already claimed by ide0
 VP_IDE: port 0x0170 already claimed by ide1
 VP_IDE: neither IDE port enabled (BIOS)
+hdd: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache
+usbcore: registered new driver usbfs
+usbcore: registered new driver hub
+ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 18
+PCI: VIA IRQ fixup for 0000:00:10.3, from 0 to 2
+ehci_hcd 0000:00:10.3: EHCI Host Controller
+ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
+ehci_hcd 0000:00:10.3: irq 18, io mem 0xbe000000
+ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
+usb usb1: configuration #1 chosen from 1 choice
+hub 1-0:1.0: USB hub found
+hub 1-0:1.0: 6 ports detected
 NET: Registered protocol family 17
+usb 1-1: new high speed USB device using ehci_hcd and address 2
+usb 1-1: configuration #1 chosen from 1 choice
 drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if
0 alt 0 proto 2 vid 0x03F0 pid 0x2B17
 usbcore: registered new driver usblp
 drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
+ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 18 (level, low) -> IRQ 19
 parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
 parport0: irq 7 detected
 lp0: using parport0 (polling).

Below I've attach diff of my current .config in comparison to the one
posted over here: http://lkml.org/lkml/2006/11/09/11

--- config_old	2006-11-09 18:50:59.000000000 +0100
+++ /usr/src/linux-2.6.18.1/.config	2006-11-09 18:25:25.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.18.1
-# Thu Nov  9 00:28:54 2006
+# Thu Nov  9 18:25:25 2006
 #
 CONFIG_X86_32=y
 CONFIG_GENERIC_TIME=y
@@ -187,6 +187,7 @@
 CONFIG_PHYSICAL_START=0x100000
 CONFIG_COMPAT_VDSO=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+
 #
 # Power management options (ACPI, APM)
 #
@@ -592,8 +593,11 @@
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_SX8=m
 # CONFIG_BLK_DEV_UB is not set
-# CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set

@@ -607,7 +611,7 @@
 # Please see Documentation/ide.txt for help/info on IDE drives
 #
 # CONFIG_BLK_DEV_IDE_SATA is not set
-# CONFIG_BLK_DEV_HD_IDE is not set
+CONFIG_BLK_DEV_HD_IDE=y
 CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_IDEDISK_MULTI_MODE is not set
 CONFIG_BLK_DEV_IDECD=m
@@ -618,7 +622,7 @@
 #
 # IDE chipset support/bugfixes
 #
-CONFIG_IDE_GENERIC=y
+CONFIG_IDE_GENERIC=m
 # CONFIG_BLK_DEV_CMD640 is not set
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_IDEPCI_SHARE_IRQ=y
@@ -658,7 +662,7 @@
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_BLK_DEV_HD is not set
+CONFIG_BLK_DEV_HD=y

 #
 # SCSI device support
@@ -758,6 +762,7 @@
 CONFIG_SCSI_DC390T=m
 CONFIG_SCSI_NSP32=m
 CONFIG_SCSI_DEBUG=m
+
 #
 # Multi-device support (RAID and LVM)
 #
@@ -882,6 +887,7 @@
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
+
 #
 # Token Ring devices
 #

I hope this will be helpful. Thank you for your feedback.

Best regards,
Jano
-- 
Mail 	jano at stepien com pl
Jabber 	jano at jabber aster pl
GG 	1894343
Web	stepien.com.pl
