Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262689AbTCPQln>; Sun, 16 Mar 2003 11:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262690AbTCPQln>; Sun, 16 Mar 2003 11:41:43 -0500
Received: from [203.22.204.108] ([203.22.204.108]:32520 "EHLO
	grenada.globat.com") by vger.kernel.org with ESMTP
	id <S262689AbTCPQlk>; Sun, 16 Mar 2003 11:41:40 -0500
Message-ID: <3E74AC1C.8010901@organigramme.net>
Date: Sun, 16 Mar 2003 11:53:48 -0500
From: Maxime <x@organigramme.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: make bzImage fails when LANG set
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2
I'm on a lfs 4.0 system.  I installed the kernel witouth any problem. 
 But then I eventually needed to recompile, and it failed during the 
make bzImage.  Outputing this :

Dans le fichier inclus à partir de 
/usr/src/linux-2.4.19/include/linux/wait.h:13,
          à partir de /usr/src/linux-2.4.19/include/linux/fs.h:12,
          à partir de /usr/src/linux-2.4.19/include/linux/capability.h:17,
          à partir de /usr/src/linux-2.4.19/include/linux/binfmts.h:5,
          à partir de /usr/src/linux-2.4.19/include/linux/sched.h:9,
          à partir de /usr/src/linux-2.4.19/include/linux/mm.h:4,
          à partir de sched.c:23:
/usr/src/linux-2.4.19/include/linux/kernel.h:10:20: stdarg.h: Aucun 
fichier ou répertoire de ce type
Dans le fichier inclus à partir de 
/usr/src/linux-2.4.19/include/linux/wait.h:13,

          à partir de /usr/src/linux-2.4.19/include/linux/fs.h:12,
          à partir de /usr/src/linux-2.4.19/include/linux/capability.h:17,
          à partir de /usr/src/linux-2.4.19/include/linux/binfmts.h:5,
          à partir de /usr/src/linux-2.4.19/include/linux/sched.h:9,
          à partir de /usr/src/linux-2.4.19/include/linux/mm.h:4,
          à partir de sched.c:23:
/usr/src/linux-2.4.19/include/linux/kernel.h:73: erreur d'analyse 
syntaxique avant « va_list »
/usr/src/linux-2.4.19/include/linux/kernel.h:73: AVERTISSEMENT: 
déclaration de fonction n'est pas un prototype
/usr/src/linux-2.4.19/include/linux/kernel.h:76: erreur d'analyse 
syntaxique avant « va_list »
/usr/src/linux-2.4.19/include/linux/kernel.h:76: AVERTISSEMENT: 
déclaration de fonction n'est pas un prototype
/usr/src/linux-2.4.19/include/linux/kernel.h:80: erreur d'analyse 
syntaxique avant « va_list »
/usr/src/linux-2.4.19/include/linux/kernel.h:80: AVERTISSEMENT: 
déclaration de fonction n'est pas un prototype
make[2]: *** [sched.o] Erreur 1
make[2]: Quitte le répertoire `/usr/src/linux-2.4.19/kernel'
make[1]: *** [first_rule] Erreur 2
make[1]: Quitte le répertoire `/usr/src/linux-2.4.19/kernel'
make: *** [_dir_kernel] Erreur 2

Notice it is in french.  I search on the web for similar problem, and 
find a few examples, all in foreing language.  Nobody seemed to know how 
to solve this.  I then remembered I added these lines to my /etc/profile:

export LANG=fr
export LC_ALL=fr_CA

By removing them, the kernel compiled just fine.  Stange bug!

Hope this helps

Maxime

3
make bzImage LANG

4
Linux version 2.4.19 (root@organigramme) (gcc version 3.2) #2 SMP Tue 
Mar 11 13:43:06 EST 200

5
not applicable

6
?

7.1
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Linux C++ Library      5.0.0
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0

7.2
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 2
cpu MHz         : 500.032
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat mmx syscall mmxext 3dnowext 3dnow
bogomips        : 996.14

7.3
empty

7.4
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
b400-b43f : Ensoniq ES1371 [AudioPCI-97]
  b400-b43f : es1371
b800-b81f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0bffbfff : System RAM
  00100000-00311f4e : Kernel code
  00311f4f-003b5a9f : Kernel data
0bffc000-0bffefff : ACPI Tables
0bfff000-0bffffff : ACPI Non-volatile Storage
e0000000-e1efffff : PCI Bus #01
  e0000000-e0ffffff : nVidia Corporation Riva TnT2 [NV5]
e1f00000-e3ffffff : PCI Bus #01
  e2000000-e3ffffff : nVidia Corporation Riva TnT2 [NV5]
e4000000-e7ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
ffff0000-ffffffff : reserved

7.5
command not installed

7.6
Attached devices: none



