Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSHJRRj>; Sat, 10 Aug 2002 13:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317081AbSHJRRj>; Sat, 10 Aug 2002 13:17:39 -0400
Received: from dhcp-209-54-74-154.ct.dsl.ntplx.com ([209.54.74.154]:20242 "EHLO
	www.themodelinggroup.com") by vger.kernel.org with ESMTP
	id <S317078AbSHJRRi>; Sat, 10 Aug 2002 13:17:38 -0400
Message-ID: <000b01c24092$d0d0c160$63c8a8c0@arunachal>
From: "Nilanjan Bhowmik" <nilu@iomachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.19: Tulip network card does not sync with Dumb 10/100 Linksys 8 port Etherfast switch
Date: Sat, 10 Aug 2002 13:24:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happend on a working machine. After I have upgraded to 2.4.19, tulip
driver
will not work.  Only way to sync it is loading the driver couple of times
and that too
it will sync at 10/half.

This is working fine with the 2.4.7-10 stock redhat kernel.

Unfortunately I can't get into the server with 2.4.19 running so I have
gathered this while 2.4.7-10.
I can reproduce this every time. So, if you want me to run a test etc. I
can.

nilu@calculator.nilu.net-4->lspci
00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge (rev
03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
00:0e.0 Bridge: PLX Technology, Inc. PCI <-> IOBus Bridge (rev 02)
00:0f.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W
[Millennium II]
00:10.0 Ethernet controller: Lite-On Communications Inc LNE100TX [Linksys
EtherFast 10/100] (rev 25)

nilu@calculator.nilu.net-5->cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
02e8-02ef : serial(auto)
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
1000-100f : Intel Corporation 82371AB PIIX4 IDE
  1000-1007 : ide0
  1008-100f : ide1
1020-103f : Intel Corporation 82371AB PIIX4 USB
  1020-103f : usb-uhci
1080-10ff : PLX Tech
nology, Inc. PCI <-> IOBus Bridge
1400-14ff : Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100]
  1400-14ff : tulip
7000-701f : Intel Corporation 82371AB PIIX4 ACPI
8000-803f : Intel Corporation 82371AB PIIX4 ACPI

Module                  Size  Used by
nfsd                   70720   8 (autoclean)
lockd                  52880   1 (autoclean) [nfsd]
sunrpc                 64688   1 (autoclean) [nfsd lockd]
parport_pc             14768   1 (autoclean)
lp                      6416   0 (autoclean)
parport                25600   1 (autoclean) [parport_pc lp]
autofs                 11520   0 (autoclean) (unused)
tulip                  39232   1
usb-uhci               21536   0 (unused)
usbcore                51712   1 [usb-uhci]
ext3                   64624   4
jbd                    40992   4 [ext3]


Linux calculator.nilu.net 2.4.7-10 #1 Thu Sep 6 17:27:27 EDT 2001 i686
unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         nfsd lockd sunrpc parport_pc lp parport autofs tulip
usb-uhci usbcore ext3 jbd




