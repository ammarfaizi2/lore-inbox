Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261960AbRE0NNB>; Sun, 27 May 2001 09:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbRE0NMv>; Sun, 27 May 2001 09:12:51 -0400
Received: from web10406.mail.yahoo.com ([216.136.130.98]:8210 "HELO
	web10406.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261960AbRE0NMh>; Sun, 27 May 2001 09:12:37 -0400
Message-ID: <20010527131236.74332.qmail@web10406.mail.yahoo.com>
Date: Sun, 27 May 2001 23:12:36 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Report several problem with kernel 2.4.5-ac1 ....
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone..

1. 

I got the kernel hang when I tried to run pppd without
any argument on the console (tty1 or tty2...); just
try to run

pppd

Sorry I can not copy all text here but this problem is
re-producible and wont happen if I run on pts/1 (for
example on xterm or rxvt )

pppd version 2.4.x
kernel 2.4.5-ac1
Debian 2.2.r3 with support for running kernel 2.4.x
(means every utilities is Ok)
i486 100Mhz 35Mb RAM
all kernel compile with gcc 2.95.2

2.

Another thing I noticed is 2.4.5-ac1 uses more swap
than 2.4.4 in the same situation and in my machine,
performance is a bit worse than 2.4.4 (have not test
with 2.4.5).

3.

In parport_pc.c the error:
parport_pc_find_ports 2618 too many arguments to
function parport_pc_init_superio

when compiling modules IF YOU DONT ENABLE PCI support
in the kernel config. From 2.4.4-pre6 up (not sure
exactly 6 or 5 something). First I dont know why
nobody reports this problem, but later I know the
reason is PCI is disabled. when trying to read the
code in parport_pc.c . And unfortunately I got the
rather rare machine not having PCI Bus...
so from that on I have to select PCI even I dont have
PCI system.

Thanks,



_____________________________________________________________________________
http://messenger.yahoo.com.au - Yahoo! Messenger
- Voice chat, mail alerts, stock quotes and favourite news and lots more!
