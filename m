Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261944AbREMXIO>; Sun, 13 May 2001 19:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261946AbREMXHy>; Sun, 13 May 2001 19:07:54 -0400
Received: from pa7.solec.sdi.tpnet.pl ([213.77.165.7]:33997 "EHLO
	tower.braxis.co.uk") by vger.kernel.org with ESMTP
	id <S261944AbREMXHt>; Sun, 13 May 2001 19:07:49 -0400
Date: Mon, 14 May 2001 01:07:52 +0200 (CEST)
From: Piotr Wysocki <wysek@tower.braxis.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.5-pre1, iproute2 - IPv6
Message-ID: <Pine.LNX.4.33.0105140040010.2829-100000@tower.braxis.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have an unusual problem with compiling iproute2 on 2.4.5-pre1, this
problem didn't occur on my previous kernel - 2.4.2-ac3..
root@tower:~/progs/server/iproute2# uname -a
Linux tower 2.4.5-pre1-xfs #5 Sat May 12 12:55:39 CEST 2001 i686 unknown
root@tower:~/progs/server/iproute2# make
...
make[1]: Entering directory `/root/progs/server/iproute2/lib'
gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -g -I../include-glibc
-include ../include-glibc/glibc-bugs.h -I/usr/src/linux/include
-I../include -DRESOLVE_HOSTNAMES   -c -o ll_proto.o ll_proto.c
ll_proto.c:36: `ETH_P_ECHO' undeclared here (not in a function)
ll_proto.c:36: initializer element is not constant
ll_proto.c:36: (near initialization for `llproto_names[1].id')
make[1]: *** [ll_proto.o] Error 1
make[1]: Leaving directory `/root/progs/server/iproute2/lib'
make: *** [all] Error 2
root@tower:~/progs/server/iproute2# grep "ETH_P_ECHO"
/usr/src/linux/include/linux/if_ether.h
somebody@somewhere:somewhere$ grep "ETH_P_ECHO"
/usr/src/linux-2.2.19/include/linux/if_ether.h
#define ETH_P_ECHO      0x0200          /* Ethernet Echo packet */
<-- or sth like this..(not me was executing it..)
but
root@tower:~/progs/server/iproute2# grep "0x0200"
/usr/src/linux/include/linux/if_ether.h
#define ETH_P_PUP       0x0200          /* Xerox PUP packet             */

Maybe I have mailed to much output..I'm lame:)

I tried the compilation of 2 version of iproute2: current, and
2.2.4-now-ss001007. The error is the same..Why is it so? Do I do sth bad?
Or maybe there is a bug in the kernel..

-- 
  *--------"Being alive, you matter much more."--------*
 | Piotr Wysocki (wysek@tower.braxis.co.uk) [wysek/elk] |
 | telephone +48605 111115  | http://wysek.braxis.co.uk |
 | BLUG reg. member #0012   | Linux reg. member #207707 |

