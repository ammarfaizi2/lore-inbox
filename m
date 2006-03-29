Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWC2TfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWC2TfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 14:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWC2TfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 14:35:25 -0500
Received: from ms-smtp-03.tampabay.rr.com ([65.32.5.133]:1439 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750830AbWC2TfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 14:35:25 -0500
Date: Wed, 29 Mar 2006 14:35:23 -0500
From: JimD <Jim@keeliegirl.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: AMD64 overclock issue with 2.6.16 but not with 2.6.15
Message-ID: <20060329143523.3bbb4df7@keelie.localdomain>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do any one know of any other issues with amd64 and the
2.6.16 series?  I have run into a weird issue.

I have an AMD64 3200+ that runs at 2 GHz and runs *very* cool at about
34c.  My motherboard makes it pretty easy to overclock so I have
overclocked the 3200+ to 2.2 GHz and it has been running very stable
and still only around 39c.

When I was runing overclocked in 2.6.15 /proc/cpuinfo would show:

jim@keelie$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 47
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 2
cpu MHz         : 2200.000
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
                  pge mca cmov pat pse36 clflush mmx fxsr sse sse2
                  syscall nx mmxext fxsr_opt lm 3dnowext 3dnow pni
                  lahf_lm ts fid vid ttp tm stc
bogomips        : 4409.17


Now with 2.6.16 it shows:

jim@keelie$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 47
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 2
cpu MHz         : 2000.000
                 ^^^^^^^^^^
<snip>
bogomips        : 4409.17


The bogomips are showing the same though the kernel is not reporting
the correct MHz.  If I reboot and check the BIOS, the correct MHz is
reported.  I have not run any CPU benchmarks to see if performance is
really going back down to 2000 MHz.

Does anyone have a clue what could be causing this?

Jim
