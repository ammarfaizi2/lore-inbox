Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267527AbUHEAmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUHEAmv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 20:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267529AbUHEAmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 20:42:50 -0400
Received: from S010600104b97db1e.gv.shawcable.net ([24.68.211.67]:27660 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S267527AbUHEAmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 20:42:45 -0400
Date: Wed, 4 Aug 2004 17:34:26 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: ACPI/Panic 2.6.8-rc3
Message-ID: <20040805003426.GA18820@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reported this a while ago, but tried it again, still getting oops
when doing an rmmod of the ACPI processor module.

Hardware: IBM T30, P4 2.4GHz, 256MiB, Debian/stable, did an rmmod processor.

Note: Oops below was copied by hand, so may not be fully reliable.  Also,
EIP was screwy, so no idea what was executing.

100% reproducible.

ramune@hasenpfeffer:linux-2.6: ./scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux hasenpfeffer 2.6.8-rc3 #25 Tue Aug 3 20:28:47 PDT 2004 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.12.90.0.1
util-linux             2.11n
mount                  2.11n
module-init-tools      3.0-pre7
e2fsprogs              1.27
pcmcia-cs              3.1.33
nfs-utils              1.0
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11

ksymoops 2.4.9 on i686 2.6.8-rc3.  Options used
     -v /home/ramune/src/kernel-stuff/linux-2.6/vmlinux (specified)
     -K (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.6.8-rc3 (specified)
     -m /boot/System.map-2.6.8-rc3 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
eip: d0a42294
*pde = 012c5067
Oops: 0000 [#1]
CPU: 0
EIP: 0060:[<d0a42294>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216 (2.6.8-rc3)
eax: 00000000 ebx: 002bef05 ecx: 00000008 edx: 00001020
esi: cff346f8 edi: 002beb87 ebp: cff34600 esp: c02fbfd4
ds: 007b es: 007b ss: 0068
Stack: 0009ef00 00000000 c0fb0000 0009ef00 c031a120 00388007 c010208c c02fc5d3
       c031abe0 0001080e c010019f
Call Trace:
  [<c010208c>]
  [<c02fc5d3>]
Code: Bad EIP value


>>EIP; d0a42294 <pg0+106db294/3fc97000>   <=====

>>esi; cff346f8 <pg0+fbcd6f8/3fc97000>
>>ebp; cff34600 <pg0+fbcd600/3fc97000>
>>esp; c02fbfd4 <init_thread_union+fd4/1000>

Trace; c010208c <cpu_idle+1f/34>
Trace; c02fc5d3 <start_kernel+145/148>

