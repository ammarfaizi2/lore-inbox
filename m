Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVK3Vst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVK3Vst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbVK3Vst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:48:49 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54713
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750932AbVK3Vss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:48:48 -0500
Date: Wed, 30 Nov 2005 13:48:20 -0800 (PST)
Message-Id: <20051130.134820.19334664.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: vagabon.xyz@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051130165546.GD1053@flint.arm.linux.org.uk>
References: <20051130162327.GC1053@flint.arm.linux.org.uk>
	<cda58cb80511300845j18c81ce6p@mail.gmail.com>
	<20051130165546.GD1053@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Wed, 30 Nov 2005 16:55:47 +0000

> If other CPUs use this then fine, but I find that having config options
> needlessly available to all architectures is annoying - especially when
> they are never used.
> 
> Eg, would you ever expect to see a DM9000 ethernet device on an x86
> machine?  Probably not - there's far better PCI solutions now.

If I, for example, make changes across the tree to SKB handling, I'd
like to be able to build as many drivers as possible and fix up the
compile warnings and build failures before _you_ get to see them.

That's why it's a good idea to make drivers available to as many
platforms as possible, even if the hardware isn't necessarily
used there.
