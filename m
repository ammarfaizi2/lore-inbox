Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWJLVui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWJLVui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWJLVuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:50:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:26207 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751139AbWJLVuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:50:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ls/V1kfS+9Z2MzqVeuF4E5hwTvaoCa2WAJn19JZb6gQM5rmCaiYGRZcytYBsr1EWZscpoN/11bj/10aF1p+TPSWYZYdPZOpU86NDMWSwLS6BU7apepWR/HuNwKpBteeABMCgYCjg4bcQ8OyVzziv7sCX4RYWvqztXOcZytc6C+k=
Message-ID: <28bb77d30610121450n6cfd9c6ejd6b0370d2400a378@mail.gmail.com>
Date: Thu, 12 Oct 2006 14:50:33 -0700
From: "Steven Truong" <midair77@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kdump/kexec/crash on vmcore file
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all.  This is my first attempt to troubleshoot a kernel panic so I
am quite newbie in this area. I have been able to obtain a kdump when
my box had kernel panic.

I set up Kdump and Kexec and then the captured/crash kernel to boot
into Level 1 and then copy /proc/vmcore file to the disk for later
analysis.  However, after the server booted back to Level 3 and I
utilized the crash command to analyzed the vmcore file.  I got error
message:

./crash /boot/vmlinux ../vmcore.test


crash: read error: kernel virtual address: ffffffff8123d1e0  type:
"kernel_config_data"
WARNING: cannot read kernel_config_data
crash: read error: kernel virtual address: ffffffff813b5180  type: "xtime"

I installed the lastest crash software 4.0-3.6.   I googled left and
right but nothing has turned up useful.

Thank you for all the helps and hints.

My box is dual Xeon 3.2 GHz, 4 GBs of PC2700 DDR2 and run CentOS 4.3
with kernel

Linux node30 2.6.18 #1 SMP Mon Oct 9 14:42:15 PDT 2006 x86_64 x86_64
x86_64 GNU/Linux

lspci
00:00.0 Host bridge: Intel Corporation E7320 Memory Controller Hub (rev 0c)
00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express
Port A (rev 0c)
00:03.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express
Port A1 (rev 0c)
00:1c.0 PCI bridge: Intel Corporation 6300ESB 64-bit PCI-X Bridge (rev 02)
00:1d.0 USB Controller: Intel Corporation 6300ESB USB Universal Host
Controller (rev 02)
00:1d.1 USB Controller: Intel Corporation 6300ESB USB Universal Host
Controller (rev 02)
00:1d.4 System peripheral: Intel Corporation 6300ESB Watchdog Timer (rev 02)
00:1d.5 PIC: Intel Corporation 6300ESB I/O Advanced Programmable
Interrupt Controller (rev 02)
00:1d.7 USB Controller: Intel Corporation 6300ESB USB2 Enhanced Host
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 0a)
00:1f.0 ISA bridge: Intel Corporation 6300ESB LPC Interface Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 6300ESB SATA Storage
Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 6300ESB SMBus Controller (rev 02)
01:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI
Bridge A (rev 09)
01:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI
Bridge B (rev 09)
05:01.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit
Ethernet Controller (rev 05)
05:02.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit
Ethernet Controller (rev 05)
06:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)


cat /proc/meminfo
MemTotal:      4042508 kB
MemFree:       3533972 kB
Buffers:         50236 kB
Cached:         374388 kB
SwapCached:          0 kB
Active:         154168 kB
Inactive:       276496 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      4042508 kB
LowFree:       3533972 kB
SwapTotal:     5742364 kB
SwapFree:      5742364 kB
Dirty:              80 kB
Writeback:           0 kB
AnonPages:        5868 kB
Mapped:           4020 kB
Slab:            57212 kB
PageTables:        904 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   7763616 kB
Committed_AS:    19128 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      3208 kB
VmallocChunk: 34359734915 kB
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
Hugepagesize:     2048 kB

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3200.198
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall
lm constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6405.21
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3200.198
cache size      : 2048 KB
physical id     : 3
siblings        : 2
core id         : 0
cpu cores       : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall
lm constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6400.80
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3200.198
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall
lm constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6400.98
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3200.198
cache size      : 2048 KB
physical id     : 3
siblings        : 2
core id         : 0
cpu cores       : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall
lm constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6400.80
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:
