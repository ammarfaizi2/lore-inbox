Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266075AbUHVEnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUHVEnh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 00:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUHVEng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 00:43:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:38534 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266075AbUHVEne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 00:43:34 -0400
Date: Sat, 21 Aug 2004 21:41:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: John Levon <levon@movementarian.org>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jbarnes@sgi.com, anton@samba.org, phil.el@wanadoo.fr
Subject: Re: [PATCH] improve OProfile on many-way systems
Message-Id: <20040821214141.70eb4b9a.akpm@osdl.org>
In-Reply-To: <20040821235556.GA22619@compsoc.man.ac.uk>
References: <20040821192630.GA9501@compsoc.man.ac.uk>
	<20040821135833.6b1774a8.akpm@osdl.org>
	<20040821232206.GC20175@compsoc.man.ac.uk>
	<20040821163628.10cfa049.akpm@osdl.org>
	<20040821235556.GA22619@compsoc.man.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <levon@movementarian.org> wrote:
>
> For example a while ago wli walked right into an obvious bug on one of
> his machines that hadn't shown up during /any/ of my testing since the
> code was merged.

wli is a self-contained corner case.

> > One of my mental checkpoints before sending a patch to Linus is "has this
> > been sufficiently tested".  I don't know how to answer that in this case.
> 
> Me neither. It would certainly be great to have a decent regression test
> suite for OProfile, but I don't have one other than the usual by-hand
> testing I do. Isn't there some STP thing or something at OSDL we can
> get people to try?

LTP would be appropriate.  If it is possible to come up with a suitably
encapsulated testcase I'm sure they'd take (and integrate) the code.

> > In fact I don't know how to answer that in a _lot_ of cases, but if I know
> > that people are using the feature in anger and we're sufficiently early in
> > the 2.6.x cycle then I'll assume that regressions will be picked up.
> 
> I must admit I'm still not clear on when the equivalent of "early in the
> 2.6.x cycle" is going to happen again...

Well, we've just released 2.6.8, so the answer to your question is "right
now".

It seems that the release cycle has stretched from ~4 weeks out to ~6
weeks or more.  But some of that increase could be due to summer and OLS.

> I have no idea when, if ever,
> call-graph OProfile would be suitable to merge.

As soon as it's ready.

Seriously, don't let hypothetical kernel bureaucracy hold you back - write
the code, get it into -mm.  I'll look after it for as long as we think is
appropriate, then it goes in.  As long as it doesn't break existing stuff.

