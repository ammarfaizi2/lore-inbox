Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUDSRcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUDSRcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:32:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:8126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261611AbUDSRcq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:32:46 -0400
Date: Mon, 19 Apr 2004 10:27:10 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: =?ISO-8859-1?Q?Rom=E1n?= Medina <roman@rs-labs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.26 doesn't compile? ("error: `__cmpxchg' previously defined
  here")
Message-Id: <20040419102710.06bcdf9a.rddunlap@osdl.org>
In-Reply-To: <31145.194.224.100.28.1082362588.squirrel@194.224.100.28>
References: <31145.194.224.100.28.1082362588.squirrel@194.224.100.28>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004 10:16:28 +0200 (CEST) Román Medina wrote:

| Hi,
| 
| I'm trying to compile 2.4.26 kernel but I get the following error in "make
| modules" part:
| 
| [...]
| make[3]: Entering directory `/usr/src/linux-2.4.26/drivers/char/drm'
| gcc -D__KERNEL__ -I/usr/src/linux-2.4.26/include -Wall -Wstrict-prototypes
| -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
| -pipe -mpreferred-stack-boundary=2 -march=i386 -DMODULE -DMODVERSIONS
| -include /usr/src/linux-2.4.26/include/linux/modversions.h  -nostdinc
| -iwithprefix include -DKBUILD_BASENAME=gamma_drv  -c -o gamma_drv.o
| gamma_drv.c
| In file included from gamma_drv.c:34:
| drmP.h:180: error: redefinition of `__cmpxchg'
| /usr/src/linux-2.4.26/include/asm/system.h:245: error: `__cmpxchg'
| previously defined here
| make[3]: *** [gamma_drv.o] Error 1
| make[3]: Leaving directory `/usr/src/linux-2.4.26/drivers/char/drm'
| make[2]: *** [_modsubdir_drm] Error 2
| make[2]: Leaving directory `/usr/src/linux-2.4.26/drivers/char'
| make[1]: *** [_modsubdir_char] Error 2
| make[1]: Leaving directory `/usr/src/linux-2.4.26/drivers'
| make: *** [_mod_drivers] Error 2
| 
| My machine:
| 
| mta-mad:~# cat /proc/cpuinfo
| processor       : 0
| vendor_id       : GenuineIntel
| cpu family      : 15
| model           : 1
| model name      : Intel(R) Celeron(R) CPU 1.80GHz
| stepping        : 3
| cpu MHz         : 1817.948
| cache size      : 128 KB
| fdiv_bug        : no
| hlt_bug         : no
| f00f_bug        : no
| coma_bug        : no
| fpu             : yes
| fpu_exception   : yes
| cpuid level     : 2
| wp              : yes
| flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
| cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
| bogomips        : 3630.69
| 
| mta-mad:~# gcc -v
| Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.3/specs
| Configured with: ../src/configure -v
| --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr
| --mandir=/usr/share/man --infodir=/usr/share/info
| --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared
| --with-system-zlib --enable-nls --without-included-gettext
| --enable-__cxa_atexit --enable-clocale=gnu --enable-debug
| --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
| Thread model: posix
| gcc version 3.3.3 (Debian 20040401)
| mta-mad:~#
| 
| I've attached the .config file which I'm using. The system is Debian
| Unstable. I've compiled (older) kernels without problems.
| 
| I also tried to compile it using gcc-2.95 obtaining the same (bad) results
| (I changed Makefile and replaced "gcc" by "gcc-2.95", which is the 2.95
| binary in my system).
| 
| Any ideas?

Sure, build for more than CONFIG_M386=y.
I.e., build for a Pentium III etc. and it should work.

--
~Randy
