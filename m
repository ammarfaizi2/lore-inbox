Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161162AbWJDPDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161162AbWJDPDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWJDPDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:03:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:24922 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161162AbWJDPDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:03:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:sender;
        b=ajNcZzRbR60PY0t/r+CIR/TjYJPGBNjhWjvuG5SwvBMsTB3jq6BkwaWwdWWUpS5owSsRvApkykm7Q+vpqD37uQnUv60nBIxq7zU0qUesrEzer1jpOMvBFkjccQS2RDL1mq5pcHMoXbqdDnVfinYa5WgITgq6gy8z66GS0VcUcyk=
Message-ID: <4523CD4E.10806@web.de>
Date: Wed, 04 Oct 2006 17:03:42 +0200
From: Markus Wenke <M.Wenke@web.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: to many sockets ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote a program which handles incomming sockets asynchron.
It can handle up to 140000 connections simultaneously while every 
connection send some bytes in both directions continuously.

But if I want to connect more than the 140000 connection  my application 
has been killed by the oom-killer, but the System has enough memory.

If I use a patched Xen-Kernel (2.6.16.21-0.13-xen, only the kernel, no 
xend) it can handle up to 200000 connections.


Is there a kernel param, or something else to tune the kernel, that it 
can handle more Connections?

Or can I determine how many connections can my really System accept 
before the oom-killer kills my app?


please send me an email, for getting the /var/log/messages


thanks in advance

Markus Wenke

here my System:
////////////////////////////////////////////////////////////////////////////
setrlimit: RLIMIT_NOFILE = 500000

////////////////////////////////////////////////////////////////////////////
~# uname -a
Linux test1 2.6.18-bigsmp #3 SMP Wed Oct 4 15:18:40 CEST 2006 i686 
athlon i386 GNU/Linux

////////////////////////////////////////////////////////////////////////////
~# free:
             total       used       free     shared    buffers     cached
Mem:       3108372     193788    2914584          0       5520     107068
-/+ buffers/cache:      81200    3027172
Swap:      2104472          0    2104472

////////////////////////////////////////////////////////////////////////////
~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : Dual Core AMD Opteron(tm) Processor 170
stepping        : 2
cpu MHz         : 1000.000
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
 lm 3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 2011.55

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : Dual Core AMD Opteron(tm) Processor 170
stepping        : 2
cpu MHz         : 1000.000
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
 lm 3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 2011.55


