Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131236AbRC0LrM>; Tue, 27 Mar 2001 06:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRC0LrC>; Tue, 27 Mar 2001 06:47:02 -0500
Received: from bart.one-2-one.net ([195.94.80.12]:58121 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S131236AbRC0Lqr>; Tue, 27 Mar 2001 06:46:47 -0500
Date: Tue, 27 Mar 2001 13:47:37 +0200 (CEST)
From: Martin Diehl <home@mdiehl.de>
To: linux-kernel@vger.kernel.org
cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Subject: issue with 243-pre8: undefined symbols from net_init.c
Message-ID: <Pine.LNX.4.21.0103271300050.2735-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

for me, vanilla 2.4.3-pre8 refuses to load NIC-modules (8390,ne2k-pci) due
to unresolved symbol: ether_setup
might be related to latest changes at drivers/net/net_init.c

from /proc/ksyms I get:

c024dc8c kbd_ledfunc_Rfa67cc5f
c01ebf8c keyboard_tasklet_R28aa0faa
c024dc84 sysrq_power_off_R0c257849
c0166da4 __VERSIONED_SYMBOL(init_etherdev)
c0166dc0 __VERSIONED_SYMBOL(alloc_etherdev)
c0166e38 __VERSIONED_SYMBOL(ether_setup)
c0166ec4 __VERSIONED_SYMBOL(register_netdev)
c0166f34 __VERSIONED_SYMBOL(unregister_netdev)
c0167030 autoirq_setup_R5a5a2280
c016703c autoirq_report_R84530c53
c024f080 ide_hwifs_R11123430

All the bogus __VERSIONED_SYMBOL stuff is from net_init.c

Regards
Martin

