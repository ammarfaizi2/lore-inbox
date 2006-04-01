Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWDASLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWDASLU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 13:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWDASLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 13:11:20 -0500
Received: from bay110-f25.bay110.hotmail.com ([65.54.229.35]:58764 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751593AbWDASLU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 13:11:20 -0500
Message-ID: <BAY110-F25D3E7350EA99B3B40F1C9FFD70@phx.gbl>
X-Originating-IP: [80.108.9.40]
X-Originating-Email: [blue_fox33@hotmail.com]
From: "Blue Fox" <blue_fox33@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: make menuconfig fails under 2.6.16 
Date: Sat, 01 Apr 2006 20:11:18 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 01 Apr 2006 18:11:19.0971 (UTC) FILETIME=[AD316730:01C655B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.] One line summary of the problem:
make menuconfig does not work under linux 2.6.16. Build failed.

[2.] Full description of the problem/report:
Trying to make menuconfig with ncurses on linux 2.6.15.5 fails.

[3.] Keywords (i.e., modules, networking, kernel):
scripts lxdialog
[4.] Kernel version (from /proc/version):
Linux version 2.6.15.5-ybi (root@raven) (gcc version 4.0.2) #1 PREEMPT Sat   
     17:23:44 CET 2006

[5.] Output of Oops.. message (if applicable) with symbolic information

HOSTLD  scripts/kconfig/lxdialog/lxdialog
scripts/kconfig/lxdialog/checklist.o: In function 
`print_item':checklist.c:(.text+0x64): undefined reference to `wmove'
:checklist.c:(.text+0x88): undefined reference to `wmove'
:checklist.c:(.text+0xc0): undefined reference to `wprintw'
:checklist.c:(.text+0xe4): undefined reference to `wmove'
:checklist.c:(.text+0xf8): undefined reference to `waddch'
:checklist.c:(.text+0x118): undefined reference to `waddnstr'
:checklist.c:(.text+0x130): undefined reference to `wmove'
:checklist.c:(.text+0x138): undefined reference to `wrefresh'
:checklist.c:(.text+0x1a4): undefined reference to `waddch'
scripts/kconfig/lxdialog/checklist.o: In function 
`print_arrows':checklist.c:(.text+0x1fa): undefined reference to `acs_map'
:checklist.c:(.text+0x21a): undefined reference to `acs_map'
:checklist.c:(.text+0x220): undefined reference to `wmove'
:checklist.c:(.text+0x240): undefined reference to `waddch'
:checklist.c:(.text+0x254): undefined reference to `waddnstr'
:checklist.c:(.text+0x268): undefined reference to `wmove'
:checklist.c:(.text+0x27a): undefined reference to `acs_map'
:checklist.c:(.text+0x29c): undefined reference to `waddch'
:checklist.c:(.text+0x2a8): undefined reference to `waddch'
:checklist.c:(.text+0x2b4): undefined reference to `waddch'
:checklist.c:(.text+0x2c0): undefined reference to `waddch'
:checklist.c:(.text+0x308): undefined reference to `waddch'
:checklist.c:(.text+0x31c): undefined reference to `waddnstr'
:checklist.c:(.text+0x364): undefined reference to `waddch'
:checklist.c:(.text+0x370): undefined reference to `waddch'
:checklist.c:(.text+0x37c): undefined reference to `waddch'
:checklist.c:(.text+0x388): undefined reference to `waddch'
scripts/kconfig/lxdialog/checklist.o: In function 
`print_buttons':checklist.c:(.text+0x41c): undefined reference to `wmove'

     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Here is the output of sh scripts/ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux raven 2.6.15.5-ybi #1 PREEMPT Sat Mar 4 17:23:44 CET 2006 ppc 
GNU/Linux

Gnu C                  4.0.2
Gnu make               3.80
binutils               2.16.91.0.5
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.6
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   086
Modules Loaded
[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
cpu             : 604ev
clock           : 374MHz
revision        : 1.0 (pvr 000a 0100)
bogomips        : 373.76
machine         : CHRP IBM,7043-150

[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

00000000-00bfffff : /pci@80000000
  00000000-0000001f : dma1
  00000020-00000021 : 8259 (master)
  00000040-0000005f : timer
  00000060-0000006f : i8042
  00000080-0000008f : dma page reg
  000000a0-000000a1 : 8259 (slave)
  000000c0-000000df : dma2
  00000213-00000213 : ISAPnP
  000002f8-000002ff : serial
  000003c0-000003df : matrox
  000003f8-000003ff : serial
  000004d0-000004d1 : 8259 edge control
  00000a79-00000a79 : isapnp write
  00bfcc00-00bfcc03 : 0000:00:0b.1
  00bfd000-00bfd003 : 0000:00:0b.1
  00bfd400-00bfd407 : 0000:00:0b.1
  00bfd800-00bfd807 : 0000:00:0b.1
  00bfdc00-00bfdc0f : 0000:00:0b.1
  00bfe000-00bfe00f : 0000:00:0b.1
  00bfe400-00bfe41f : 0000:00:0c.0
    00bfe400-00bfe41f : pcnet32_probe_pci
  00bfe800-00bfe8ff : 0000:00:10.0
    00bfe800-00bfe8ff : sym53c8xx
  00bfec00-00bfecff : 0000:00:12.0
  00bff000-00bfffff : PCI Bus #01
    00bff800-00bff8ff : 0000:01:01.0
    00bffc00-00bffcff : 0000:01:03.0
cat /proc/iomem
80000000-fcffffff : /pci@80000000
  f8cf7000-f8cf701f : 0000:00:0c.0
  f8cf8000-f8cf80ff : 0000:00:10.0
    f8cf8000-f8cf80ff : sym53c8xx
  f8cf9000-f8cf90ff : 0000:00:12.0
  f8cfa000-f8cfa7ff : 0000:00:12.0
  f8cfb000-f8cfbfff : 0000:00:10.0
    f8cfb000-f8cfbfff : sym53c8xx
  f8d00000-f8dfffff : PCI Bus #01
    f8df2000-f8df20ff : 0000:01:01.0
    f8df3000-f8df37ff : 0000:01:01.0
    f8dfb000-f8dfb0ff : 0000:01:03.0
  f8ec0000-f8efffff : 0000:00:0d.0
  f9000000-f9003fff : 0000:00:16.0
    f9000000-f9003fff : matroxfb MMIO
  f9800000-f9ffffff : 0000:00:16.0
  fa000000-faffffff : 0000:00:16.0
    fa000000-faffffff : matroxfb FB
fd000000-fdffffff : /pci@80000000
[7.5.] PCI information ('lspci -vvv' as root)

[7.6.] SCSI information (from /proc/scsi/scsi)
cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DGHS09U          Rev: 03B0
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1_02
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IBM      Model: DDRS-34560W      Rev: S98G
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: HITACHI  Model: HUS103073FL3600  Rev: SA1B
  Type:   Direct-Access                    ANSI SCSI revision: 03
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:


