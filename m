Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWC1MVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWC1MVQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 07:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWC1MVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 07:21:16 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:23304 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932201AbWC1MVP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 07:21:15 -0500
Date: Tue, 28 Mar 2006 14:21:14 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>, "Mark A. Greer" <mgreer@mvista.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm1 3/3] rtc: add support for m41t81 & m41t85
 chips to m41t00 driver
Message-Id: <20060328142114.e578cd7c.khali@linux-fr.org>
In-Reply-To: <20060327165120.35376d11.akpm@osdl.org>
References: <440B4B6E.8080307@sh.cvut.cz>
	<zt2d4LqL.1141645514.2993990.khali@localhost>
	<20060307170107.GA5250@mag.az.mvista.com>
	<20060318001254.GA14079@mag.az.mvista.com>
	<20060323210856.f1bfd02b.khali@linux-fr.org>
	<20060323203843.GA18912@mag.az.mvista.com>
	<20060324012406.GE9560@mag.az.mvista.com>
	<20060326145840.5e578fa4.akpm@osdl.org>
	<20060328002625.GE21077@mag.az.mvista.com>
	<20060327165120.35376d11.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Andrew,

> Mark A. Greer wrote:
> >
> > Resend...
> > ---
> > 
> >  drivers/i2c/chips/m41t00.c |  294 ++++++++++++++++++++++++++++++++++-----------
> >  include/linux/m41t00.h     |   50 +++++++
> 

Andrew Morton wrote:
> Not sure what to make of this.  It has no changelog, it doesn't apply on
> top of your previous three patches:
> 
> rtc-m41t00-driver-should-use-workqueue-instead-of-tasklet.patch
> rtc-m41t00-driver-cleanup.patch
> rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch
> 
> and it doesn't apply when used to replace
> rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch.

Replacing works for me, after also replacing the two first patches of
the series with their new respective version. As for the changelog I
picked the one from the original third patch.

> An incremental patch against the three above patches would be ideal...

Well, the first two patches (workqueue and cleanup) look ok to me now,
so I'll send them to Greg now, together with one similar patch for the
ds1374 driver. The workqueue patches need to go to Linus soon, as they
fix a bug in these drivers, and I know that Greg has other i2c patches
waiting to go to Linus anyway. The cleanup patch can go in too, I
think, as it's simple enough.

As for the third patch, I have some more comments on it (sorry for
being slow) and it might need some tweaking, so it's probably better
(and easier) if Andrew just drops it for now, and it'll get back to him
when ready.

Mark, is it OK if this third patch adding the m41t81 and m41t85 support
spends some time in Andrew's tree and only goes in mainline for 2.6.18,
or do you need it in 2.6.17?

Thanks,
-- 
Jean Delvare
