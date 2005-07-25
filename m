Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVGYKaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVGYKaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 06:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVGYKaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 06:30:13 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:11431 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261198AbVGYKaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 06:30:05 -0400
Date: Mon, 25 Jul 2005 03:27:48 -0700
From: Tony Lindgren <tony@atomide.com>
To: Christian Hesse <mail@earthworm.de>
Cc: linux-kernel@vger.kernel.org, Jan De Luyck <lkml@kcore.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6.12.3] dyntick 050610-1 breaks makes S3 suspend
Message-ID: <20050725102747.GH5837@atomide.com>
References: <200507231435.05015.lkml@kcore.org> <200507231451.04630.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507231451.04630.mail@earthworm.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Hesse <mail@earthworm.de> [050723 05:51]:
> On Saturday 23 July 2005 14:35, Jan De Luyck wrote:
> > Hello,
> >
> > I recently tried out dyntick 050610-1 against 2.6.12.3, works great, it
> > actually makes a noticeable difference on my laptop's battery life. I don't
> > have hard numbers, lets just say that instead of the usual ~3 hours i get
> > out of it, i was ~4 before it started nagging, usual use pattern at work.
> >
> > The only gripe I have with it that it stops S3 from working. If the patch
> > is compiled in the kernel, it makes S3 suspend correctly, but resuming goes
> > into a solid hang (nothing get's it back alive, have to keep the
> > powerbutton for ~5 secs to shutdown the system)
> >
> > Anything I could test? The logs don't give anything useful..
> 
> I reported this some time ago [1], but there's no sulution so far...
> 
> [1] http://groups.google.com/groups?selm=4b4NI-7mJ-9%40gated-at.bofh.it

In theory it should not happen... And it's working on my laptop for resume
just fine with dyntick on. Can you try it without APIC support? Maybe
that's the differerence again. (I don't have APIC on my laptop)

Also a workaround is to disable dyntick before suspend with:

# echo 0 > /sys/devices/system/timer/timer0/dyn_tick_state

and then enable it again after resume.

Tony
