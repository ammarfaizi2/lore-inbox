Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129274AbRA2Utq>; Mon, 29 Jan 2001 15:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129175AbRA2Utg>; Mon, 29 Jan 2001 15:49:36 -0500
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:63736 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S129274AbRA2UtY>; Mon, 29 Jan 2001 15:49:24 -0500
Message-ID: <3A75D74C.949FAAF0@bigfoot.com>
Date: Mon, 29 Jan 2001 12:49:16 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18RAID+IDE i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: via82cxxx.c,v 3.17 + 2.2.18 errors
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is via82cxxx.c v3.17 a 2.4.x only patch or did I miss something else?

[tim@asus linux]# ../build
dep =======================
clean =======================
bzImage =======================
via82cxxx.c:108: `PCI_DEVICE_ID_VIA_8233_0' undeclared here (not in a
function)
via82cxxx.c:108: initializer element for `via_isa_bridges[0].id' is not
constant
via82cxxx.c:114: `PCI_DEVICE_ID_VIA_82C596' undeclared here (not in a
function)
via82cxxx.c:114: initializer element for `via_isa_bridges[6].id' is not
constant
via82cxxx.c:115: `PCI_DEVICE_ID_VIA_82C596' undeclared here (not in a
function)
via82cxxx.c:115: initializer element for `via_isa_bridges[7].id' is not
constant
via82cxxx.c:116: `PCI_DEVICE_ID_VIA_82C596' undeclared here (not in a
function)
via82cxxx.c:116: initializer element for `via_isa_bridges[8].id' is not
constant
via82cxxx.c: In function `pci_init_via82cxxx':
via82cxxx.c:486: warning: implicit declaration of function
`pci_resource_flags'
via82cxxx.c:486: `IORESOURCE_IO' undeclared (first use in this function)
via82cxxx.c:486: (Each undeclared identifier is reported only once
via82cxxx.c:486: for each function it appears in.)
via82cxxx.c:489: warning: implicit declaration of function
`pci_resource_start'
make[3]: *** [via82cxxx.o] Error 1
make[2]: *** [first_rule] Error 2
make[1]: *** [_subdir_block] Error 2
make: *** [_dir_drivers] Error 2
make: *** Waiting for unfinished jobs....
Command exited with non-zero status 2

[tim@asus linux]# grep Id drivers/block/{via*.c,ide-timing.h}
drivers/block/via82cxxx.c: * $Id: via82cxxx.c,v 3.17 2001/01/19 16:45:60
vojtech Exp $
drivers/block/ide-timing.h: * $Id: ide-timing.h,v 1.5 2001/01/15
21:48:56 vojtech Exp $

[tim@asus 2.2]# cat /proc/version
Linux version 2.2.18RAID+IDE (root@asus) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #9 Fri Jan 26 14:16:15 PST 2001
Note: pristine + ide.2.2.18.1221 + raid-2.2.18-B0

[tim@asus 2.2]# lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0391 (rev
02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8391
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
00:09.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23 OHCI Compliant
IEEE-1394 Controller
00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
00:0f.0 RAID bus controller: Promise Technology, Inc. 20246 (rev 01)
00:11.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
01:00.0 VGA compatible controller: nVidia Corporation Riva TNT2 Model 64
(rev 11)
[tim@asus 2.2]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 800.065
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmxext mmx fxsr 3dnowext 3dnow
bogomips        : 1595.80

--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
