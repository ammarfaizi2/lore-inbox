Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUJ0MLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUJ0MLx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbUJ0MLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:11:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:15590 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262398AbUJ0MK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:10:59 -0400
Subject: Re: Strange IO behaviour on wakeup from sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.53.0410271308360.9839@gockel.physik3.uni-rostock.de>
References: <1098845804.606.4.camel@gaston>
	 <Pine.LNX.4.53.0410271308360.9839@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 22:06:29 +1000
Message-Id: <1098878790.9478.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 13:20 +0200, Tim Schmielau wrote:
> On Wed, 27 Oct 2004, Benjamin Herrenschmidt wrote:
> 
> > Not much datas at this point yet, but paulus and I noticed that current
> > bk (happened already last saturday or so) has a very strange problem
> > when waking up from sleep (suspend to ram) on our laptops.
> 
> It's a shot in the dark, but I am concerned whether timers continue to 
> work correctly after suspend with the following patch from Linus' bk tree.
> I think jiffies may not be set behind the back of the timer subsystem, but 
> maybe it works if we can guarantee there are no timers scheduled.
> 
> It might be worth backing out and retesting.

The problem has been observed on ppc, while this patch only affects
i386...

Ben.


