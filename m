Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVKCJ6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVKCJ6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 04:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVKCJ6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 04:58:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65288 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932351AbVKCJ6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 04:58:45 -0500
Date: Thu, 3 Nov 2005 09:58:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       trond.myklebust@fys.uio.no
Subject: Failure: ARM clps7500
Message-ID: <20051103095840.GA28038@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	trond.myklebust@fys.uio.no
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This default configuration (arch/arm/configs/clps7500_defconfig) fails
to build:

  LD      .tmp_vmlinux1
net/built-in.o: In function `xs_bindresvport':
stats.c:(.text+0x54654): undefined reference to `xprt_min_resvport'
stats.c:(.text+0x54658): undefined reference to `xprt_max_resvport'
net/built-in.o: In function `xs_setup_tcp':
stats.c:(.text+0x54bcc): undefined reference to `xprt_tcp_slot_table_entries'
stats.c:(.text+0x54bd0): undefined reference to `xprt_max_resvport'
net/built-in.o: In function `xs_setup_udp':
stats.c:(.text+0x54d34): undefined reference to `xprt_udp_slot_table_entries'
stats.c:(.text+0x54d38): undefined reference to `xprt_max_resvport'
make: *** [.tmp_vmlinux1] Error 1

Maybe related to CONFIG_SYSCTL=n ?

Complete build log:

http://armlinux.simtec.co.uk/kautobuild/2.6.14-git5/clps7500_defconfig/zimage.log


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
