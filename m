Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRDGTdr>; Sat, 7 Apr 2001 15:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRDGTdi>; Sat, 7 Apr 2001 15:33:38 -0400
Received: from 13dyn201.delft.casema.net ([212.64.76.201]:35335 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130532AbRDGTdY>; Sat, 7 Apr 2001 15:33:24 -0400
Message-Id: <200104071933.VAA19651@cave.bitwizard.nl>
Subject: P-III Oddity. 
To: linux-kernel@vger.kernel.org, bert@dutepp0.et.tudelft.nl,
        jeanpaul@dutepp0.et.tudelft.nl
Date: Sat, 7 Apr 2001 21:33:18 +0200 (MEST)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

One machine regularly crashes.  

Linux version 2.2.16-3 (root@porky.devel.redhat.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Jun 19 19:11:44 EDT 2000
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 551.255
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips        : 1101.00


Another one, I don't really know, but I was comparing /proc/cpuinfo on
these two machines as they are supposed to have the same CPU: 


/home/wolff> cat /proc/version /proc/cpuinfo
Linux version 2.4.3 (wolff@cave) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #52 Fri Apr 6 14:43:38 MEST 2001
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 551.263
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1101.00

/home/wolff> 


Everything is exactly the same, except for the "cpuid level". Once the
cpu family and model are the same, I'd expect the cpuid level to be
the same too. In this case even the stepping is the same, so how can
the cpuid level differ? 

Maybe this is a reporting difference between 2.4.3 and 2.2.16????

Anybody care to shed some light on this?

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
