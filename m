Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271881AbRHUWlK>; Tue, 21 Aug 2001 18:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271875AbRHUWlB>; Tue, 21 Aug 2001 18:41:01 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:59733 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271859AbRHUWks>; Tue, 21 Aug 2001 18:40:48 -0400
Date: Tue, 21 Aug 2001 18:41:02 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: <Andries.Brouwer@cwi.nl>
cc: <linux-kernel@vger.kernel.org>, <satch@fluent-access.com>
Subject: Re: FYI  PS/2 Mouse problems -- userland issue
In-Reply-To: <200108212235.WAA197891@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.33.0108211838550.14374-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001 Andries.Brouwer@cwi.nl wrote:

> > Armed with docs I was able to see just why our code
> > is completely wrong for handling things like the ps/2
> > mouse being removed at runtime.
>
> Yes, or being added, to be more precise. But it will not be
> easy to do it right. So many different ps2-like types of mouse.
> There are heuristics, like the AA 00 that I gave last week or so.
> (But not every ps2-mouse emits this sequence.)

That's what reset probes are for... =)  At least in the case of the mouse,
this really isn't the kernel's business.  But for the keyboard, it is.

> Also state machines have difficulties. Many types of mouse react

The state machine I'm talking about is for the general keyboard controller
poking code which currently is well sprinkled with udelay()s.  I really
don't want my dual 1.2GHz CPUs waiting on a keyboard controller.

		-ben

