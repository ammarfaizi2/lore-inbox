Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVANFPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVANFPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 00:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVANFPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 00:15:12 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:16567 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261918AbVANFPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 00:15:06 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       lkml@s2y4n2c.de, rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com,
       chrisw@osdl.org, mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200501140445.j0E4j94k001522@localhost.localdomain>
References: <200501140445.j0E4j94k001522@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 16:14:52 +1100
Message-Id: <1105679692.5402.125.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 23:45 -0500, Paul Davis wrote:
> >Alternatively, could you grant the required capabilities to use real
> >RT scheduling and not foul up the scheduler?
> 
> this is precisely the point i was making. either you agree that
> unprivileged users can get easy access to a scheduling class that can
> reliably DOS the system, or they can't. if they can't, what kind of
> scheduling class can they access easily?
> 
> according to andrew, and i agree with his conclusion, many people
> agree that its OK for them to get access to the DOS class, but there's
> little agreement on the security model to allow this. Con is
> suggesting that they are not, but instead get a different scheduling
> class that is functionally equivalent except that it can't
> (theoretically) be used to DOS the system.

Well IMO that would be preferable if there are no other objections.
I can't think how any sort of unprivileged "real time" scheduling
would have a place on multi-user systems.

And if it is only really used on single user systems then presumably
the priority elevation isn't a big problem provided it can be properly
managed. So this would appear to be the better solution.

Supposing you do want some sort of DOS prevention in the system, I'd
much prefer it be handled by a trusted user-space daemon for example,
rather than scheduler smarts (which may require a little bit of work
to limit priorities but would be relatively straightforward).



