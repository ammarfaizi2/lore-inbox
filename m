Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWDKFtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWDKFtt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 01:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWDKFtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 01:49:49 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:45491
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751233AbWDKFts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 01:49:48 -0400
Date: Mon, 10 Apr 2006 22:49:33 -0700 (PDT)
Message-Id: <20060410.224933.39567033.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: benoit.boissinot@ens-lyon.org, mb@bu3sch.de, netdev@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1144719972.19353.24.camel@localhost.localdomain>
References: <200604100607.33362.mb@bu3sch.de>
	<20060410042228.GN27596@ens-lyon.fr>
	<1144719972.19353.24.camel@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 11 Apr 2006 11:46:12 +1000

> But ppc64 hits the problem and at this point, there is nothing
> I can do other than either implementing a split zone allocation mecanism
> in the ppc64 architecture for the sole sake of bcm43xx (ick !) or doing
> some trick with the iommu...

I think allowing DMA mask range limiting in the IOMMU layer is going
to set a very bad precedence, just don't do it.

It's 2006, we should be way past the era of not putting the full 32
PCI DMA address bits in devices.  In this day and age it is simply
inexscusable.

Maybe we could understand chips coming out 8 years ago when a lot of
designs were transitioning from ISA to PCI, but that no longer applies
in any way today.
