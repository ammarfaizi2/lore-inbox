Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbSKOHSH>; Fri, 15 Nov 2002 02:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbSKOHSH>; Fri, 15 Nov 2002 02:18:07 -0500
Received: from pool-151-196-237-149.balt.east.verizon.net ([151.196.237.149]:45744
	"EHLO starbug.reddwarf") by vger.kernel.org with ESMTP
	id <S262882AbSKOHSF>; Fri, 15 Nov 2002 02:18:05 -0500
Message-ID: <3DD4A149.4030707@yossman.net>
Date: Fri, 15 Nov 2002 02:24:57 -0500
From: Brian Davids <dlister@yossman.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@redhat.com>
Subject: 2.4.20-rc1-ac3 compile warnings/errors (test)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of warnings and then a compile-ending error... config can be
found at http://dlister.net/config-2.4.20-rc1-ac3


make[1]: Circular /usr/src/linux-2.4.20-rc1-ac3/include/asm/smplock.h <- 
/usr/src/linux-2.4.20-rc1-ac3/include/linux/interrupt.h dependency dropped.
make[1]: Circular 
/usr/src/linux-2.4.20-rc1-ac3/include/linux/netfilter_ipv4/ip_conntrack_helper.h 
<- 
/usr/src/linux-2.4.20-rc1-ac3/include/linux/netfilter_ipv4/ip_conntrack.h 
dependency dropped.


gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-rc1-ac3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
-I../ -nostdinc -iwithprefix include -DKBUILD_BASENAME=generic  -c -o 
generic.o generic.c
generic.h:138: warning: `unknown_chipset' defined but not used


gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-rc1-ac3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
  -nostdinc -iwithprefix include -DKBUILD_BASENAME=setup_pci 
-DEXPORT_SYMTAB -c setup-pci.c
setup-pci.c: In function `ide_setup_pci_device':
setup-pci.c:704: warning: unused variable `index_list'
setup-pci.c: In function `ide_setup_pci_devices':
setup-pci.c:711: warning: unused variable `index_list'
setup-pci.c:712: warning: unused variable `index_list2'


gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-rc1-ac3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
  -nostdinc -iwithprefix include -DKBUILD_BASENAME=pnpbios_core 
-DEXPORT_SYMTAB -c pnpbios_core.c
{standard input}: Assembler messages:
{standard input}:16: Warning: indirect lcall without `*'


gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-rc1-ac3/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
  -nostdinc -iwithprefix include -DKBUILD_BASENAME=rmap  -c -o rmap.o rmap.c
In file included from rmap.c:31:
/usr/src/linux-2.4.20-rc1-ac3/include/asm/smplock.h:17:1: warning: 
"kernel_locked" redefined
In file included from /usr/src/linux-2.4.20-rc1-ac3/include/asm/hw_irq.h:16,
                  from /usr/src/linux-2.4.20-rc1-ac3/include/linux/irq.h:69,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/asm/hardirq.h:6,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/linux/interrupt.h:46,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/asm/highmem.h:25,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/linux/highmem.h:11,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/linux/pagemap.h:16,
                  from rmap.c:24:
/usr/src/linux-2.4.20-rc1-ac3/include/linux/smp_lock.h:12:1: warning: 
this is the location of the previous definition
In file included from rmap.c:31:
/usr/src/linux-2.4.20-rc1-ac3/include/asm/smplock.h:22:1: warning: 
"release_kernel_lock" redefined
In file included from /usr/src/linux-2.4.20-rc1-ac3/include/asm/hw_irq.h:16,
                  from /usr/src/linux-2.4.20-rc1-ac3/include/linux/irq.h:69,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/asm/hardirq.h:6,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/linux/interrupt.h:46,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/asm/highmem.h:25,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/linux/highmem.h:11,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/linux/pagemap.h:16,
                  from rmap.c:24:
/usr/src/linux-2.4.20-rc1-ac3/include/linux/smp_lock.h:10:1: warning: 
this is the location of the previous definition
In file included from rmap.c:31:
/usr/src/linux-2.4.20-rc1-ac3/include/asm/smplock.h:33:1: warning: 
"reacquire_kernel_lock" redefined
In file included from /usr/src/linux-2.4.20-rc1-ac3/include/asm/hw_irq.h:16,
                  from /usr/src/linux-2.4.20-rc1-ac3/include/linux/irq.h:69,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/asm/hardirq.h:6,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/linux/interrupt.h:46,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/asm/highmem.h:25,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/linux/highmem.h:11,
                  from 
/usr/src/linux-2.4.20-rc1-ac3/include/linux/pagemap.h:16,
                  from rmap.c:24:
/usr/src/linux-2.4.20-rc1-ac3/include/linux/smp_lock.h:11:1: warning: 
this is the location of the previous definition
In file included from rmap.c:31:
/usr/src/linux-2.4.20-rc1-ac3/include/asm/smplock.h:47:40: macro 
"lock_kernel" passed 1 arguments, but takes just 0
In file included from rmap.c:31:
/usr/src/linux-2.4.20-rc1-ac3/include/asm/smplock.h:48: syntax error 
before '{' token
/usr/src/linux-2.4.20-rc1-ac3/include/asm/smplock.h:63:42: macro 
"unlock_kernel" passed 1 arguments, but takes just 0
/usr/src/linux-2.4.20-rc1-ac3/include/asm/smplock.h:64: syntax error 
before '{' token
make[2]: *** [rmap.o] Error 1
make[1]: *** [first_rule] Error 2
make: *** [_dir_mm] Error 2



