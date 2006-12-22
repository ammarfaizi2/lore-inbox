Return-Path: <linux-kernel-owner+w=401wt.eu-S1945949AbWLVFrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945949AbWLVFrf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 00:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945951AbWLVFrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 00:47:35 -0500
Received: from mail.codan.com.au ([202.58.54.81]:44139 "EHLO
	auadlimss01.codan.com.au" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1945949AbWLVFrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 00:47:33 -0500
X-Greylist: delayed 2390 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 00:47:33 EST
Message-ID: <458B6814.9CA1761@codan.com.au>
Date: Fri, 22 Dec 2006 15:37:32 +1030
From: Magdalena Raltcheva <magdalena.raltcheva@codan.com.au>
X-Mailer: Mozilla 4.8 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6 kernel NFS root mount problem
X-MIMETrack: Itemize by SMTP Server on AUADLLNT03/Codan(Release 5.0.11  
	|July 24, 2002) at12/22/2006 03:37:28 PM,Serialize by Router on 
	AUADLLNT03/Codan(Release 5.0.11  |July 24, 2002) at12/22/2006 03:37:28 
	PM,Serialize complete at 12/22/2006 03:37:28 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii
X-imss-version: 2.043
X-imss-result: Passed
X-imss-scanInfo: M:P L:E SM:0
X-imss-tmaseResult: TT:0 TS:0.0000 TC:00 TRN:0 TV:3.6.1039(14888.001)
X-imss-scores: Clean:44.78947 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:4 C:3 M:3 S:3 R:3 (1.0000 1.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm tying to run 2.6.18 kernel on ARM  AT91RM9200DK board with NFS mount
root filesystem.

The printout from the boot is :


Loading:
#################################################################

#################################################################

#################################################################
         #
done
Bytes transferred = 1000118 (f42b6 hex)
## Booting image at 21000000 ...
   Image Name:
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    1000054 Bytes = 976.6 kB
   Load Address: 20008000
   Entry Point:  20008000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

Linux version 2.6.18 (magdar@ibis) () #1 Fri Dec 22 14:45:47 CST 2006
CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0003177
Machine: Atmel AT91RM9200
Memory policy: ECC disabled, Data cache writeback
Clocks: CPU 179 MHz, master 59 MHz, main 18.432 MHz
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
CPU0: D cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
Built 1 zonelists.  Total pages: 8192
Kernel command line: root=/dev/nfs rw
nfsroot=192.168.0.10:/home_own/rootfs ip=192.168.0.12
console=ttyS0,115200 mem=32M
AT91: 128 gpio irqs in 4 banks
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 32MB = 32MB total
Memory: 30292KB available (1824K code, 209K data, 88K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NET: Registered protocol family 2
IP route cache hash table entries: 256 (order: -2, 1024 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 1024 bind 512)
TCP reno registered
NetWinder Floating Point Emulator V0.97 (double precision)
io scheduler noop registered
io scheduler anticipatory registered (default)
AT91 Watchdog Timer enabled (5 seconds, nowayout)
at91_usart.0: ttyS0 at MMIO 0xfefff200 (irq = 1) is a AT91_SERIAL
at91_usart.1: ttyS1 at MMIO 0xfffc4000 (irq = 7) is a AT91_SERIAL
nbd: registered device at major 43
eth0: Link now 100-FullDuplex
eth0: AT91 ethernet at 0xfefbc000 int=24 100-FullDuplex
(12:34:56:78:99:aa)
eth0: Davicom 9161 PHY (Copper)
physmap platform flash device: 00200000 at 10000000
Found: Atmel AT49BV16X
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.

at91_cf: irqs det #64, io #0
usbmon: debugfs is not available
at91_ohci at91_ohci: AT91 OHCI
at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
at91_ohci at91_ohci: irq 23, io mem 0x00300000
usb usb1: Product: AT91 OHCI
usb usb1: Manufacturer: Linux 2.6.18 ohci_hcd
usb usb1: SerialNumber: at91
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
udc: at91_udc version 3 May 2006
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
MMC: 4 wire bus mode not supported by this driver - using 1 wire
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: Link now 100-FullDuplex
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.0.12, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.168.0.12, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=192.168.0.10, rootpath=
Root-NFS: Mounting /home_own/rootfs on server 192.168.0.10 as root
Root-NFS:     rsize = 4096, wsize = 4096, timeo = 0, retrans = 0
Root-NFS:     acreg (min,max) = (3,60), acdir (min,max) = (30,60)
Root-NFS:     nfsd port = -1, mountd port = 0, flags = 00000200
Looking up port of RPC 100003/2 on 192.168.0.10
Root-NFS: Portmapper on server returned 2049 as nfsd port
Looking up port of RPC 100005/1 on 192.168.0.10
Root-NFS: mountd port is 792
NFS:      nfs_mount(c0a8000a:/home_own/rootfs)
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)


As you can see the network and the NFS mount come successful. It fails
when to mount the root. I try to track the problem and it seems fails
when to do_mount the path doesn't exist. The root path is fixed as
"/root" if I change that to "/" it goes further but it fails on console.
The console problem  I think is still related to the root mount being
wrong even it passed with the change I did.

Can anyone help or point out where to look for clues .
