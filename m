Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUBTEQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 23:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267521AbUBTEQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 23:16:47 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:48266 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S267522AbUBTEQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 23:16:41 -0500
Date: Thu, 19 Feb 2004 20:16:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: daniel.schreiber@s1999.tu-chemnitz.de
Subject: [Bug 2154] New: Disconnecting USB Hub with attaced	devices crashes usb subsystem 
Message-ID: <7400000.1077250590@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2154

           Summary: Disconnecting USB Hub with attaced devices crashes usb
                    subsystem
    Kernel Version: 2.6.3
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: daniel.schreiber@s1999.tu-chemnitz.de


Distribution: Debian Sarge 
Hardware Environment:  
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01) 
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI 
bridge (AGP) 
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 
00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller 
(rev 07) 
00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller 
(rev 07) 
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) 
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound 
Controller (rev a0) 
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 90) 
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02) 
00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 02) 
00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
02) 
00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 
[FasterNet] (rev 22) 
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) 
 
USB setup: 
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3 
B:  Alloc= 11/900 us ( 1%), #Int=  2, #Iso=  0 
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1 
P:  Vendor=0000 ProdID=0000 Rev= 2.06 
S:  Manufacturer=Linux 2.6.1 ohci_hcd 
S:  Product=OHCI Host Controller 
S:  SerialNumber=0000:00:02.3 
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA 
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub 
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms 
 
T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 5 
D:  Ver= 1.00 Cls=09(hub  ) Sub=01 Prot=00 MxPS= 8 #Cfgs=  1 
P:  Vendor=0698 ProdID=9999 Rev= 0.01 
C:* #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA 
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=01 Prot=00 Driver=hub 
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=32ms 
 
T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0 
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1 
P:  Vendor=0698 ProdID=1786 Rev= 0.01 
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA 
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=hid 
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=16ms 
 
T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=02 Dev#=  4 Spd=1.5 MxCh= 0 
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1 
P:  Vendor=046d ProdID=c00e Rev=11.10 
S:  Manufacturer=Logitech 
S:  Product=USB-PS/2 Optical Mouse 
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 98mA 
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid 
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms 
 
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3 
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0 
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1 
P:  Vendor=0000 ProdID=0000 Rev= 2.06 
S:  Manufacturer=Linux 2.6.1 ohci_hcd 
S:  Product=OHCI Host Controller 
S:  SerialNumber=0000:00:02.2 
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA 
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub 
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms 
 
Software Environment: 
modprobe --version 
module-init-tools version 3.0-pre9 
gcc --version 
gcc (GCC) 3.3.3 20040125 (prerelease) (Debian) 
ld --version 
GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux 
 
Problem Description: 
Feb 19 21:45:59 ws kernel: Unable to handle kernel paging request at virtual 
address e084 
70c0 
Feb 19 21:45:59 ws kernel:  printing eip: 
Feb 19 21:45:59 ws kernel: e0841eb9 
Feb 19 21:45:59 ws kernel: *pde = 1fe68067 
Feb 19 21:45:59 ws kernel: *pte = 00000000 
Feb 19 21:45:59 ws kernel: Oops: 0002 [#1] 
Feb 19 21:45:59 ws kernel: CPU:    0 
Feb 19 21:45:59 ws kernel: EIP:    0060:[__crc_usb_init_urb+1582051/1955062]    
Not taint 
ed 
Feb 19 21:45:59 ws kernel: EFLAGS: 00010296 
Feb 19 21:45:59 ws kernel: EIP is at hiddev_cleanup+0x29/0x40 [hid] 
Feb 19 21:45:59 ws kernel: eax: 00000060   ebx: df7c8000   ecx: c035eaa0   edx: 
c035eab4 
Feb 19 21:45:59 ws kernel: esi: e0846ae0   edi: dfd95200   ebp: dfd95224   esp: 
dfe91e88 
Feb 19 21:45:59 ws kernel: ds: 007b   es: 007b   ss: 0068 
Feb 19 21:45:59 ws kernel: Process khubd (pid: 5, threadinfo=dfe90000 
task=dffa0040) 
Feb 19 21:45:59 ws kernel: Stack: df8564dc e0846bd8 df7c8000 e0841922 df8564c0 
dfd95200 d 
fe01180 c022c51b 
Feb 19 21:45:59 ws kernel:        dfe01180 dfe01180 dfbd2980 dfe01194 e0846b00 
c02005d4 d 
fe01194 dfe011bc 
Feb 19 21:45:59 ws kernel:        dfe01194 dfd952cc c0200705 dfe01194 dfe011ec 
dfe01194 d 
fd952cc c01ff66d 
Feb 19 21:45:59 ws kernel: Call Trace: 
Feb 19 21:45:59 ws kernel:  [__crc_usb_init_urb+1580620/1955062] 
hid_disconnect+0xb2/0xd0 [hid] 
Feb 19 21:45:59 ws kernel:  [usb_unbind_interface+123/128] 
usb_unbind_interface+0x7b/0x80 
Feb 19 21:45:59 ws kernel:  [device_release_driver+100/112] 
device_release_driver+0x64/0x 
 
Steps to reproduce: 
 
disconnect and reconnect USB hub serveral times


