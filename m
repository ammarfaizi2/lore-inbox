Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261814AbTCVBjb>; Fri, 21 Mar 2003 20:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261816AbTCVBjb>; Fri, 21 Mar 2003 20:39:31 -0500
Received: from main.gmane.org ([80.91.224.249]:10942 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261814AbTCVBja>;
	Fri, 21 Mar 2003 20:39:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: michael.mauch@gmx.de (Michael Mauch)
Subject: Re: [2.4.21-pre5] compile error in ip_conntrack_ftp.c:440:
Date: Sat, 22 Mar 2003 02:31:50 +0100
Organization: no
Message-ID: <61rskxlnt.ln2@elmicha.333200002251-0001.dialin.t-online.de>
References: <b44s65$pdl$1@main.gmane.org>
X-Complaints-To: usenet@main.gmane.org
User-Agent: tin/1.5.16-20030125 ("Bubbles") (UNIX) (Linux/2.4.19 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Metzler <lkml-2003-03@downhill.at.eu.org> wrote:
> Since iirc 2.4.20 I get this error when compiling a kernel:
> |-------------------
> | make[2]: Entering directory `/tmp/KERNEL/linux-2.4.20-pre5/net/ipv4/netfilter'
> | make[2]: Circular /tmp/KERNEL/linux-2.4.20-pre5/include/linux/netfilter_ipv4/ip_conntrack_helper.h <- /tmp/KERNEL/linux-2.4.20-pre5/include/linux/netfilter_ipv4/ip_conntrack.h dependency dropped.
> | ld -m elf_i386 -r -o ip_conntrack.o ip_conntrack_standalone.o ip_conntrack_core.o ip_conntrack_proto_generic.o ip_conntrack_proto_tcp.o ip_conntrack_proto_udp.o ip_conntrack_proto_icmp.o
> | gcc -D__KERNEL__ -I/tmp/KERNEL/linux-2.4.20-pre5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ip_conntrack_ftp  -c -o ip_conntrack_ftp.o ip_conntrack_ftp.c
> | ip_conntrack_ftp.c:440: parse error before `this_object_must_be_defined_as_export_objs_in_the_Makefile'
> | ip_conntrack_ftp.c:440: warning: type defaults to `int' in declaration of `this_object_must_be_defined_as_export_objs_in_the_Makefile'
> | ip_conntrack_ftp.c:440: warning: data definition has no type or storage class
> | make[2]: *** [ip_conntrack_ftp.o] Error 1
> | make[2]: Leaving directory `/tmp/KERNEL/linux-2.4.20-pre5/net/ipv4/netfilter'
> | make[1]: *** [_modsubdir_ipv4/netfilter] Error 2
> | make[1]: Leaving directory `/tmp/KERNEL/linux-2.4.20-pre5/net'
> | make: *** [_mod_net] Error 2
> |-------------------

> CONFIG_IP_NF_CONNTRACK=m
> CONFIG_IP_NF_FTP=m
> CONFIG_IP_NF_IRC=m
> CONFIG_IP_NF_IPTABLES=m

I got the same error. With

CONFIG_IP_NF_MATCH_CONNTRACK=m

(Connection tracking match support), the error disappears. 

Regards...
		Michael

