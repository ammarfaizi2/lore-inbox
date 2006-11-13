Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755178AbWKMP6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbWKMP6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755182AbWKMP6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:58:41 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:46085 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1755179AbWKMP6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:58:40 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm1
Date: Mon, 13 Nov 2006 16:58:05 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061108015452.a2bb40d2.akpm@osdl.org>
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131658.06036.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I tried to compile 2.6.19-rc5-mm1 on x86_64 box and it failed.
Looking at the Documentation/Changes the box tools are a bit old but
the kernel should compile. This was 'allmodconfig' with CONFIG_KVM=n
because binutils are too old for that. So either this is a bug or
Documentation/Changes should be updated soon.

  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.init.text+0x31b7): In function `alternative_instructions':
arch/i386/kernel/alternative.c:437: undefined reference to `__stop_parainstructions'
arch/x86_64/kernel/built-in.o(.init.text+0x31be):arch/i386/kernel/alternative.c:437: undefined reference to `__start_parainstructions'
make: *** [.tmp_vmlinux1] Error 1

Linux x 2.6.14.3-051207a #1 SMP Wed Dec 7 12:17:16 CET 2005 x86_64 x86_64 x86_64 GNU/Linux
 
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15.94.0.2.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.2-pre1
e2fsprogs              1.36
jfsutils               1.1.7
reiserfsprogs          3.6.18
xfsprogs               2.6.25
quota-tools            3.12.
Linux C Library        x  1 root root 1446783 Jun 11  2005 /lib64/tls/libc.so.6
Dynamic linker (ldd)   2.3.4
Linux C++ Library      5.0.7
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.3.0
udev                   053
Modules Loaded         thermal fan sg ide_cd cdrom dm_mod

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 47
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 2
cpu MHz         : 1000.045
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm 3dnowext 3dnow pni lahf_lm
bogomips        : 2002.26
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

-- 
Regards,

	Mariusz Kozlowski
