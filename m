Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTJNFwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 01:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTJNFwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 01:52:40 -0400
Received: from [202.149.212.34] ([202.149.212.34]:2364 "EHLO cmie.com")
	by vger.kernel.org with ESMTP id S261850AbTJNFwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 01:52:38 -0400
Date: Tue, 14 Oct 2003 11:20:49 +0530 (IST)
From: Nohez <nohez@cmie.com>
X-X-Sender: <nohez@venus.cmie.ernet.in>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Reproducable time problem with SMARTD & XNTPD
Message-ID: <Pine.LNX.4.33.0310140947570.10161-100000@venus.cmie.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I removed the 2 SATA disks from /etc/smartd.conf and found that the server
time remains in sync. The moment I add any one SATA disk the time starts
to go out of sync.

So looks like SMARTD + SATA combo is causing the system time to go out
of sync.

I am also trying to relate this problem with a similar problem that
we are facing on four HP Netserver LH6000. System Time behaves
erratically.  We noticed that all time related apps (sendmail,
ping, top, cron etc) stop. We noticed that time goes forward &
backward in seconds only.  These servers do not have any IDE
disks and does not have SMARTD running.  Detailed thread at:
http://marc.theaimsgroup.com/?t=104393747300002&r=1&w=2&n=6

All servers are running a SMP kernel and are facing a system time problem.

Nohez


On Mon, 13 Oct 2003, Bruce Allen wrote:

> Time to write back to linux-kernel.  I have no idea what's wrong.
> Bartlomiej, any ideas?  It seems that running smartd with SATA causes
> the system time to go out of sync...
>
> Bruce


On Sat, 11 Oct 2003, Mark Hahn wrote:

> > Has anyone faced a similar problem ?
>
> I doubt it; sata is still pretty rare, especially in combination
> with xntp.  it's a fascinating problem though - the only explanation
> I can think of is that smart queries eat your timer interrupts.
> that shouldn't happen of course!  I wonder if 'hdparm -u1' would
> help or even make sense for you...


On Tue, 23 Sep 2003, Michael Marxmeier wrote:

> Hello Nohez,
>
> I found your posting in the LK archives. Did you ever resolve
> this problem?
>
> We seem to have a similar problem with a customer using a
> dual CPU TC4100 NetServer.
>
> The effect is that timer interrupts could slow down to about
> once in 30 seconds rather than 100/sec. This seems to happen
> sporadic.
>
>
> Thanks
> Michael

