Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUARIoE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 03:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266275AbUARIoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 03:44:04 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:26086 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S266259AbUARIoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 03:44:00 -0500
Date: Sun, 18 Jan 2004 09:43:59 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: Network Console for 2.4.x
Message-ID: <20040118084359.GA3384@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks!

I recently stumbled over the network console (written by 
Ingo Molnar, in 2001) and searched a little for up-to-date
implementations/adaptations to recent 2.4.x kernels ...

I found that Matt Mackall seems to maintain the netpoll
API/core system for 2.6.x and a recent 2.6 netconsole but 
unfortunately not for 2.4 ...

what I did was merging both, into an updated 2.4.x 
netconsole patch, which might come handy when you can't
attach a serial console and disk logging isn't very
useful (e.g. kernel debugging) ...

this netconsole patch now (hopefully) supports the same 
config interface which Matt's netpoll stuff uses, so 
the transition from one to the other should be smooth.

driver support is currently done for the folowing drivers:

drivers/net/3c503.c                 drivers/net/ne.c
drivers/net/3c59x.c                 drivers/net/ne2.c
drivers/net/8139too.c               drivers/net/ne2k-pci.c
drivers/net/ac3200.c                drivers/net/ne3210.c
drivers/net/apne.c                  drivers/net/oaknet.c
drivers/net/e100/e100_main.c        drivers/net/smc-mca.c
drivers/net/e1000/e1000_main.c      drivers/net/smc-ultra.c
drivers/net/e2100.c                 drivers/net/smc-ultra32.c
drivers/net/eepro100.c              drivers/net/stnic.c
drivers/net/es3210.c                drivers/net/tg3.c
drivers/net/hp-plus.c               drivers/net/tlan.c
drivers/net/hp.c                    drivers/net/tulip/tulip_core.c
drivers/net/hydra.c                 drivers/net/via-rhine.c
drivers/net/lne390.c                drivers/net/wd.c
drivers/net/mac8390.c               drivers/net/zorro8390.c

adding new drivers should not be too hard, let me know if 
you added support for <insert network driver here> ...

maybe this is useful for somebody, for sure it was for me!
available at:

http://www.13thfloor.at/patches/patch-2.4.24-nc0.01.diff
http://www.13thfloor.at/patches/patch-2.4.24-nc0.01.diff.gz
http://www.13thfloor.at/patches/patch-2.4.24-nc0.01.diff.bz2

enjoy,
Herbert

