Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272073AbTHNBCJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 21:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272074AbTHNBCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 21:02:09 -0400
Received: from law10-f56.law10.hotmail.com ([64.4.15.56]:20229 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S272073AbTHNBCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 21:02:03 -0400
X-Originating-IP: [217.158.132.25]
X-Originating-Email: [allymcw2000@hotmail.com]
From: "Alasdair McWilliam" <allymcw2000@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an Athlon XP system
Date: Thu, 14 Aug 2003 02:02:02 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW10-F56d2h2jXi2Qd0001e84d@hotmail.com>
X-OriginalArrivalTime: 14 Aug 2003 01:02:02.0524 (UTC) FILETIME=[ABE915C0:01C361FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an Athlon XP 
system

2. I've recently built a new server, and transplanted my linux installation 
disks from an old server. The new server is an AMD Athlon XP 1800, the old 
server was an AMD K6-II 500MHz.

The transplant went fine, however I haven't been able to successfully move 
to an Athlon-optimised kernel. The kernel compile is fine, but when running 
depmod -de after installing the modules, I'm faced with about 20 "unresolved 
symbols". Each module is missing _mmx_memcpy.

I cannot get around it - I've tried everything, from the patch to 
arch/i386/kernel/i386_ksyms.c to completely reconfiguring my kernel from a 
brand new source tree. Nothing works.

3. Keywords: Kernel, Athlon, _mmx_memcpy, modules

4. Linux kernel version 2.4.20

7.1. Linux persephone 2.4.20 #1 Sun Dec 8 12:07:58 GMT 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         rtc 8139too mii iptable_filter ipt_ttl ipt_mark 
ipt_limit ipt_length ipt_REJECT ipt_REDIRECT ipt_MASQUERADE ipt_MARK ipt_LOG 
ip_conntrack_irc ip_nat_irc iptable_nat ip_tables ip_conntrack ipip 
ppp_deflate zlib_inflate zlib_deflate ppp_async dummy bsd_comp ppp_generic 
slhc unix

7.2. processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1800+
stepping        : 2
cpu MHz         : 1533.701
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3060.53

7.3. rtc                     5756   0 (autoclean)
8139too                13568   1 (autoclean)
mii                     2160   0 (autoclean) [8139too]
iptable_filter          1728   1
ipt_ttl                  640   0 (unused)
ipt_mark                 480   0 (unused)
ipt_limit                960   0 (unused)
ipt_length               480   0 (unused)
ipt_REJECT              2848  26
ipt_REDIRECT             800   0 (unused)
ipt_MASQUERADE          1248   1
ipt_MARK                 800   0 (unused)
ipt_LOG                 3232   0 (unused)
ip_conntrack_irc        3008   1 (autoclean)
ip_nat_irc              2272   0 (unused)
iptable_nat            13748   2 [ipt_REDIRECT ipt_MASQUERADE ip_nat_irc]
ip_tables              10336  13 [iptable_filter ipt_ttl ipt_mark ipt_limit 
ipt_length ipt_REJECT ipt_REDIRECT ipt_MASQUERADE ipt_MARK ipt_LOG 
iptable_nat]
ip_conntrack           16076   2 [ipt_REDIRECT ipt_MASQUERADE 
ip_conntrack_irc ip_nat_irc iptable_nat]
ipip                    5856   0 (unused)
ppp_deflate             2944   0
zlib_inflate           18304   0 [ppp_deflate]
zlib_deflate           17504   0 [ppp_deflate]
ppp_async               6304   1
dummy                   1056   0 (unused)
bsd_comp                3968   0
ppp_generic            16076   3 [ppp_deflate ppp_async bsd_comp]
slhc                    4384   0 [ppp_generic]
unix                   13508  14 (autoclean)

8. I've done research and found that people have been experiencing this 
problem from linux-2.4.0-test releases. Can someone please fix it?! Or point 
me to a patch that works? :( The server's running on a chunky kernel 
optimised for the old K6-II (i586).

Kind regards,
Alasdair McWilliam

_________________________________________________________________
Stay in touch with absent friends - get MSN Messenger 
http://www.msn.co.uk/messenger

