Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWGDGZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWGDGZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 02:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWGDGZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 02:25:58 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:47254 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751253AbWGDGZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 02:25:58 -0400
Subject: Re: [Ubuntu PATCH] Build mmc_block into mmc_core directly
From: Marcel Holtmann <marcel@holtmann.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
In-Reply-To: <20060703204830.GA24978@flint.arm.linux.org.uk>
References: <44A98210.2060208@oracle.com>
	 <20060703204830.GA24978@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 08:25:19 +0200
Message-Id: <1151994319.6389.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> > Build mmc_block into mmc_core directly.
> > 
> > Bug Reference:
> > https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/30335
> 
> NAK.  If it's missing the modalias then it needs to be added.  But more
> the question is why isn't the driver being automatically loaded.
> Probably because hotplug doesn't know enough about the MMC subsystem.
> Unfortunately I'm at rather a loss what's required with hotplug because
> it isn't something I actually use or come into contact with.

actually Ubuntu can auto load the mmc_block module if needed. I also
have seen a system that looked at the csd.cmdclass value and then
decided to load mmc_block or not. Can't find it on Ubuntu though. Maybe
this was one of my Fedora Core 5 test boxes. Anyway the mmc_block must
stay separate from the mmc_core, because otherwise we will have trouble
to cleanly support SDIO cards in the future.

Regards

Marcel


