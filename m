Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbSKWP4B>; Sat, 23 Nov 2002 10:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbSKWP4B>; Sat, 23 Nov 2002 10:56:01 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:56844 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267052AbSKWP4A>; Sat, 23 Nov 2002 10:56:00 -0500
Date: Sat, 23 Nov 2002 16:03:07 +0000
From: Loic Jaquemet <jal@les3stagiaires.freeserve.co.uk>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linux netdev <linux-netdev@oss.sgi.com>
Subject: 2.5.49 doesn't compile - IPSEC symbole missing for linking
Message-Id: <20021123160307.05049096.jal@les3stagiaires.freeserve.co.uk>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


echo '  Generating build number'
  Generating build number
. scripts/mkversion > .tmp_version
mv -f .tmp_version .version
make -f scripts/Makefile.build obj=init
  Generating include/linux/compile.h (not modified)
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
net/built-in.o(.text+0x4b400): In function `skb_ah_walk':
: référence indéfinie vers « crypto_hmac_update »
net/built-in.o(.text+0x4b47b): In function `skb_ah_walk':
: référence indéfinie vers « crypto_hmac_update »
net/built-in.o(.text+0x4b566): In function `ah_hmac_digest':
: référence indéfinie vers « crypto_hmac_init »
net/built-in.o(.text+0x4b57c): In function `ah_hmac_digest':
: référence indéfinie vers « crypto_hmac_final »
net/built-in.o(.text+0x4c459): In function `esp_hmac_digest':
: référence indéfinie vers « crypto_hmac_init »
net/built-in.o(.text+0x4c479): In function `esp_hmac_digest':
: référence indéfinie vers « crypto_hmac_final »
make: *** [.tmp_vmlinux1] Erreur 1



#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
# CONFIG_XFRM_USER is not set



-- 
+----------------------------------------------+
|Jaquemet Loic                                 |
|Eleve ingenieur en informatique FIIFO, ORSAY  |
+----------------------------------------------+
http://sourceforge.net/projects/ffss/
#wirelessfr @ irc.freenode.net
