Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbTCaNoH>; Mon, 31 Mar 2003 08:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbTCaNoH>; Mon, 31 Mar 2003 08:44:07 -0500
Received: from main.gmane.org ([80.91.224.249]:60040 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261638AbTCaNoG>;
	Mon, 31 Mar 2003 08:44:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Metzler <lkml-2003-03@downhill.at.eu.org>
Subject: Re: [2.4.21-pre5] compile error in ip_conntrack_ftp.c:440:
Date: Mon, 31 Mar 2003 13:55:12 +0000 (UTC)
Message-ID: <b69hc0$m1p$1@main.gmane.org>
References: <b44s65$pdl$1@main.gmane.org> <61rskxlnt.ln2@elmicha.333200002251-0001.dialin.t-online.de> <b5n43a$djn$1@main.gmane.org>
X-Complaints-To: usenet@main.gmane.org
X-Archive: encrypt
User-Agent: tin/1.5.17-20030326 ("Bubbles") (UNIX) (Linux/2.4.21-pre4 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Metzler wrote:
> Michael Mauch <michael.mauch@gmx.de> wrote:
>> Andreas Metzler wrote:
>>> Since iirc 2.4.20 I get this error when compiling a kernel:
>>> |-------------------
>>> | make[2]: Entering directory `/tmp/KERNEL/linux-2.4.20-pre5/net/ipv4/netfilter'
>>> | make[2]: Circular /tmp/KERNEL/linux-2.4.20-pre5/include/linux/netfilter_ipv4/ip_conntrack_helper.h <- /tmp/KERNEL/linux-2.4.20-pre5/include/linux/netfilter_ipv4/ip_conntrack.h dependency dropped.
>>> | ld -m elf_i386 -r -o ip_conntrack.o ip_conntrack_standalone.o ip_conntrack_core.o ip_conntrack_proto_generic.o ip_conntrack_proto_tcp.o ip_conntrack_proto_udp.o ip_conntrack_proto_icmp.o
>>> | gcc -D__KERNEL__ -I/tmp/KERNEL/linux-2.4.20-pre5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ip_conntrack_ftp  -c -o ip_conntrack_ftp.o ip_conntrack_ftp.c
>>> | ip_conntrack_ftp.c:440: parse error before `this_object_must_be_defined_as_export_objs_in_the_Makefile'
[...]
> This fixes neither the example I posted (add this line to initial
> minimal config, make menuconfig, make clean dep, make modules), nor the
> real world example
 
> http://www.logic.univie.ac.at/~ametzler/2.4.20.breaks.config
[...]

Still reproducible with 2.4.21-pre6.
                cu andreas

