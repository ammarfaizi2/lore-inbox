Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267676AbRGZICY>; Thu, 26 Jul 2001 04:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267681AbRGZICN>; Thu, 26 Jul 2001 04:02:13 -0400
Received: from [212.16.11.1] ([212.16.11.1]:15112 "EHLO ns.msiu.ru")
	by vger.kernel.org with ESMTP id <S267676AbRGZICD>;
	Thu, 26 Jul 2001 04:02:03 -0400
From: "Basil A. Evseenko" <evseenko@msiu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15199.52878.79122.134405@alone.msiu.ru>
Date: Thu, 26 Jul 2001 12:02:22 +0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.7 - strange reiserfs and software RAID5 behavior
X-Mailer: VM 6.92 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


When raid5 daemon do resync array after unclean shutdown, mounting
_other_ reiserfs filesystems is too slow. (for example: 5 seconds without
running resync daemon,  2 minutes with it). This bug only arrives on 
uniprocessor machines - on SMP all work fine. I trace mount execution
it's sleep on __wait_on_buffer.

Gnu C                  egcs-2.91.66
Gnu make               3.78.1
binutils               2.9.5.0.22
util-linux             2.10f
mount                  2.10f
modutils               2.4.0
e2fsprogs              1.18
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.8
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 601.374
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1199.30

