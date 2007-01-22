Return-Path: <linux-kernel-owner+w=401wt.eu-S1751722AbXAVNjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbXAVNjG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 08:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbXAVNjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 08:39:06 -0500
Received: from bay0-omc1-s21.bay0.hotmail.com ([65.54.246.93]:15679 "EHLO
	bay0-omc1-s21.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751722AbXAVNjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 08:39:05 -0500
X-Greylist: delayed 846 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jan 2007 08:39:05 EST
Message-ID: <BAY112-F158EC2A9DA41567A619787C0AE0@phx.gbl>
X-Originating-IP: [61.247.252.55]
X-Originating-Email: [boardbringup@hotmail.com]
From: "Suresh Chandra Mannava" <boardbringup@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: serial console problem in linux-2.6-20 
Date: Mon, 22 Jan 2007 18:54:53 +0530
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_22f5_622d_54a2"
X-OriginalArrivalTime: 22 Jan 2007 13:24:56.0892 (UTC) FILETIME=[B58D9FC0:01C73E28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_22f5_622d_54a2
Content-Type: text/plain; format=flowed

Hi All,

I am working on porting linux-2.6.20-rc2 (DENX) kernel to our board. It
consists of powerpc MPC7410, IBM CPC700 system controller and couple of AMD
79C972 network chips.
I am using gcc version 4.0.0 (DENX ELDK 4.0 4.0.0) cross compiler for this
task.
I followed IBM spruce which consists of CPC700 as. CPC700 serial port is 
16550
compatible.
I can see printk's  on serial console till "Freeing unused kernel memory",
this happens before starting of init.
I enabled debug statements in 8250.c and found some messages "like
serial8250_interrupt(3)...end" and kernel freezes ( I attached serial
console messages). ttyS0 is using interrupt 3.

I assume it is not a tool chain or ramdisk image problem because I ported
linux-2.4 (DENX) with the same tool chain and ramdisk image.
Serial console is working fine in linux-2.4.

I request you to provide some pointers for the same.

Thanks,
Suresh

_________________________________________________________________
Always wanted to be a writer? Here's your chance! 
http://content.msn.co.in/Contribute/Default.aspx

------=_NextPart_000_22f5_622d_54a2
Content-Type: text/plain; name="serial.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="serial.txt"

Total memory = 128MB; using 256kB for hash table (at c0280000)
Linux version 2.6.20-rc5 (suresh@mannava) (gcc version 4.0.0 (DENX ELDK 4.0 
4.0.0)) #28 Sat Jan 20 21:26:52 IST 2007
System Identification: Cornet CSVG4 Linux Boot
Zone PFN ranges:
  DMA             0 ->    32768
  Normal      32768 ->    32768
early_node_map[1] active PFN ranges
    0:        0 ->    32768
Built 1 zonelists.  Total pages: 32512
Kernel command line: console=ttyS0,57600 root=/dev/ram0 rw
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 126492k available (1796k kernel code, 480k data, 112k init, 0k 
highmem)
Calibrating delay loop... 731.13 BogoMIPS (lpj=1462272)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Freeing initrd memory: 637k freed
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
ttyS0: autoconf (0x0000, 0xff600300): .%�..%�6.)&=.type=16550A
serial8250: ttyS0 at MMIO 0x0 (irq = 3) is a 16550A
ttyS1: autoconf (0x0000, 0xff600400): iir=3 iir1=6 iir2=6 type=16550A
serial8250: ttyS1 at MMIO 0x0 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
nbd: registered device at major 43
pcnet32.c:v1.33 27.Jun.2006 tsbogend@alpha.franken.de
pcnet32: PCnet/FAST+ 79C972 at 0x3ffefe0, 00 00 00 00 00 00
    tx_start_pt(0x0c00):~220 bytes, BCR18(9861):BurstWrEn BurstRdEn NoUFlow
    SRAMSIZE=0x0000, SRAM_BND=0x0000, assigned IRQ 22.
eth0: registered as PCnet/FAST+ 79C972
pcnet32: PCnet/FAST+ 79C972 at 0x3ffefc0, 00 00 00 00 00 00
    tx_start_pt(0x0c00):~220 bytes, BCR18(9861):BurstWrEn BurstRdEn NoUFlow
    SRAMSIZE=0x0000, SRAM_BND=0x0000, assigned IRQ 23.
eth1: registered as PCnet/FAST+ 79C972
pcnet32: 2 cards_found.
mice: PS/2 mouse device common for all mice
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@linux.intel.com>
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 112k init
serial8250_interrupt(3)...end.
serial8250_interrupt(3)...end.
serial8250_interrupt(3)...end.
serial8250_interrupt(3)...end.



------=_NextPart_000_22f5_622d_54a2--
