Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbUATEp1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 23:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUATEp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 23:45:27 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:7829 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263475AbUATEpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 23:45:22 -0500
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Xose Vazquez Perez <xose@wanadoo.es>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <3942145408.1074564149@aslan.btc.adaptec.com>
References: <400BDC85.8040907@wanadoo.es>	<1074532919.1895.32.camel@mulgrave>
		<3747775408.1074537497@aslan.btc.adaptec.com>
	<1074559838.2078.1.camel@mulgrave> 
	<3942145408.1074564149@aslan.btc.adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Jan 2004 23:45:10 -0500
Message-Id: <1074573912.2081.81.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-19 at 21:02, Justin T. Gibbs wrote:
> Does the maintainer have the ability to veto changes that harm the
> code they maintain?  In otherwords, you claim that I am the maintainer
> of the drivers in the kernel.org tree.  This has not prevented changes
> from being made to these drivers without adequate review.  Even your last
> update to the driver threw away all of the changelog state and left at
> least the aic79xx driver in a worse state than it was in before (see
> changelog entries for the driver versions after the one that you imported
> for details - this was exactly why I didn't submit that particular revision).

I said "works with the kernel community".  It's not about control, it's
about co-operation.  The control you seek simply does not exist in the
kernel development process.

> You didn't even bother to ask me if importing 1.3.11 was appropriate.  This
> is why I say I don't feel like a maintainer.  I'm not given adequate control
> over the end product yet I'm supposed to take the blame when it doesn't work.

In the previous thread about the driver you said "You can integrate the
driver at whatever revision suits you.", so I took you at your word; if
that wasn't what you meant, it's a little late to whine about it now. 
Small bug fixes, would, as ever, be welcome...

As for blame, apart from the occasional flamewar, the community seems
generally welcoming of anyone who provides fixes.  We tend to be more
interested in fixing things than assigning blame.

> That proposal was to allow the timeout handler to be redirected.  This
> is different than an early notification.  Allowing the timeout handler
> to be redirected is a required step toward making the recovery code
> work.

The recovery code does work.  You may want it to work differently, and
that may make it work better, but that's an enhancement not a bug fix.

> In this case, the bug is that the mid-layer tries to handle watchdog
> recovery on its own.  It will never, in my opinion, having reviewed
> lots of systems that have tried to do it in a centralized way, work well.
> The mid-layer just doesn't have the necessary state to make intelligent
> decisions and exporting that state will always be cumbersome and incomplete.

But it does do it successfully.  Something that currently works but
could work better is an enhancement not a bug.

> How does the mid-layer know that the "bus is free".  What transports even
> have this concept?  If one drive has lost a command, and the transport
> is functioning normally, why are you penalizing the other devices attached
> to the HBA while you "sort this out"?  There is no need to do that.

Again, this is could do better not required bug fix.

I'm not against enhancements, even at this late stage in the
stabilisation process.  However, they have to be small, self contained
and obviously correct.  If you have them, send them to the list and
they'll get reviewed.

James


