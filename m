Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265880AbUGMUuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265880AbUGMUuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUGMUuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:50:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56744 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265880AbUGMUug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:50:36 -0400
Date: Tue, 13 Jul 2004 22:06:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Steven Dake <sdake@mvista.com>
Cc: Daniel Phillips <phillips@redhat.com>,
       Daniel Phillips <phillips@istop.com>,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040713200624.GH3654@openzaurus.ucw.cz>
References: <200407050209.29268.phillips@redhat.com> <200407111544.25590.phillips@istop.com> <1089605292.19787.62.camel@persist.az.mvista.com> <200407120023.44773.phillips@redhat.com> <1089656497.608.4.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089656497.608.4.camel@persist.az.mvista.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You missed the point.  The memory deadlock I pointed out occurs in 
> > _normal operation_.  You have to find a way around it, or kernel 
> > cluster services win, plain and simple.
> > 
> 
> The bottom line is that we just don't know if any such deadlock occurs,
> under normal operations.  The remaining objections to in-kernel cluster

I did some work on swapping-over-nbd, which has similar issues,
and yes, the deadlocks were seen under heavy load.

*Designing* something with "lets hope it does not deadlock",
while deadlock clearly can be triggered, looks like bad idea.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

