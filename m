Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266113AbRGESN1>; Thu, 5 Jul 2001 14:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266124AbRGESNS>; Thu, 5 Jul 2001 14:13:18 -0400
Received: from zeke.inet.com ([199.171.211.198]:42738 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S266113AbRGESND>;
	Thu, 5 Jul 2001 14:13:03 -0400
Message-ID: <3B44AD33.26D97B4C@inet.com>
Date: Thu, 05 Jul 2001 13:08:51 -0500
From: "Jordan Breeding" <jordan.breeding@inet.com>
Reply-To: Jordan <ledzep37@home.com>,
        Jordan Breeding <jordan.breeding@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problems halting/rebooting with 2.4.{5,6}-ac
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Tyan Tiger 230 SMP system running dual 1 GHz PIII processors. 
The processors are of the same lot and revision, bought on the same
day.  Everything worked fine or some time in regard to
halting/rebooting.  I was using ac kernels configured with ACPI.  At the
time of the merge with the Linus stuff which included new ACPI I started
configuring with ACPI and ACPI bus management and I could no longer halt
the system but rebooting worked OK.  As of 2.4.5-ac24 and 2.4.6-ac1 I
can no longer halt or reboot my system properly using no power
management or ACPI, and APM still displays the message about being
broken on SMP.  Has anyone seen this problem, is there a fix for it? 
Another thing I have noticed is that my /proc/cpuinfo file looks like
this:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 999.694
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1992.29

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 999.694
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1998.84

Notice the difference in cpuid level and bogomips values between the
two.  These processors should be exactly the same, same lot and revision
and everything else according to the shrink wrapped Intel retail boxes
they came out of.  What could be casuing them to show up at different
cpuid levels?  Thanks for any help with either issue.

Jordan Breeding
