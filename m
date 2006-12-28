Return-Path: <linux-kernel-owner+w=401wt.eu-S1755004AbWL1VlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbWL1VlA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755005AbWL1Vk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:40:59 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:22606 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993AbWL1Vk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:40:59 -0500
Date: Thu, 28 Dec 2006 13:32:46 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
Message-Id: <20061228133246.ad820c6a.randy.dunlap@oracle.com>
In-Reply-To: <20061228213438.GD20596@flint.arm.linux.org.uk>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
	<20061228124644.4e1ed32b.akpm@osdl.org>
	<Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de>
	<20061228210803.GR17561@ftp.linux.org.uk>
	<Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de>
	<20061228213438.GD20596@flint.arm.linux.org.uk>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 21:34:38 +0000 Russell King wrote:

> On Thu, Dec 28, 2006 at 10:18:12PM +0100, Tim Schmielau wrote:
> > On Thu, 28 Dec 2006, Al Viro wrote:
> > 
> > > Uh-huh.  How much of build coverage have you got with it?
> > 
> > Well, as said in the patch description, I compiled alpha, arm, i386, ia64, 
> > mips, powerpc, and x86_64 with allnoconfig, defconfig, allmodconfig, and 
> > allyesconfig as well as a few randconfigs on x86_64. I also checked that 
> > no new warnings were introduced by the patch.
> 
> That would not have covered the following drivers in this patch on ARM
> then:
> 
> acorn/*
> nwflash
> i2c-iop3xx
> i2c-s3c2410
> ether1
> ether3
> etherh
> omap_cf
> pxa2xx_lubbock
> sa1100_badge4
> sa1100_cerf
> sa1100_h3600
> sa1100_jornada720
> sa1100_neponset
> sa1100_shannon
> sa1100_simpad
> acornscsi
> arxescsi
> cumana_1
> cumana_2
> ecoscsi
> eesox
> fas216
> oak
> powertec
> at91_udc
> omap_udc
> pxa2xx_udc
> zaurus
> 
> To cover these, you need to build at least rpc_defconfig, lubbock_defconfig,
> netwinder_defconfig, badge4_defconfig, cerf_defconfig, ...etc...
> 
> The whole "all*config" idea on ARM is utterly useless - you can _not_
> get build coverage that way.

Uh, can J. Random Developer submit patches to the ARM build system
for testing?

---
~Randy
