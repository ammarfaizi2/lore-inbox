Return-Path: <linux-kernel-owner+w=401wt.eu-S1754280AbXACEia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbXACEia (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 23:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754244AbXACEia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 23:38:30 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42929
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754180AbXACEi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 23:38:29 -0500
Date: Tue, 02 Jan 2007 20:38:28 -0800 (PST)
Message-Id: <20070102.203828.70220767.davem@davemloft.net>
To: jengelh@linux01.gwdg.de
Cc: segher@kernel.crashing.org, linux-kernel@vger.kernel.org, devel@laptop.org,
       benh@kernel.crashing.org, wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0701030213100.19644@yvahk01.tjqt.qr>
References: <20070102.140749.104035927.davem@davemloft.net>
	<3676953abedcbe6d86da74a4997593cb@kernel.crashing.org>
	<Pine.LNX.4.61.0701030213100.19644@yvahk01.tjqt.qr>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Wed, 3 Jan 2007 02:13:39 +0100 (MET)

> 
> On Jan 3 2007 01:52, Segher Boessenkool wrote:
> >> > Leaving aside the issue of in-memory or not, I don't think
> >> > it is realistic to think any completely common implementation
> >> > will work for this -- it might for current SPARC+PowerPC+OLPC,
> >> > but more stuff will be added over time...
> >> 
> >> I see nothing supporting this IMHO bogus claim.
> >
> > Please keep in mind that not all systems want to kill OF
> > as soon as they enter the kernel -- some want to keep it
> > active basically forever (or only remove it when the user
> > asks for it).
> 
> Kill OF? sparc does not want that IMO, how else should I return to
> the 'ok' prompt?

PowerPC kills OF because it really has to, that's one of numerous
reasons that it started sucking the device tree into a kernel copy
early in the bootup and using that for device discovery etc.

To be honest, the 'ok' prompt is of limited value when you have
things like Alt-SysRq and PPC's XMON debugger in the kernel already.

In fact, the 'ok' prompt is an ENORMOUS pain in the ass to support
on machines with USB keyboards, because sharing the USB host
controller is beyond non-trivial.  I've never implemented support
for that on sparc64 and I frankly have no desire to do the work
necessary to support that.  It simply is not worth it.
