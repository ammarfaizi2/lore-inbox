Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267246AbTBLNyN>; Wed, 12 Feb 2003 08:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTBLNyN>; Wed, 12 Feb 2003 08:54:13 -0500
Received: from main.gmane.org ([80.91.224.249]:56761 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267246AbTBLNyL>;
	Wed, 12 Feb 2003 08:54:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: Problems with hyper-threading on Asus P4T533 / Linux 2.4.20
Date: Wed, 12 Feb 2003 15:03:59 +0100
Organization: Programmerer Ingebrigtsen
Message-ID: <m365rpegts.fsf@quimbies.gnus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
Mail-Copies-To: never
X-Now-Playing: Blaine L. Reininger's _Night Air_: "Crash (Remix)"
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.50
 (i686-pc-linux-gnu)
Cancel-Lock: sha1:AY8jAkm3ZOTVSmZnB5mqPkPo9Bo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've just gotten an Asus P4T533-based machine with a 3.06GHz P4 CPU,
bios version 1005.  (P4T533 is i850e-based.)  The bios claims that the
P4 has hyper-threading, and as you can see from the cpuinfo output
below, "ht" is among the flags.  (And the manual says that P4T533 is
ht-enabled.)

I've tried booting with acpismp=force and without, and it doesn't
seem to make much difference: Linux still only sees a single CPU.
I've also tried 2.4.21-pre4 and -ac4, which doesn't seem to make any
difference, either.

Anybody got any ideas why I can't get this to work?

buto:~# uname -a
Linux buto 2.4.20 #3 SMP Wed Feb 12 14:28:49 CET 2003 i686 unknown
buto:~# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.06GHz
stepping        : 7
cpu MHz         : 3073.691
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 6134.16


-- 
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen

