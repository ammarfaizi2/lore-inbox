Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278322AbRJSKJk>; Fri, 19 Oct 2001 06:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278327AbRJSKJb>; Fri, 19 Oct 2001 06:09:31 -0400
Received: from melone.tussy.uni-wh.de ([193.175.79.7]:17670 "EHLO
	melone.tussy.uni-wh.de") by vger.kernel.org with ESMTP
	id <S278322AbRJSKJW>; Fri, 19 Oct 2001 06:09:22 -0400
Message-ID: <3BCFFC6C.4060607@uni-wh.de>
Date: Fri, 19 Oct 2001 12:11:56 +0200
From: "Christoph M. Friedrich" <chris@uni-wh.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with usb-storage and kernelversion> 2.4.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
1. Problems using DataFab MD2 USB external Storage with newer Kernels  and
module usb-storage (works in 2.4.4 no longer works in 2.4.10 and 2.4.12)

Keywords: usb-storage problems with 2.4.10 and later

Iam using module usb-storage to use an external ide-harddisk with ext2
filesystem. The device is mounted via /dev/sda1. With the following 
configuration
it works fine for a longer time:

Working version Info gives:

Linux yucca 2.4.4-4GB #1 Mon Okt 15 16:31:37 CEST 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.29
util-linux             2.11i
mount                  2.11i
modutils               2.4.8
e2fsprogs              1.24a
reiserfsprogs          3.x.0k-pre9
pcmcia-cs              3.1.28
PPP                    2.4.1
isdn4k-utils           3.1pre2
Linux C Library        x    1 root     root      1384168 Sep 20 05:52 
/lib/libc.so.6
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         usb-storage soundcore parport_pc lp parport 
agpgart pcnet_cs 8390 ds yenta_socket pcmcia_core
ipv6 evdev input uhci iptable_nat ip_conntrack iptable_filter ip_tables 
nls_iso8859-1 nls_cp437 reiserfs usbcore


output of /proc/bus/usb/devices is:

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=e800
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  4 Spd=12  MxCh= 0D: 
Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=07c4 ProdID=0103 Rev= 9.04
S:  Manufacturer=OnSpec Electronic, Inc.
S:  Product=USB Disk
S:  SerialNumber=B250F15150
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms


After upgrading to 2.4.10 or 2.4.12, it no longer works and breaks with 
problems
accessing /dev/sda1

Version Info is:


Linux yucca 2.4.12 #6 Mon Okt 15 15:06:05 CEST 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.29
util-linux             2.11i
mount                  2.11i
modutils               2.4.8
e2fsprogs              1.24a
reiserfsprogs          3.x.0k-pre9
pcmcia-cs              3.1.28
PPP                    2.4.1
isdn4k-utils           3.1pre2
Linux C Library        x    1 root     root      1384168 Sep 20 05:52 
/lib/libc.so.6
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         usb-storage soundcore parport_pc lp parport 
agpgart pcnet_cs 8390 ds yenta_socket pcmcia_core
ipv6 evdev input uhci iptable_nat ip_conntrack iptable_filter ip_tables 
nls_iso8859-1 nls_cp437 reiserfs usbcore

/proc/bus/usb/devices is:

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=e800C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=07c4 ProdID=0103 Rev= 9.04
S:  Manufacturer=OnSpec Electronic, Inc.
S:  Product=USB Disk
S:  SerialNumber=B250F15150
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms


/var/log/messages gives:


Oct 15 18:22:30 yucca kernel: hub.c: USB new device connect on bus1/1, 
assigned device number 2
Oct 15 18:22:30 yucca kernel: usb.c: USB device 2 (vend/prod 
0x7c4/0x103) is not claimed by any active driver.
Oct 15 18:22:31 yucca kernel: Initializing USB Mass Storage driver...
Oct 15 18:22:31 yucca kernel: usb.c: registered new driver usb-storage
Oct 15 18:22:31 yucca kernel: scsi0 : SCSI emulation for USB Mass 
Storage devices
Oct 15 18:22:31 yucca kernel:   Vendor:           Model: 
    Rev:
Oct 15 18:22:31 yucca kernel:   Type:   Direct-Access 
    ANSI SCSI revision: 02
Oct 15 18:22:31 yucca kernel: Attached scsi removable disk sda at scsi0, 
channel 0, id 0, lun 0
Oct 15 18:22:31 yucca kernel: SCSI device sda: 39070081 512-byte hdwr 
sectors (20004 MB)
Oct 15 18:22:31 yucca kernel: sda: Write Protect is off
Oct 15 18:22:31 yucca kernel:  sda: sda1
Oct 15 18:22:31 yucca kernel: WARNING: USB Mass Storage data integrity 
not assured
Oct 15 18:22:31 yucca kernel: USB Mass Storage device found at 2
Oct 15 18:22:31 yucca kernel: USB Mass Storage support registered.
Oct 15 18:22:31 yucca insmod: Using 
/lib/modules/2.4.12/kernel/drivers/usb/storage/usb-storage.o
Oct 15 18:22:31 yucca insmod: Symbol version prefix ''
Oct 15 18:23:05 yucca kernel: scsi: device set offline - not ready or 
command retry failed after bus reset: host 0 channel 0 id 0 lun 0
Oct 15 18:23:05 yucca kernel:  I/O error: dev 08:01, sector 0


fsck /dev/sda1 will result in:

fsck.ext2: Attempt to read block from filesystem resulted in short read 
while
trying to open /dev/sda1
Could this be a zero-length partition?


Any hints?

Thanks in Advance
  Chris


