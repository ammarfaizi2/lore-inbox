Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280756AbRKGEJG>; Tue, 6 Nov 2001 23:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280761AbRKGEI5>; Tue, 6 Nov 2001 23:08:57 -0500
Received: from zok.SGI.COM ([204.94.215.101]:33228 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S280756AbRKGEIq>;
	Tue, 6 Nov 2001 23:08:46 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 net errors
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Nov 2001 15:08:38 +1100
Message-ID: <27124.1005106118@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile a minimal 2.4.14 kernel, everything set to N.

include/net/tcp_ecn.h: In function `TCP_ECN_send':
In file included from include/net/tcp.h:1036,
                 from net/core/sock.c:122:
		 include/net/tcp_ecn.h:54: union has no member named `af_inet'
		 include/net/tcp_ecn.h:61: union has no member named `af_inet'

# CONFIG_NET is not set
# CONFIG_PCI is not set
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_SYSCTL is not set
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_ELF is not set
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_APM is not set

kbuild 2.5 has a note in net/core/Makefile.in

# FIXME: this always selects these objects, even when CONFIG_NET is
# 'n'.  Probably wrong but 2.4.0-test13-pre4 did the same.  KAO

select(sock.o skbuff.o iovec.o datagram.o scm.o)

Why do we compile these objects even when CONFIG_NET=n?

