Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129304AbRBTVCv>; Tue, 20 Feb 2001 16:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbRBTVCl>; Tue, 20 Feb 2001 16:02:41 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:38793 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129304AbRBTVCj>; Tue, 20 Feb 2001 16:02:39 -0500
Date: Tue, 20 Feb 2001 16:00:53 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: <mingo@devserv.devel.redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mikael Pettersson <mikpe@csd.uu.se>, <linux-kernel@vger.kernel.org>,
        <macro@ds2.pg.gda.pl>
Subject: Re: [PATCH] 2.4.1-ac UP-APIC updates
In-Reply-To: <E14VJoa-0000f1-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.32.0102201556510.7613-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Feb 2001, Alan Cox wrote:

> > i dont like this one. 100 times a second makes absolutely no performance
> > difference whatsoever - but eg. i'm driving kernel profiling from the NMI
> > handler to get profiles of eg. IRQ handlers and other cli()-ed code areas.
>
> So set it to 100Hz as a debugging option like slab debugging

my major gripe right now is that we still have bug reports that say that
systems hang when using nmi_watchdog=1 and work if nmi_watchdog=0.
Changing the NMI watchdog to be 1 Hz will make these bugreports "Linux
hangs once a week" instead of a "Linux hangs after 1-2 hours", which is
clearly hiding things and making debugging harder.

(and driving kernel-profiling from the NMI interrupt is a short-term
patch, so there is just no point in going to 1 Hz right now just to go
back to 100 Hz a few days later.)

the rest of the changes are excellent - it's only the 100 Hz NMI issue i
have a problem with.

	Ingo

