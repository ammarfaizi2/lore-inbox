Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVEBUlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVEBUlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 16:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVEBUlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 16:41:16 -0400
Received: from mail.tyan.com ([66.122.195.4]:36370 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261765AbVEBUkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 16:40:41 -0400
Message-ID: <3174569B9743D511922F00A0C943142309B07C1E@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: x86-64 dual core mapping
Date: Mon, 2 May 2005 14:01:00 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

resent. FYI

YH

before patch
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
Booting processor 1/1 rip 6000 rsp ffff81007ff99f58 Initializing CPU#1
masked ExtINT on CPU#1
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 0
 stepping 00
Synced TSC of CPU 1 difference 21474835384 Booting processor 2/2 rip 6000
rsp ffff81013ffa3f58 Initializing CPU#2 masked ExtINT on CPU#2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(2) -> Node 1 -> Core 1
 stepping 00
Synced TSC of CPU 2 difference 21474835425 Booting processor 3/3 rip 6000
rsp ffff81007ff49f58 Initializing CPU#3 masked ExtINT on CPU#3
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(2) -> Node 1 -> Core 1
 stepping 00
Synced TSC of CPU 3 difference 21474835425 Brought up 4 CPUs


~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 255
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 3956.73
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 255
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 2
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 255
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 3
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 255
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

~ # 



after patch


CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
Booting processor 1/1 rip 6000 rsp ffff81007ff99f58 Initializing CPU#1
masked ExtINT on CPU#1
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
 stepping 00
Synced TSC of CPU 1 difference 21474835384 Booting processor 2/2 rip 6000
rsp ffff81013ffa3f58 Initializing CPU#2 masked ExtINT on CPU#2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(2) -> Node 1 -> Core 0
 stepping 00
Synced TSC of CPU 2 difference 21474835425 Booting processor 3/3 rip 6000
rsp ffff81007ff49f58 Initializing CPU#3 masked ExtINT on CPU#3
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(2) -> Node 1 -> Core 1
 stepping 00
Synced TSC of CPU 3 difference 21474835425 Brought up 4 CPUs


~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 3956.73
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 2
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 1
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 3
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : unknown
stepping        : 0
cpu MHz         : 2010.342
cache size      : 1024 KB
physical id     : 1
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht pni syscall y
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

~ #  

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de] 
> Sent: Monday, May 02, 2005 1:19 PM
> To: YhLu
> Cc: Andi Kleen; linux-kernel@vger.kernel.org
> Subject: Re: x86-64 dual core mapping
> 
> On Mon, May 02, 2005 at 12:41:31PM -0700, YhLu wrote:
> > I'm using LinuxBIOS and there is no acpi in that. Also I have tried 
> > Normal BIOS, it also produce that.
> > 
> > Did you check my patch? It fixed that.
> 
> I dont think it is a correct, and Suresh is right that it 
> will break Intel setups.
> 
> I will investigate this evening and see if I can reproduce it 
> on Simnow.
> 
> -Andi
> 
