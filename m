Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbTGOMqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267590AbTGOMlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:41:42 -0400
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:38921 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id S267563AbTGOMcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:32:01 -0400
Date: Tue, 15 Jul 2003 13:49:20 +0100
From: Adam Langley <agl@imperialviolet.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 panic output in bio_end_io_pagebuf
Message-ID: <20030715124920.GA13611@linuxpower.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Mailer: Why do *you* want to know??
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The system was running X and under pretty heavy load (basically, a 
fork bomb). I had to copy the panic off the screen so there may be
a couple of typos. I still have the build tree here, but the critical
files are at http://csgsoft.doc.ic.ac.uk/2.6.0-test1. If anyone has
any questions please mail me directly.

EIP:	0060:[<c026b78c>]	Not tainted
EFLAGS:	00210002
EIP is at bio_end_io_pagebuf+0xce/0x133
eax:	00000001	ebx: c83fdd80	ecx: c0dccc00	edx: c109d5f8
esi:	cffbe780	edi: 00000000	ebp: ccdb1ea8	esp: ccdb1e84
ds:	007b		es:  007b	ss:  0068
Process gdmgreeter (pid: 2338, threadinfo=ccdb0000 task=ccac8100)
Stack:	c750d000 00000400 00000008 c750d000 00000009 00001000 c0dccc00 00000000
	c0607bec ccdb1ec8 c01506c1 c0dccc00 00002000 00000000 00000000 00002000
	c0dccc00 ccdb1f04 c031b9ff c0dccc00 00002000 00000000 00000001 c0dccc00
Call Trace:
 [<c01506c1>] bio_endio+0x55/0x7a
 [<c031b9ff>] __end_that_request_first+0x1f1/0x20d
 [<c0348f93>] ide_end_request+0x63/0x13d
 [<c0354d77>] multwrite_intr+0xda/0xdc
 [<c034a7fe>] ide_intr+0x100/0x1ac
 [<c0354c9d>] multwrite_intr+0x0/0xdc
 [<c010a9ad>] handle_IRQ_event+0x39/0x62
 [<c010ace1>] do_IRQ+0x9f/0x14d
 [<c0109378>] common_interrupt+0x18/0x20
 
Code: 0f 0b 0b 05 04 fc 49 c0 eb a4 89 d0 e8 62 53 ec ff eb 9b 81
 <0>Kernel panic: Fatal.....

*** cpuinfo ***

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 799.956
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1572.86

*** meminfo ***

MemTotal:       253984 kB
MemFree:        124948 kB
Buffers:          7076 kB
Cached:          82100 kB
SwapCached:          0 kB
Active:          48640 kB
Inactive:        61980 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       253984 kB
LowFree:        124948 kB
SwapTotal:      255952 kB
SwapFree:       255952 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          32260 kB
Slab:            15880 kB
Committed_AS:    27724 kB
PageTables:        480 kB
VmallocTotal:   778204 kB
VmallocUsed:       492 kB
VmallocChunk:   777712 kB

*** lspci ***

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
00:04.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
AC97 Audio Controller (rev 20)
00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 04)

-- 
Adam Langley                                      agl@imperialviolet.org
http://www.imperialviolet.org                       (+44) (0)7906 332512
PGP: 9113   256A   CC0F   71A6   4C84   5087   CDA5   52DF   2CB6   3D60
