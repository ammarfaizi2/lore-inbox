Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVJVNRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVJVNRS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 09:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVJVNRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 09:17:18 -0400
Received: from smtp1.sloane.cz ([62.240.161.228]:56799 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S1751062AbVJVNRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 09:17:18 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: interrupts are not shared between CPUs in 2.6.14-rc3
Date: Sat, 22 Oct 2005 15:16:57 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510221516.59343.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have upgraded from 2.4.31 to 2.6.14-rc3 and see, that all interrupts are 
handled by CPU0. In 2.4 Both CPUs take care. Pls fix that:

Liboc01:~# cat /proc/interrupts
           CPU0       CPU1
  0:   87123702          0    IO-APIC-edge  timer
  2:          0          0          XT-PIC  cascade
  3:    1245874          0    IO-APIC-edge  serial
  5:          0          1    IO-APIC-edge  CS4231
  8:          3          1    IO-APIC-edge  rtc
 17:    1669193          1   IO-APIC-level  eth0
 18:      72922         60   IO-APIC-level  aic7xxx
 19:    3425040          0   IO-APIC-level  eth1, wifi0
NMI:          0          0
LOC:   87125040   87125039
ERR:          0
MIS:          0

Liboc01:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 0
cpu MHz         : 332.420
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 666.08

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 0
cpu MHz         : 332.420
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 664.84

Linux Liboc01 2.6.14-rc3 #3 SMP Tue Oct 18 14:09:10 CEST 2005 i686 GNU/Linux

Debian stable (Sarge)

Regards

Michal
