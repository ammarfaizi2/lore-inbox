Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267545AbUIGFMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267545AbUIGFMQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 01:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUIGFMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 01:12:16 -0400
Received: from ns2.rdsct.ro ([212.93.137.18]:46805 "EHLO rdsct.ro")
	by vger.kernel.org with ESMTP id S267545AbUIGFMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 01:12:12 -0400
Message-ID: <001201c4949a$cf067d80$0302a8c0@me>
From: "Adrian" <ccsfn.noc@rdsct.ro>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.6.8.1 - irq7: nobody cared!
Date: Tue, 7 Sep 2004 08:23:28 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

whats happening here ? i get these message about once or twice a week.

Sep  7 07:13:00 mylinux kernel: irq 7: nobody cared!
Sep  7 07:13:00 mylinux kernel:  [<c010644a>] __report_bad_irq+0x2a/0x90
Sep  7 07:13:00 mylinux kernel:  [<c010653c>] note_interrupt+0x6c/0xa0
Sep  7 07:13:00 mylinux kernel:  [<c0106820>] do_IRQ+0x130/0x160
Sep  7 07:13:00 mylinux kernel:  [<c0104aec>] common_interrupt+0x18/0x20
Sep  7 07:13:00 mylinux kernel:  [<c01227b0>] __do_softirq+0x30/0x80
Sep  7 07:13:00 mylinux kernel:  [<c0122826>] do_softirq+0x26/0x30
Sep  7 07:13:00 mylinux kernel:  [<c01067fd>] do_IRQ+0x10d/0x160
Sep  7 07:13:00 mylinux kernel:  [<c0104aec>] common_interrupt+0x18/0x20
Sep  7 07:13:00 mylinux kernel:  [<c02a3827>] acpi_processor_idle+0xd2/0x1c4
Sep  7 07:13:00 mylinux kernel:  [<c01020bc>] cpu_idle+0x2c/0x40
Sep  7 07:13:00 mylinux kernel:  [<c0604767>] start_kernel+0x167/0x190
Sep  7 07:13:00 mylinux kernel:  [<c0604380>] unknown_bootoption+0x0/0x160
Sep  7 07:13:00 mylinux kernel: handlers:
Sep  7 07:13:00 mylinux kernel: [<c0288acc>] (acpi_irq+0x0/0x16)
Sep  7 07:13:00 mylinux kernel: Disabling IRQ #7



kernel is 2.6.8.1 from kernel.org, monolithic except for the bttv modules,
recompiled for my system. distribution is fedora core 2 with all yum updates
applied.

/proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 1
cpu MHz         : 700.024
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1384.44


lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
00:10.0 Multimedia video controller: Brooktree Corporation Bt848 Video
Capture (rev 12)
00:11.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M
AGP 2x (rev 64)


i also have an issue with the tv tuner driver going beserk sometimes, ill
post that as another thread.

Adrian.


