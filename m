Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281472AbRKHFgF>; Thu, 8 Nov 2001 00:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281473AbRKHFfz>; Thu, 8 Nov 2001 00:35:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39310 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281472AbRKHFfk>;
	Thu, 8 Nov 2001 00:35:40 -0500
Date: Wed, 07 Nov 2001 21:35:34 -0800 (PST)
Message-Id: <20011107.213534.83623888.davem@redhat.com>
To: xanni@glasswings.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipchains.o dependencies problem from 1999 (!) returns in
 2.4.14 kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011108125851.K673@kira.glasswings.com.au>
In-Reply-To: <20011108125851.K673@kira.glasswings.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Pam <xanni@glasswings.com.au>
   Date: Thu, 8 Nov 2001 12:58:51 +1100

   In the 2.4.14 kernel, I get the following dependency problems with ipchains.o:
   
   [root@TekTih root]# depmod -ae
   depmod: *** Unresolved symbols in /lib/modules/2.4.14+ext3/kernel/net/ipv4/netfilter/ipchains.o
   depmod:         netlink_kernel_create
   depmod:         netlink_broadcast
   
   Note that this happens regardless of the setting of CONFIG_NETLINK and
   CONFIG_NETLINK_DEV, whether "n", "m" or "y".

Something is wrong with your modutils then.

Because net/netsyms.c exports netlink_kernel_create when
CONFIG_NETLINK is set.  It is impossible for the symbol to be
unresolved if you are turning on CONFIG_NETLINK.

Franks a lot,
David S. Miller
davem@redhat.com
