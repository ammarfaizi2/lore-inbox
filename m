Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271431AbRIJR1Y>; Mon, 10 Sep 2001 13:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271467AbRIJR1P>; Mon, 10 Sep 2001 13:27:15 -0400
Received: from ns1.openratings.com ([64.55.77.195]:26867 "EHLO
	exchange.hq.openratings.com") by vger.kernel.org with ESMTP
	id <S271431AbRIJR04>; Mon, 10 Sep 2001 13:26:56 -0400
Message-ID: <4A46E75D51A2D5119F2A00B0D03D7F09018D@exchange.hq.openratings.com>
From: Paul Hamm <paulhamm@OpenRatings.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic: Aiee, Killing Interupt Handler, Process kpnpbios
Date: Mon, 10 Sep 2001 13:27:17 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PC hard crashes with a GPF 0000.  Leaves no log on the error.

Default RedHat roswell install
PC is a Dell GX110 w/ i810 chipset integrated audio/video/networking with 1
additional 3com 3c905b installed

>more /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 730.971
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mm
x fxsr sse
bogomips        : 1458.17

>more /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  128176128 120569856  7606272    28672  6221824 35848192
Swap: 534601728 21389312 513212416
MemTotal:       125172 kB
MemFree:          7428 kB
MemShared:          28 kB
Buffers:          6076 kB
Cached:          18084 kB
SwapCached:      16924 kB
Active:          11552 kB
Inact_dirty:     28640 kB
Inact_clean:       920 kB
Inact_target:    32428 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       125172 kB
LowFree:          7428 kB
SwapTotal:      522072 kB
SwapFree:       501184 kB
NrSwapPages:    125296 pages

>uname -a
Linux xxxxx 2.4.6-3.1 #1 Tue Jul 24 14:54:56 EDT 2001 i686 unknown

The complete screen of the error is below, there is one error in the second
block of the STACK info.  Had to hand write it and did not notice until I
typed it out.

General Protection Fault 0000
CPU: 0
EIP: 0010:[<c01d2acd>]
EFLAGS: 00010282
EAX:00000006	EBX: c4b9392c	ECX: 00000006	EDX: 000000d8
ESI: c1847012	EDI: c4100c68	EBP: c1847012	ESP: c7e912e50
DS: 0018	ES: 0078	SS: 0018
Process kpnpbios (PID: 2, STACKPAGE=c7e9f000)
STACK:	c4b9392c	04000001	c4100c00	000000e6
c8883265	c4b9392c	c4100c00	0000001f
	000080e6	0000ec00	00000015	c4100d40
c3052000	00000800	c30527ff	00000246
	c5eec794	04000001	00000005	0000e401
c88829af	c4100c00	c4100c00	00000020
CALL TRACE:	[<c8883265>]	[<88829af>]	[<c010851a>]	[<c0108698>]
[<c0218eba>]  <<<<< (missing 1 digit on second block)
	[<c0130078>]	[<cb680018>]	[<c01b3fef?]	[<c0116390>]
[<c01b41f3>]
	[<c0105000>]

	[<c01056e6>]	[<c01b4180>]

Code	f3 a6 0f 92 c0 0f 97 c2 38 c2 0f 95 c0 fe c0 88 43 6a eb

<0> Kernel Panic: Aiee, Killing Interupt Handler
	In Interupt Handler - Not Syncing

We disabled the integrated audio in bios.  Other than that is is a stock.
The PC crashes about once a day with this error.  Let me know if there is
anything else that is needed, as this is my first post.  Also no useful log
data.  Just happily chugging along and the syslog restarting after a manual
reset.  Yes it will be posted to RedHat.

Paul Hamm
Manager  Technical Services
Open Ratings Inc
617-582-5124
www.openratings.com

