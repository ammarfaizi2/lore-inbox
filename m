Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129712AbRCPNom>; Fri, 16 Mar 2001 08:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129496AbRCPNoc>; Fri, 16 Mar 2001 08:44:32 -0500
Received: from house.superbock.org ([194.38.148.241]:12302 "HELO
	faggot.house.superbock.org") by vger.kernel.org with SMTP
	id <S130216AbRCPNoX>; Fri, 16 Mar 2001 08:44:23 -0500
Message-ID: <3AB21A81.3080401@bigfoot.com>
Date: Fri, 16 Mar 2001 13:52:01 +0000
From: Delfim Machado <bipbip@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010217
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: smp or die ??!?!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i'm trying to compile my single cpu without the smp and it gives me a 
long compile errors ...

with the smp enable, i can compile all the kernel without any problems

KERNEL : 2.4.2 without any AC patch (hehhe)
CPU: PIII

<FLOOD>
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe 
-mpreferred-stack-boundary=2 -march=i686  -DUTS_MACHINE='"i386"' -c -o 
init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall 
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe 
-mpreferred-stack-boundary=2 -march=i686 " -C  kernel
make[1]: Entering directory `/usr/src/linux/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux/kernel'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe 
-mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c ksyms.c
In file included from /usr/src/linux/include/linux/modversions.h:94,
                from /usr/src/linux/include/linux/module.h:21,
                from ksyms.c:14:
/usr/src/linux/include/linux/modules/i386_ksyms.ver:76:25: warning: 
"cpu_data" redefined
/usr/src/linux/include/asm/processor.h:78:1: warning: this is the 
location of the previous definition
/usr/src/linux/include/linux/modules/i386_ksyms.ver:80:25: warning: 
"smp_num_cpus" redefined
/usr/src/linux/include/linux/smp.h:80:1: warning: this is the location 
of the previous definition
/usr/src/linux/include/linux/modules/i386_ksyms.ver:82:25: warning: 
"cpu_online_map" redefined
/usr/src/linux/include/linux/smp.h:88:1: warning: this is the location 
of the previous definition
/usr/src/linux/include/linux/modules/i386_ksyms.ver:96:33: warning: 
"smp_call_function" redefined
/usr/src/linux/include/linux/smp.h:87:1: warning: this is the location 
of the previous definition
In file included from /usr/src/linux/include/linux/modversions.h:118,
                from /usr/src/linux/include/linux/module.h:21,
                from ksyms.c:14:
/usr/src/linux/include/linux/modules/ksyms.ver:506:25: warning: 
"del_timer_sync" redefined
/usr/src/linux/include/linux/timer.h:34:1: warning: this is the location 
of the previous definition
In file included from /usr/src/linux/include/linux/interrupt.h:45,
                from ksyms.c:21:
/usr/src/linux/include/asm/hardirq.h:37:24: warning: "synchronize_irq" 
redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:84:1: warning: this 
is the location of the previous definition
In file included from ksyms.c:18:
/usr/src/linux/include/linux/kernel_stat.h: In function `kstat_irqs':
/usr/src/linux/include/linux/kernel_stat.h:48: `smp_num_cpus' undeclared 
(first use in this function)
/usr/src/linux/include/linux/kernel_stat.h:48: (Each undeclared 
identifier is reported only once
/usr/src/linux/include/linux/kernel_stat.h:48: for each function it 
appears in.)
make[2]: *** [ksyms.o] Error 1
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/kernel'
make: *** [_dir_kernel] Error 2
</FLOOD>

