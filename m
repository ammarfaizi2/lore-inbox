Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUIGFjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUIGFjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 01:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267565AbUIGFjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 01:39:23 -0400
Received: from fmr05.intel.com ([134.134.136.6]:62892 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267556AbUIGFjP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 01:39:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: kernel 2.6.8.1 - irq7: nobody cared!
Date: Tue, 7 Sep 2004 13:39:09 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305751202C8@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel 2.6.8.1 - irq7: nobody cared!
Thread-Index: AcSUmXLc6RI0YwtkR86Dzrd3jvp1vgAAo7BQ
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Adrian" <ccsfn.noc@rdsct.ro>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Sep 2004 05:39:10.0553 (UTC) FILETIME=[00177490:01C4949D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sounds like ACPI bug. Could you send me the output of 'cat
/proc/acpi/processor/CPU0/power'? IS your acpi interrupt 7?

Thanks,
Shaohua

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Adrian
>Sent: Tuesday, September 07, 2004 1:23 PM
>To: linux-kernel@vger.kernel.org
>Subject: kernel 2.6.8.1 - irq7: nobody cared!
>
>whats happening here ? i get these message about once or twice a week.
>
>Sep  7 07:13:00 mylinux kernel: irq 7: nobody cared!
>Sep  7 07:13:00 mylinux kernel:  [<c010644a>]
__report_bad_irq+0x2a/0x90
>Sep  7 07:13:00 mylinux kernel:  [<c010653c>] note_interrupt+0x6c/0xa0
>Sep  7 07:13:00 mylinux kernel:  [<c0106820>] do_IRQ+0x130/0x160
>Sep  7 07:13:00 mylinux kernel:  [<c0104aec>]
common_interrupt+0x18/0x20
>Sep  7 07:13:00 mylinux kernel:  [<c01227b0>] __do_softirq+0x30/0x80
>Sep  7 07:13:00 mylinux kernel:  [<c0122826>] do_softirq+0x26/0x30
>Sep  7 07:13:00 mylinux kernel:  [<c01067fd>] do_IRQ+0x10d/0x160
>Sep  7 07:13:00 mylinux kernel:  [<c0104aec>]
common_interrupt+0x18/0x20
>Sep  7 07:13:00 mylinux kernel:  [<c02a3827>]
>acpi_processor_idle+0xd2/0x1c4
>Sep  7 07:13:00 mylinux kernel:  [<c01020bc>] cpu_idle+0x2c/0x40
>Sep  7 07:13:00 mylinux kernel:  [<c0604767>] start_kernel+0x167/0x190
>Sep  7 07:13:00 mylinux kernel:  [<c0604380>]
unknown_bootoption+0x0/0x160
>Sep  7 07:13:00 mylinux kernel: handlers:
>Sep  7 07:13:00 mylinux kernel: [<c0288acc>] (acpi_irq+0x0/0x16)
>Sep  7 07:13:00 mylinux kernel: Disabling IRQ #7
>
>
>
>kernel is 2.6.8.1 from kernel.org, monolithic except for the bttv
modules,
>recompiled for my system. distribution is fedora core 2 with all yum
>updates
>applied.
>
>/proc/cpuinfo
>processor       : 0
>vendor_id       : AuthenticAMD
>cpu family      : 6
>model           : 3
>model name      : AMD Duron(tm) Processor
>stepping        : 1
>cpu MHz         : 700.024
>cache size      : 64 KB
>fdiv_bug        : no
>hlt_bug         : no
>f00f_bug        : no
>coma_bug        : no
>fpu             : yes
>fpu_exception   : yes
>cpuid level     : 1
>wp              : yes
>flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca
>cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
>bogomips        : 1384.44
>
>
>lspci
>00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev
>03)
>00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133
AGP]
>00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
South]
>(rev 22)
>00:07.1 IDE interface: VIA Technologies, Inc.
>VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10)
>00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
>00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
>RTL-8139/8139C/8139C+ (rev 10)
>00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
>RTL-8139/8139C/8139C+ (rev 10)
>00:10.0 Multimedia video controller: Brooktree Corporation Bt848 Video
>Capture (rev 12)
>00:11.0 Multimedia audio controller: C-Media Electronics Inc CM8738
(rev 10)
>01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility
P/M
>AGP 2x (rev 64)
>
>
>i also have an issue with the tv tuner driver going beserk sometimes,
ill
>post that as another thread.
>
>Adrian.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
