Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbUCCPvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbUCCPvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:51:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17353 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262496AbUCCPvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:51:07 -0500
Date: Wed, 3 Mar 2004 16:51:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: George Anzinger <george@mvista.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040303155106.GB12769@atrey.karlin.mff.cuni.cz>
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com> <20040302221106.GH20227@smtp.west.cox.net> <20040302223143.GE1225@elf.ucw.cz> <20040302230018.GL20227@smtp.west.cox.net> <20040302233512.GJ1225@elf.ucw.cz> <20040303152226.GS20227@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303152226.GS20227@smtp.west.cox.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > More precisely:
> > > http://lkml.org/lkml/2004/2/11/224
> > 
> > Well, that just says Andrew does not care too much. I think that
> > having both serial and ethernet support *is* good idea after all... I
> > have few machines here, some of them do not have serial, and some of
> > them do not have supported ethernet. It would be nice to use same
> > kernel on all of them. Also distribution wants to have "debugging
> > kernel", but does _not_ want to have 10 of them.
> 
> But unless I'm missing something, supporting eth or 8250 at all times
> doesn't work right now anyhow, as eth if available will always take over.

Well, that can be fixed. [Probably if kgdbeth= is not passed, ethernet
interface should not take over. So user selects which one should be
used by either passing kgdbeth or kgdb8250. That means that 8250
should not be initialized until user passes kgdb8250=... not sure how
you'll like that].
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
