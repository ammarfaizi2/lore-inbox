Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281807AbRK0XBy>; Tue, 27 Nov 2001 18:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281808AbRK0XBe>; Tue, 27 Nov 2001 18:01:34 -0500
Received: from cc78409-a.hnglo1.ov.nl.home.com ([212.120.97.185]:11909 "EHLO
	dexter.hensema.xs4all.nl") by vger.kernel.org with ESMTP
	id <S281807AbRK0XB1>; Tue, 27 Nov 2001 18:01:27 -0500
From: spamtrap@use.reply-to (Erik Hensema)
Subject: Re: 2.5.1-pre2: ipv6 module compile fails
Date: 27 Nov 2001 23:01:17 GMT
Message-ID: <slrna086pt.8et.spamtrap@dexter.hensema.xs4all.nl>
In-Reply-To: <3C041272.5070401@springboardhosting.com>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.6.3 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duane Toler (dtoler@springboardhosting.com) wrote:
>gcc -D__KERNEL__ -I/usr/src/linux-2.5.0/include -Wall -Wstrict-prototypes -Wno-trigraphs 
>-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
>-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include 
>/usr/src/linux-2.5.0/include/linux/modversions.h   -c -o ndisc.o ndisc.c
>{standard input}: Assembler messages:
>{standard input}:821: Error: bad register name `%edxadcl 4(%ebp)'
>{standard input}:1024: Error: bad register name `%ecxadcl 4(%edx)'
>{standard input}:1186: Error: bad register name `%ecxadcl 4(%edx)'
>{standard input}:2272: Error: bad register name `%ecxadcl 4(%esi)'
>make[2]: *** [ndisc.o] Error 1
>make[2]: Leaving directory `/usr/src/linux-2.5.0/net/ipv6'
>make[1]: *** [_modsubdir_ipv6] Error 2
>make[1]: Leaving directory `/usr/src/linux-2.5.0/net'
>make: *** [_mod_net] Error 2

I've got the exact same error.

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

I'm using an up-to-date system, AFAIK (Suse 7.1 + upgrades):
 
Linux dexter 2.5.1-pre1 #5 Tue Nov 27 13:55:35 CET 2001 i586 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.10q
mount                  2.10q
modutils               2.4.2
e2fsprogs              1.25
pcmcia-cs              3.1.22
Linux C Library        x    1 root     root      1382179 Feb 28  2001 /lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         ipt_MASQUERADE ip_nat_ftp ipt_state ipt_LOG ipt_limit iptable_nat iptable_filter ip_conntrack_irc ip_conntrack_ftp ip_conntrack ip_tables ne 8390 tulip es1370 soundcore

-- 
Erik Hensema (erik@hensema.net)
I'm on the list, no need to Cc: me, though I appreciate one if your
mailer doesn't support the References header.
