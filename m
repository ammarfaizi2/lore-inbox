Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268977AbUIMVbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268977AbUIMVbb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268979AbUIMVbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:31:31 -0400
Received: from ns.mashcenter.ru ([195.14.58.214]:20493 "HELO ns.mashcenter.ru")
	by vger.kernel.org with SMTP id S268977AbUIMVb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:31:26 -0400
Date: Tue, 14 Sep 2004 01:31:17 +0400
From: Leonid Kalmankin <lvk@mashcenter.ru>
To: linux-kernel@vger.kernel.org
Subject: segfault and multiple traps on x86_64
Message-Id: <20040914013117.3bda812d.lvk@mashcenter.ru>
Organization: MashCenter
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

In dmesg I see stuff like:

rpmbuild[3842] trap int3 rip:402d9e rsp:7fbfffb540 error:0
rpmbuild[3842] trap int3 rip:4026d1 rsp:7fbfffb538 error:0
sh[3843] trap int3 rip:415f39 rsp:7fbffff8c8 error:0
sh[3843]: segfault at 0000000000000000 rip 0000000000000000 rsp 0000007fbffff8b8 error 14
rpmbuild[3842] trap int3 rip:402dea rsp:7fbfffb540 error:0
rpmbuild[3842] trap int3 rip:4025d1 rsp:7fbfffb538 error:0
rpmbuild[3842] trap int3 rip:402ced rsp:7fbfffb540 error:0
rpmbuild[3842] trap int3 rip:4027c1 rsp:7fbffff688 error:0

segfault is scarry.
Are these traps harmless or do they mean some serious software/hardware problem?

The system is:
Fedora Core 2 x86_64, last updates, vanilla 2.6.8.1, dual AMD Opteron, 4G RAM

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 10
cpu MHz         : 1992.318
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 3915.77
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp
 
[skipping 2nd processor info]

SY,
LVK
