Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271852AbRHUUXQ>; Tue, 21 Aug 2001 16:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271855AbRHUUXF>; Tue, 21 Aug 2001 16:23:05 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:36833 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271852AbRHUUWq>; Tue, 21 Aug 2001 16:22:46 -0400
Date: Tue, 21 Aug 2001 16:22:53 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: <Andries.Brouwer@cwi.nl>
cc: <satch@fluent-access.com>, <linux-kernel@vger.kernel.org>
Subject: Re: FYI  PS/2 Mouse problems -- userland issue
In-Reply-To: <200108211940.TAA184696@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.33.0108211609510.14374-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001 Andries.Brouwer@cwi.nl wrote:

>     machine driven code that doesn't block interrupts out for long periods of
>     time, as well as fixing a few of the lockup issues the current driver has.
>
> Have you written the patch already?
> There are interesting difficulties here.

Nothing in a usable state.  It needs a few days of work, but the general
design is done.  Having high resolution timers would help, but it's not
essential.  Most of the work was in tracking down all the docs for the
keyboard and ps/2 mouse ports to get an overview of what the code was
trying to coax the hardware into doing.  Armed with docs I was able to see
just why our code is completely wrong for handling things like the ps/2
mouse being removed at runtime.

		-ben

