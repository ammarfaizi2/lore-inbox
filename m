Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288668AbSAIBBm>; Tue, 8 Jan 2002 20:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288669AbSAIBBd>; Tue, 8 Jan 2002 20:01:33 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:3474 "EHLO
	theirongiant.zip.net.au") by vger.kernel.org with ESMTP
	id <S288668AbSAIBBZ>; Tue, 8 Jan 2002 20:01:25 -0500
Date: Wed, 9 Jan 2002 12:01:22 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: undefined reference to `local symbols in discarded section .text.exit
Message-ID: <20020109010122.GC822@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have modules and hotplug turned on (but nothing turned on in the
hotplug suboptions) but I get this error anyway:

        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
net/network.o(.text.lock+0x1730): undefined reference to `local symbols
in discarded section .text.exit'
make: *** [vmlinux] Error 1

I've tried to track it down but I can't find what is triggering it. This
is with 2.4.18-pre2 with the following net related config options in:

CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_PPP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPPOE=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_SYN_COOKIES=y

Help? I can't compile 2 kernels cos of this now and I need to with one
of them to try and track down a netfilter bug (this isn't the config
section for that kernel though).

-- 
SOCCER PLAYER IN GENITAL-BITING SCANDAL  ---  "It was something between
friends that I thought would have no importance until this morning when
I got up and saw all  the commotion in the news,"  Gallardo told a news
conference. "It stunned me."
Reyes told Marca that he had "felt a slight pinch."
