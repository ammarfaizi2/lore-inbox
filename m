Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVKFIuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVKFIuq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVKFIuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:50:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23049 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932338AbVKFIup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 03:50:45 -0500
Date: Sun, 6 Nov 2005 08:50:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Failure: ARM clps7500
Message-ID: <20051106085034.GD25134@flint.arm.linux.org.uk>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051103095840.GA28038@flint.arm.linux.org.uk> <1131055419.14985.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131055419.14985.7.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 05:03:39PM -0500, Trond Myklebust wrote:
> On Thu, 2005-11-03 at 09:58 +0000, Russell King wrote:
> > This default configuration (arch/arm/configs/clps7500_defconfig) fails
> > to build:
> > 
> >   LD      .tmp_vmlinux1
> > net/built-in.o: In function `xs_bindresvport':
> > stats.c:(.text+0x54654): undefined reference to `xprt_min_resvport'
> > stats.c:(.text+0x54658): undefined reference to `xprt_max_resvport'
> > net/built-in.o: In function `xs_setup_tcp':
> > stats.c:(.text+0x54bcc): undefined reference to `xprt_tcp_slot_table_entries'
> > stats.c:(.text+0x54bd0): undefined reference to `xprt_max_resvport'
> > net/built-in.o: In function `xs_setup_udp':
> > stats.c:(.text+0x54d34): undefined reference to `xprt_udp_slot_table_entries'
> > stats.c:(.text+0x54d38): undefined reference to `xprt_max_resvport'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > Maybe related to CONFIG_SYSCTL=n ?
> 
> The following patch should fix it:
> 
> http://client.linux-nfs.org/Linux-2.6.x/2.6.14/linux-2.6.14-96-fix_rpc_nosysctl.dif

Thanks, I assume this got merged since clps7500 has started building
again.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
