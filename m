Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262615AbSJIS6s>; Wed, 9 Oct 2002 14:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSJIS6s>; Wed, 9 Oct 2002 14:58:48 -0400
Received: from host-63-69-231-252.verestar.net ([63.69.231.252]:35694 "EHLO
	venus.tis.com.ar") by vger.kernel.org with ESMTP id <S262615AbSJIS6q>;
	Wed, 9 Oct 2002 14:58:46 -0400
Message-ID: <3DA47DA1.4050804@technisys.com.ar>
Date: Wed, 09 Oct 2002 16:04:01 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Lichtmaier?= <nick@technisys.com.ar>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020830
X-Accept-Language: es, es-ar, en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.41 does not build: ipv6/addrconf.c: case label (htonln(something))
 does not reduce to an integer constant
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,net/ipv6/.addrconf.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include 
-DMODULE   -DKBUILD_BASENAME=addrconf   -c -o net/ipv6/addrconf.o 
net/ipv6/addrconf.c
net/ipv6/addrconf.c: In function `ipv6_addr_type':
net/ipv6/addrconf.c:155: case label does not reduce to an integer constant
net/ipv6/addrconf.c:159: case label does not reduce to an integer constant
net/ipv6/addrconf.c:163: case label does not reduce to an integer constant
net/ipv6/addrconf.c:156: warning: unreachable code at beginning of 
switch statement
make[3]: *** [net/ipv6/addrconf.o] Error 1
make[2]: *** [net/ipv6] Error 2
make[1]: *** [net] Error 2
make[1]: Leaving directory `/home/nick/soft/linux-2.5.41'
make: *** [stamp-build] Error 2

In that line:
                switch((st & htonl(0x00FF0000))) {
                        case htonl(0x00010000):

Perhaps it's a matter of includes again.

Thanks!

