Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261992AbSJITC3>; Wed, 9 Oct 2002 15:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262007AbSJITC2>; Wed, 9 Oct 2002 15:02:28 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:12966 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261992AbSJITC1> convert rfc822-to-8bit; Wed, 9 Oct 2002 15:02:27 -0400
Subject: Re: 2.5.41 does not build: ipv6/addrconf.c: case label
	(htonln(something)) does not reduce to an integer constant
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?Nicol=E1s?= Lichtmaier <nick@technisys.com.ar>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DA47DA1.4050804@technisys.com.ar>
References: <3DA47DA1.4050804@technisys.com.ar>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 20:18:05 +0100
Message-Id: <1034191085.2044.84.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 20:04, Nicolás Lichtmaier wrote:
>   gcc -Wp,-MD,net/ipv6/.addrconf.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include 
> -DMODULE   -DKBUILD_BASENAME=addrconf   -c -o net/ipv6/addrconf.o 
> net/ipv6/addrconf.c
> net/ipv6/addrconf.c: In function `ipv6_addr_type':
> net/ipv6/addrconf.c:155: case label does not reduce to an integer constant
> net/ipv6/addrconf.c:159: case label does not reduce to an integer constant
> net/ipv6/addrconf.c:163: case label does not reduce to an integer constant
> net/ipv6/addrconf.c:156: warning: unreachable code at beginning of 

Grab the patch to that file from 2.5.41-ac and you'll be fine. Dave
'bigendian' Miller says its fixed in the main tree now

