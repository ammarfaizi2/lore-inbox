Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132041AbRAFCdN>; Fri, 5 Jan 2001 21:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132676AbRAFCdD>; Fri, 5 Jan 2001 21:33:03 -0500
Received: from spitfire.velocet.net ([209.167.225.66]:59142 "HELO
	spitfire.velocet.net") by vger.kernel.org with SMTP
	id <S132041AbRAFCcz>; Fri, 5 Jan 2001 21:32:55 -0500
Message-ID: <3A5683D8.962C02CD@email.com>
Date: Fri, 05 Jan 2001 21:32:56 -0500
From: Aaron Bentley <aaron_bentley@email.com>
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ksyms.ver redefines various CPU-related macros
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for 2.4.0.  Here's a bug. . .

Compiling for Celeron with SMP disabled causes large quantities of
warnings about macros being redefined in i386_ksyms.ver

With SMP on, it does not happen.

Aaron Bentley


/usr/src/linux-2.4.0/include/linux/modules/i386_ksyms.ver:78: warning:
`cpu_data
' redefined
/usr/src/linux-2.4.0/include/asm/processor.h:78: warning: this is the
location o
f the previous definition
/usr/src/linux-2.4.0/include/linux/modules/i386_ksyms.ver:82: warning:
`smp_num_
cpus' redefined
/usr/src/linux-2.4.0/include/linux/smp.h:80: warning: this is the
location of th
e previous definition
/usr/src/linux-2.4.0/include/linux/modules/i386_ksyms.ver:84: warning:
`cpu_onli
ne_map' redefined
/usr/src/linux-2.4.0/include/linux/smp.h:88: warning: this is the
location of th
e previous definition
/usr/src/linux-2.4.0/include/linux/modules/i386_ksyms.ver:98: warning:
`smp_call
_function' redefined
/usr/src/linux-2.4.0/include/linux/smp.h:87: warning: this is the
location of th
e previous definition
In file included from
/usr/src/linux-2.4.0/include/linux/modversions.h:117,
                 from /usr/src/linux-2.4.0/include/linux/module.h:21,
                 from netfilter.c:18:
/usr/src/linux-2.4.0/include/linux/modules/ksyms.ver:504: warning:
`del_timer_sy
nc' redefined
/usr/src/linux-2.4.0/include/linux/timer.h:34: warning: this is the
location of
the previous definition
In file included from /usr/src/linux-2.4.0/include/linux/interrupt.h:45,
                 from netfilter.c:19:
/usr/src/linux-2.4.0/include/asm/hardirq.h:37: warning:
`synchronize_irq' redefi
ned
/usr/src/linux-2.4.0/include/linux/modules/i386_ksyms.ver:86: warning:
this is t
he location of the previous definition
rm -f core.o
ld -m elf_i386  -r -o core.o sock.o skbuff.o iovec.o datagram.o scm.o
sysctl_net
_core.o dev.o dev_mcast.o dst.o neighbour.o rtnetlink.o utils.o
netfilter.o
make[3]: Leaving directory `/usr/src/linux-2.4.0/net/core'
make[2]: Leaving directory `/usr/src/linux-2.4.0/net/core'
make -C ethernet
make[2]: Entering directory `/usr/src/linux-2.4.0/net/ethernet'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.4.0/net/ethernet'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.0/include -Wall
-Wstrict-prototypes -O2 -f
omit-frame-pointer -fno-strict-aliasing -pipe  -march=i686    -c -o
eth.o eth.c
-- 
Aaron Bentley
Keep posted on my news and performances:
abmusic-subscribe@topica.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
