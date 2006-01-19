Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWASU1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWASU1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWASU1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:27:39 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:29710 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1422642AbWASU1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:27:38 -0500
Date: Thu, 19 Jan 2006 21:27:34 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Nick Warne <nick@linicks.net>
Cc: Rumi Szabolcs <rumi_ml@rtfm.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernel uptime counter problem
Message-ID: <20060119202734.GR7142@w.ods.org>
References: <20060119110834.bb048266.rumi_ml@rtfm.hu> <7c3341450601190129r64a97880q22d576734214b6ac@mail.gmail.com> <20060119201857.GQ7142@w.ods.org> <200601192022.42087.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601192022.42087.nick@linicks.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 08:22:42PM +0000, Nick Warne wrote:
> On Thursday 19 January 2006 20:18, Willy Tarreau wrote:
> 
> > > You can use:
> > > last -xf /var/run/utmp runlevel
> > >
> > > to get true uptime in this instance.
> > >
> > > Nick
> >
> > I would add that if you need to get valid outputs after such an uptime,
> > you can apply the vhz-j64 patch available at Robert Love's (RML) on
> > kernel.org.
> 
> :-(  Then you would have to start all over again and wait 497.1 days to see if 
> it works... :-0

No, you can apply the debugjiffies patch which basically sets your time
to -5 min at boot to test the wrapping. Anyway, believe me, it works, I
successfully wrapped twice on 2.4.18 a long time ago, and it was not
that clean by this time.

> Seriously, is this patch to be added to 2.4.x tree at all in the future?

No, because it uses dirty (but very clever) tricks to avoid locking around
the jiffies manipulations, and 2.4 is in critical fixes-only mode right now.

> Nick

Regards,
Willy

