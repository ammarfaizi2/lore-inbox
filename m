Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271773AbRHUSRk>; Tue, 21 Aug 2001 14:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271772AbRHUSRa>; Tue, 21 Aug 2001 14:17:30 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:26993 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271773AbRHUSRP>; Tue, 21 Aug 2001 14:17:15 -0400
Date: Tue, 21 Aug 2001 14:17:19 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: Stephen Satchell <satch@fluent-access.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: FYI  PS/2 Mouse problems -- userland issue
In-Reply-To: <4.3.2.7.2.20010821084512.00bdf800@mail.fluent-access.com>
Message-ID: <Pine.LNX.4.33.0108211413080.14374-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Stephen Satchell wrote:

> This MAY be a kernel issue depending on where I locate the mouse
> initialization code.  If it is in the kernel, then there will need to be a
> patch to allow the mouse to be re-initialized into the mode everyone expects.

The kernel has nothing to do with reinitializing the mouse: X has to do
that.  I was looking into this a few months ago when the installer's mouse
probe code stopped working on 2.4, and it became apparent that there is
lots of userland code that doesn't do the right thing to handle mouse hot
plug reinitialization.  gpm and X both need bugfixing in this area.  As
for the kernel, it needs a few improvements during 2.5: I plan to submit a
patch that replaces much of the existing pc keyboard/mouse code with state
machine driven code that doesn't block interrupts out for long periods of
time, as well as fixing a few of the lockup issues the current driver has.

		-ben

