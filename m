Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754381AbWKHHCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbWKHHCx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 02:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754382AbWKHHCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 02:02:53 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16829
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1753781AbWKHHCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 02:02:52 -0500
Date: Tue, 07 Nov 2006 23:02:52 -0800 (PST)
Message-Id: <20061107.230252.38711277.davem@davemloft.net>
To: akpm@osdl.org
Cc: kamezawa.hiroyu@jp.fujitsu.com, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-ia64@vger.kernel.org, auke-jan.h.kok@intel.com, jeff@garzik.org
Subject: Re: [BUG] [2.6.19-rc4-mm2] can't compile
 drivers/acpi/processor_idle.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061107225259.0eff22d2.akpm@osdl.org>
References: <20061108150141.b792fbdb.kamezawa.hiroyu@jp.fujitsu.com>
	<20061107225259.0eff22d2.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Tue, 7 Nov 2006 22:52:59 -0800

> Also,
> 
> drivers/built-in.o(.text+0xd9a72): In function `e1000_xmit_frame':
> : undefined reference to `csum_ipv6_magic'
> 
> I don't know how this got broken.  ia64 seems to be the only architecture
> which doesn't have an implementation of csum_ipv6_magic().  This bug
> appears to be introduced by git-netdev-all.patch.

There is a generic version, which e1000 would get if it included
the net/ip_checksum.h header file.
