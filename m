Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBTSsh>; Tue, 20 Feb 2001 13:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129297AbRBTSs2>; Tue, 20 Feb 2001 13:48:28 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:57866 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129075AbRBTSsP>; Tue, 20 Feb 2001 13:48:15 -0500
Date: Tue, 20 Feb 2001 13:46:18 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: <mingo@devserv.devel.redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <macro@ds2.pg.gda.pl>
Subject: Re: [PATCH] 2.4.1-ac UP-APIC updates
In-Reply-To: <200102201811.TAA00748@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.32.0102201343490.7613-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Feb 2001, Mikael Pettersson wrote:

> * NMI rate reduction for UP-APIC: the 100Hz default rate is excessive for
>   normal systems, 1Hz suffices. It turns out we cannot start at 1Hz due to
>   this interacting badly with check_nmi_watchdog() and the watchdog itself,
>   so the rate is reduced after check_nmi_watchdog() is done.

i dont like this one. 100 times a second makes absolutely no performance
difference whatsoever - but eg. i'm driving kernel profiling from the NMI
handler to get profiles of eg. IRQ handlers and other cli()-ed code areas.

another reason is that if NMIs intaract with anything else in the system,
we'll have much better chances to hit it with 100 Hz than with 1 Hz.

	Ingo

