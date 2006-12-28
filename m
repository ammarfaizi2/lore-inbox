Return-Path: <linux-kernel-owner+w=401wt.eu-S964961AbWL1Ves@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWL1Ves (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbWL1Ves
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:34:48 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2877 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993AbWL1Ves (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:34:48 -0500
Date: Thu, 28 Dec 2006 21:34:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
Message-ID: <20061228213438.GD20596@flint.arm.linux.org.uk>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de> <20061228124644.4e1ed32b.akpm@osdl.org> <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de> <20061228210803.GR17561@ftp.linux.org.uk> <Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 10:18:12PM +0100, Tim Schmielau wrote:
> On Thu, 28 Dec 2006, Al Viro wrote:
> 
> > Uh-huh.  How much of build coverage have you got with it?
> 
> Well, as said in the patch description, I compiled alpha, arm, i386, ia64, 
> mips, powerpc, and x86_64 with allnoconfig, defconfig, allmodconfig, and 
> allyesconfig as well as a few randconfigs on x86_64. I also checked that 
> no new warnings were introduced by the patch.

That would not have covered the following drivers in this patch on ARM
then:

acorn/*
nwflash
i2c-iop3xx
i2c-s3c2410
ether1
ether3
etherh
omap_cf
pxa2xx_lubbock
sa1100_badge4
sa1100_cerf
sa1100_h3600
sa1100_jornada720
sa1100_neponset
sa1100_shannon
sa1100_simpad
acornscsi
arxescsi
cumana_1
cumana_2
ecoscsi
eesox
fas216
oak
powertec
at91_udc
omap_udc
pxa2xx_udc
zaurus

To cover these, you need to build at least rpc_defconfig, lubbock_defconfig,
netwinder_defconfig, badge4_defconfig, cerf_defconfig, ...etc...

The whole "all*config" idea on ARM is utterly useless - you can _not_
get build coverage that way.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
