Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267817AbUG3UL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267817AbUG3UL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267821AbUG3UL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:11:26 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:137 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S267817AbUG3UKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:10:51 -0400
Date: Fri, 30 Jul 2004 22:10:52 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730201052.GA5249@ucw.cz>
References: <20040730194634.GA4851@ucw.cz> <20040730200359.80825.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730200359.80825.qmail@web14922.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> So normal hardware would never ask for the cache since it isn't needed.
> In the normal hardware case direct ROM access is used. If the
> minimalistic hardware is using a user space driver it won't ask for the
> cache either. The only time you get cached is on minimal hardware and
> when the driver asks for it. Since the driver is asking for the cache
> you have to assume that it needs it so the memory isn't wasted.

No, we are speaking about sysfs access to the ROM and the driver itself
is unable to predict whether anybody will ever want to use that sysfs file,
so it would have to cache always.

Do I understand it correctly that the ROM-in-sysfs hack is intended only
for debugging? If it is so, I do not see why we should do anything complicated
in order to avoid root shooting himself in the foot.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Immanuel doesn't pun, he Kant.
