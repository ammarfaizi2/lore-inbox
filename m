Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbSLMXnk>; Fri, 13 Dec 2002 18:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbSLMXnk>; Fri, 13 Dec 2002 18:43:40 -0500
Received: from dsl-213-023-066-131.arcor-ip.net ([213.23.66.131]:12951 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP
	id <S265633AbSLMXni>; Fri, 13 Dec 2002 18:43:38 -0500
Date: Sat, 14 Dec 2002 00:49:59 +0100
From: axel@pearbough.net
To: lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Compiling iproute2(w/HTB patch) for 2.5.51
Message-ID: <20021213234959.GA31994@neon.pearbough.net>
Mail-Followup-To: lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org,
	kuznet@ms2.inr.ac.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: pearbough.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

having read an article about QoS and HTB in a German computer magazine I
wanted to implement such thing on my linux router running kernel 2.5.51.
First I patched the iproute2-020116.tar.gz package with the htb3.6_tc.diff 
from http://luxik.cdi.cz/~devik/qos/htb/ and started building it. But
unfortunately it resulted in strange compile errors I do not understand.

Hope this is some help for you and I am not doing something terribly wrong.

Best regards,
Axel Siebenwirth

make[1]: Entering directory /usr/local/src/iproute2/misc'
gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -g -I../include-glibc
-I/usr/include/db3 -include ../include-glibc/glibc-bugs.h
-I/usr/src/linux/include -I../include -DRESOLVE_HOSTNAMES   -c -o ss.o ss.c
In file included from /usr/src/linux/include/linux/skbuff.h:19,
                 from /usr/src/linux/include/linux/tcp.h:20,
                 from ss.c:36:
/usr/src/linux/include/linux/time.h:9: redefinition of `struct timespec'
/usr/src/linux/include/linux/time.h:15: redefinition of `struct timeval'
In file included from /usr/src/linux/include/linux/skbuff.h:19,
                 from /usr/src/linux/include/linux/tcp.h:20,
                 from ss.c:36:
/usr/src/linux/include/linux/time.h:146:1: warning: "FD_SET" redefined
In file included from /usr/include/sys/types.h:215,
                 from ../include-glibc/glibc-bugs.h:5,
                 from <command line>:1:
/usr/include/sys/select.h:89:1: warning: this is the location of the
previous definition
In file included from /usr/src/linux/include/linux/skbuff.h:19,
                 from /usr/src/linux/include/linux/tcp.h:20,
                 from ss.c:36:
/usr/src/linux/include/linux/time.h:147:1: warning: "FD_CLR" redefined
In file included from /usr/include/sys/types.h:215,
                 from ../include-glibc/glibc-bugs.h:5,
                 from <command line>:1:
/usr/include/sys/select.h:90:1: warning: this is the location of the
previous definition
In file included from /usr/src/linux/include/linux/skbuff.h:19,
                 from /usr/src/linux/include/linux/tcp.h:20,
                 from ss.c:36:
/usr/src/linux/include/linux/time.h:148:1: warning: "FD_ISSET" redefined
In file included from /usr/include/sys/types.h:215,
                 from ../include-glibc/glibc-bugs.h:5,
                 from <command line>:1:
/usr/include/sys/select.h:91:1: warning: this is the location of the
previous definition
In file included from /usr/src/linux/include/linux/skbuff.h:19,
                 from /usr/src/linux/include/linux/tcp.h:20,
                 from ss.c:36:
/usr/src/linux/include/linux/time.h:149:1: warning: "FD_ZERO" redefined
In file included from /usr/include/sys/types.h:215,
                 from ../include-glibc/glibc-bugs.h:5,
                 from <command line>:1:
/usr/include/sys/select.h:92:1: warning: this is the location of the
previous definition
In file included from /usr/src/linux/include/linux/sched.h:12,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/skbuff.h:25,
                 from /usr/src/linux/include/linux/tcp.h:20,
                 from ss.c:36:
/usr/src/linux/include/linux/jiffies.h:11: parse error before "jiffies_64"
/usr/src/linux/include/linux/jiffies.h:11: warning: type defaults to 	nt'
in declaration of 
iffies_64'
/usr/src/linux/include/linux/jiffies.h:11: warning: data definition has no
type
or storage class
In file included from /usr/src/linux/include/linux/sched.h:20,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/skbuff.h:25,
                 from /usr/src/linux/include/linux/tcp.h:20,
                 from ss.c:36:
/usr/src/linux/include/asm/mmu.h:13: field `sem' has incomplete type
/usr/src/linux/include/asm/mmu.h:15: confused by earlier errors, bailing out
make[1]: *** [ss.o] Error 1
make[1]: Leaving directory /usr/local/src/iproute2/misc'
