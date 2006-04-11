Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWDKVeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWDKVeV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 17:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWDKVeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 17:34:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26845
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751124AbWDKVeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 17:34:20 -0400
Date: Tue, 11 Apr 2006 14:34:07 -0700 (PDT)
Message-Id: <20060411.143407.74615246.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: benoit.boissinot@ens-lyon.org, mb@bu3sch.de, netdev@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1144788541.19353.41.camel@localhost.localdomain>
References: <1144719972.19353.24.camel@localhost.localdomain>
	<20060410.224933.39567033.davem@davemloft.net>
	<1144788541.19353.41.camel@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Apr 2006 06:49:00 +1000

> I would tend to agree... except that the broadcom is _the_ wireless
> card shipped by Apple with all of their machines for the last few
> years, and thus, the problem will be hit by pretty much any G5 user
> trying to use theirs...
>
> I don't have another idea on how to fix that at hand... a dma mask
> limit in the iommu layer is fairly easy to implement with our iommu
> implementation (though it wouldn't work on pseries where ranges are
> allocated per slot, but it would work fine on a g5). Still sounds
> better than introducing a ZONE_DMA separate from ZONE_NORMAL ...

I still think we shouldn't reward shit hardware by complicating
up our DMA mappings internals. :-)

If you're going to do it anyways, we use a nearly identical
allocation bitmap algorithm under sparc64 so maybe you can
take a stab at trying to put your code there too.  I'm more
than happy to test and integrate.

Thanks.
