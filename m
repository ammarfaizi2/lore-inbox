Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275067AbRJFG70>; Sat, 6 Oct 2001 02:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275068AbRJFG7R>; Sat, 6 Oct 2001 02:59:17 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:56176 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S275067AbRJFG7K> convert rfc822-to-8bit; Sat, 6 Oct 2001 02:59:10 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: CPU-recognize problems in 2.4.11pre4
Date: Sat, 6 Oct 2001 08:57:52 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E15plQx-0003su-00@mrvdom02.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.4.11pre4 I see the following problem on a single CPU-System. There is 
__no__ APIC and SMP-Support in the Kernel.

[root@Einstein linux]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1005.165
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat p
se36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2005.40

processor       : 1
vendor_id       : unknown
cpu family      : 0
model           : 0
model name      : unknown
stepping        : 32
cpu MHz         : 1005.165
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : yes
fpu             : yes
fpu_exception   : yes
cpuid level     : 0
wp              : no
flags           : fpu vme de pse tsc 3dnow lrti
bogomips        : 0.02

processor       : 2
vendor_id       : œ¦þß
cpu family      : 72
model           : 34
model name      : ÿ
stepping        : 192
cpu MHz         : 1005.165
fdiv_bug        : yes
hlt_bug         : yes
f00f_bug        : no
coma_bug        : no
fpu             : no
fpu_exception   : no
cpuid level     : -1071668279
wp              : no
flags           : tsc msr pae mce cyrix_arr centaur_mcr
bogomips        : 0.00

processor       : 3
vendor_id       : unknown
cpu family      : 0
model           : 0
model name      : unknown
stepping        : 0
fdiv_bug        : yes
hlt_bug         : yes
f00f_bug        : yes
coma_bug        : yes
fpu             : no
fpu_exception   : no
cpuid level     : 0
wp              : no
flags           :
bogomips        : 644660.07

processor       : 4
vendor_id       : unknown
cpu family      : 235
model           : 31
model name      : unknown
stepping        : 192
cache size      : 0 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : -1071667048
wp              : yes
flags           : fpu msr pae mce sep pge cmov pat pse36 pn clflush ia64 
syscall
 3dnowext 3dnow lrti cxmmx cyrix_arr
bogomips        : 0.00

processor       : 5
vendor_id       : unknown
cpu family      : 0
model           : 0
model name      : unknown
stepping        : 0
fdiv_bug        : yes
hlt_bug         : yes
f00f_bug        : yes
coma_bug        : yes
fpu             : no
fpu_exception   : no
cpuid level     : 0
wp              : no
flags           :
bogomips        : 0.00

processor       : 6
vendor_id       : unknown
cpu family      : 0
model           : 0
model name      : unknown
stepping        : 0
cache size      : 515 KB
fdiv_bug        : yes
hlt_bug         : yes
f00f_bug        : yes
coma_bug        : yes
fpu             : no
fpu_exception   : no
cpuid level     : 0
wp              : no
flags           :
bogomips        : 644464.96

processor       : 7
vendor_id       : 0ÐÀ
cpu family      : 80
model           : 15
model name      :
stepping        : 192
cache size      : 1436028985 KB
fdiv_bug        : yes
hlt_bug         : yes
f00f_bug        : yes
coma_bug        : yes
fpu             : no
fpu_exception   : no
cpuid level     : -1072640304
wp              : yes
flags           : msr cx8 apic sep mca cmov ia64 syscall 3dnowext 3dnow
bogomips        : 644712.39
