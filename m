Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbRHFJTN>; Mon, 6 Aug 2001 05:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267635AbRHFJTD>; Mon, 6 Aug 2001 05:19:03 -0400
Received: from protactinium.btinternet.com ([194.73.73.176]:5582 "EHLO
	protactinium") by vger.kernel.org with ESMTP id <S267621AbRHFJSv>;
	Mon, 6 Aug 2001 05:18:51 -0400
Reply-To: <lar@cs.york.ac.uk>
From: "Laramie Leavitt" <laramie.leavitt@btinternet.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.7 Oops in SMP kernel with multiple video cards.
Date: Mon, 6 Aug 2001 10:24:28 +0100
Message-ID: <000901c11e59$984b0320$47357ad5@hayholt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I consistently get an oops when compiling Linux 2.4.7 for SMP on
a MSI 694D motherboard, PIII 866 cpus, 256MB ram.

I suspect that it has something to do with multiple video devices,
but am not certain.  Perhaps someone can look at the oops.

The oops happens as the other CPU is loading the serial port & NTFS
drivers.
I have basically removed everything from the config that is not
critical.

The install is a slackware 8.0, and the slackware provided 2.4.5 kernel 
(not SMP) boots fine.  From looking at the oops it appears to be in
vga_con_cursor.

*pde = 00000000
CPU: 1
EIP: 0010:[<00000018>]
EFLAGS: 00010246
EAX: 00000000
EBX: c01051d0
ECX: c1458000
EDX: c1458000
ESI: c1458000
EDI: c01051d0
EBP: 00000000
ESP: c1459fb0

Ds: 0018
Es: 0018
Ss: 0018

Process swapper( pid:0, stackpage c1459000 )

Stack: 
[<c0105262>][<00000002>][<00000000>][<00000000>][<c029fa8a>][<c1442000>]
[<c02e7900>]
[<00000000>][<c01d3307>][<00000000>][<0000000d>][<00000000>][<00000000>]
[<00000000>]
[<c0197a6e>][<c1442000>][<00000001>][<c02e790a>][<00000000>][<00000000>]

Call Trace:
[<c0105262>][<c01d3307>][<c019796e>]

Code:Bad EIP value.
Kernel panic: Attempted to kill idle task.


### ver_linux

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux darkstar 2.4.5 #6 Fri Jun 22 01:38:20 PDT 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         ppp_deflate ppp_async ppp_generic slip lp
parport_pc parport

### Summary of lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev
c4) 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3
AGP] (prog-if 00 [Normal decode]) 00:07.0 ISA bridge: VIA Technologies,
Inc. VT82C686 [Apollo Super] (rev 22) 00:07.1 IDE interface: VIA
Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master
SecP PriP]) 00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB
(rev 10) (prog-if 00 [UHCI]) 00:07.3 USB Controller: VIA Technologies,
Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI]) 00:07.4 Host bridge: VIA
Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30) 00:07.5
Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo
Super AC97/Audio] (rev 20) 00:0c.0 RAID bus controller: Promise
Technology, Inc.: Unknown device 0d30 (rev 02) 00:0e.0 Communication
controller: CONEXANT PCI Modem Enumerator (rev 08) 00:0f.0 Multimedia
audio controller: Yamaha Corporation YMF-724F [DS-1 Audio Controller]
(rev 03) 00:12.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27) (prog-if 00 [VGA]) 01:00.0 VGA compatible controller: nVidia
Corporation Riva TnT2 [NV5] (rev 11) (prog-if 00 [VGA])

