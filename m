Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267496AbTBLPsg>; Wed, 12 Feb 2003 10:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbTBLPsg>; Wed, 12 Feb 2003 10:48:36 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:15019 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S267496AbTBLPse>;
	Wed, 12 Feb 2003 10:48:34 -0500
Date: Wed, 12 Feb 2003 21:26:04 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: Lars Magne Ingebrigtsen <larsi@gnus.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with hyper-threading on Asus P4T533 / Linux 2.4.20
Message-Id: <20030212212604.35baafad.b_adlakha@softhome.net>
In-Reply-To: <m365rpegts.fsf@quimbies.gnus.org>
References: <m365rpegts.fsf@quimbies.gnus.org>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003 15:03:59 +0100
Lars Magne Ingebrigtsen <larsi@gnus.org> wrote:

> We've just gotten an Asus P4T533-based machine with a 3.06GHz P4 CPU,
> bios version 1005.  (P4T533 is i850e-based.)  The bios claims that the
> P4 has hyper-threading, and as you can see from the cpuinfo output
> below, "ht" is among the flags.  (And the manual says that P4T533 is
> ht-enabled.)
> 
> I've tried booting with acpismp=force and without, and it doesn't
> seem to make much difference: Linux still only sees a single CPU.
> I've also tried 2.4.21-pre4 and -ac4, which doesn't seem to make any
> difference, either.
> 
> Anybody got any ideas why I can't get this to work?
> 
> buto:~# uname -a
> Linux buto 2.4.20 #3 SMP Wed Feb 12 14:28:49 CET 2003 i686 unknown
> buto:~# cat /proc/cpuinfo 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Pentium(R) 4 CPU 3.06GHz
> stepping        : 7
> cpu MHz         : 3073.691
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 6134.16


Thats sounds alright, you have to have an SMP kernel to use HT. Build a new kernel with the SMP option checked.
After that, you will see something like this with all that is above :
 siblings         : 2

And cpuinfo will show info for 2 processors...
