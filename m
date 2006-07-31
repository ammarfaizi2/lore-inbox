Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWGaQNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWGaQNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWGaQNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:13:04 -0400
Received: from mail.gmx.net ([213.165.64.21]:45185 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751257AbWGaQND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:13:03 -0400
X-Authenticated: #3093567
Message-ID: <44CE2C0D.5040603@gmx.de>
Date: Mon, 31 Jul 2006 18:13:01 +0200
From: Thomas Ilnseher <illth@gmx.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060621)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: GPL violation
Content-Type: multipart/mixed;
 boundary="------------080505050609060606090405"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080505050609060606090405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

I wanted to inform you about a possible linux kernel GPL violation.

I have bought an ALLNET ALL6250  Network Attached Storage device
some months ago. This device is obviously linux based.

Some days ago, they released the "sources". (do not trust the dates on 
their homepage!)

they can be found here:

http://www.allnet.de/ftp/pub/allnet/nas/all6250/

the files in charge are :

ALL6250_GPL.tgz <http://www.allnet.de/ftp/pub/allnet/nas/all6250/ALL6250_GPL.tgz>  
and
ALL6250_GPL_V1.10.tgz <http://www.allnet.de/ftp/pub/allnet/nas/all6250/ALL6250_GPL_V1.10.tgz>


they both contain a vanilla (!) 2.4.24 kernel archive:

tom:~/NAS/sources> diff -uNr linux-2.4.24/ ALT/NH230/linux-2.4.24/
tom:~/NAS/sources>


where linux-2.4.24 is the vanilla 2.4.24 kernel tree from www.kernel.org.


However, i have managed to get some shell access to that device, and get 
it's dmesg output
(attached to this mail).

this clearly shows that:
the firmware is based upon 2.4.21(as opposed to 2.4.24)
and has some modification to run on that hardware.

i have grepped the linux tree for strings
"Premier Microelectronics Development", "NH230", "NH200" "_gpio" and so on,
but could not find anything.

I am pretty much pissed off now as that mans i still can't upgrade the 
box to support NFS :(

sincerly,

Thomas Ilnseher

PS: I'm not signed up to the LKML, so please CC me.




--------------080505050609060606090405
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.21 (andy@MARS-V) (gcc version 3.2.3) #1 Fri Nov 11 14:03:24 CST 2005
Motorola  PMC8241
PORTING  by  Premier Microelectronics Development
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ethaddr=00:08:54:E1:78:0D

 sizeof(OpenPIC_Reg)=16
OpenPIC Version 1.2 (1 CPUs and 138 IRQ sources) at fc040000
Decrementer frequency = 133.000000 MHz
Warning: real time clock seems stuck!
Calibrating delay loop... 176.94 BogoMIPS
Memory: 61172k available (1704k kernel code, 960k data, 248k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page cache: 64MB memory, maximum pages = 5120, maximum inactive pages = 300
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
NTFS driver v1.1.22 [Flags: R/O]
NH230_gpio: NH200 GPIO setting ...
Trying to free free IRQ20
NH230_gpio: Get the IRQ SUCCESS !!
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0xfc004500 (irq = 137) is a ST16650
RTC: character device (/dev/rtc) driver v1.00 (01/22/2005) is registered
PCF8563 Real-Time Clock Driver, $Revision: 1.15 $
PCF8563: RTC Voltage Low - reliable date/time information is no longer guaranteed!
PCF8563: RTC Voltage Low - try to set date/timeto default 2005/01/01 12:00:00
RAMDISK driver initialized: 16 RAM disks of 193840K size 1024 blocksize
loop: loaded (max 8 devices)
RTL8169s/8110s: RTL8169S: NAPI enabled
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169s/8110s Gigabit Ethernet driver 2.2-R5 (09/05/2005) at 0xc5000e00, 00:08:54:e1:78:0d, IRQ 17
eth0: Auto-negotiation Enabled.
eth0: 100Mbps Full-duplex operation.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
IT8211: IDE controller at PCI slot 00:10.0
IT8211: chipset revision 17
IT8211: not 100% native mode: will probe irqs later
IT8212: wait 8 seconds for hard disk ready before initialize IT8212 after cold boot.
........ Done
    ide0: BM-DMA at 0xbffdd0-0xbffdd7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xbffdd8-0xbffddf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP1614N, ATA DISK drive
blk: queue c02d3800, I/O limit 4095Mb (mask 0xffffffff)
Probing IDE interface ide1...
ide0 at 0xbffdf8-0xbffdff,0xbffdf6 on irq 18
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
SCSI subsystem driver Revision: 1.00
physmap flash device: 400000 at ffc00000
 Amd/Fujitsu Extended Query Table v1.1 at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling fast programming due to code brokenness.
Using physmap partition definition
Creating 8 MTD partitions on "Physically mapped flash":
0x00300000-0x00320000 : "Boot-loader"
0x00000000-0x00004000 : "Boot CFG"
0x00004000-0x00006000 : "POST Result"
0x00008000-0x00010000 : "Linux CFG"
0x00006000-0x00008000 : "Reserved"
0x00010000-0x00190000 : "Linux"
0x00190000-0x00300000 : "RAM disk #2"
0x00320000-0x00400000 : "RAM disk #1 (root)"
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
ehci_hcd 00:0e.3: PCI device 17a0:8084
ehci_hcd 00:0e.3: irq 19, pci mem c5004f00
usb.c: new USB bus registered, assigned bus number 1
PCI: 00:0e.3 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:0e.3 PCI cache line size corrected to 32.
ehci_hcd 00:0e.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: $Revision: 1.275 $ time 14:05:35 Nov 11 2005
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: USB UHCI at I/O 0xbfffe0, IRQ 19
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver usblp
printer.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 677k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 248k init
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding Swap: 538168k swap-space (priority -1)


--------------080505050609060606090405--
