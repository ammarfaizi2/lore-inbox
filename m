Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTJJMzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 08:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbTJJMzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 08:55:33 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:37003 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262563AbTJJMz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 08:55:28 -0400
Date: Fri, 10 Oct 2003 13:55:03 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Pascal Schmidt <der.eremit@email.de>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Message-ID: <20031010125503.GB28224@mail.shareable.org>
References: <DIre.Cy.15@gated-at.bofh.it> <DIre.Cy.17@gated-at.bofh.it> <DIre.Cy.19@gated-at.bofh.it> <DIre.Cy.13@gated-at.bofh.it> <DIAQ.2Hh.5@gated-at.bofh.it> <E1A6aWv-0000rJ-00@neptune.local> <Pine.LNX.4.53.0310061605001.733@chaos> <20031007104926.GA1659@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031007104926.GA1659@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > A company makes a new device that could run under Linux.
> > This device uses some standard gate-arrays. Because of
> > this, some gate-array bits need to be loaded upon startup.
> > 
> > The company knows that if the competition learns that a
> > gate-array was used, instead of an ASIC, the competition
> > could clone the whole device in a few weeks, thereby
> > stealing a few million dollars of development effort.
> 
> Since when is creating compatible hw called stealing?!
> If this was such a big problem, nothing prevents you
> from putting ROM with those magic bits... How much is
> that? _5?

Large modern gate arrays use encrypted bitstreams, and even when not
encrypted are very hard to reverse engineer, so that's not the
problem.  It's possible, but very expensive.

Small gate arrays use non-volatile programming anyway.

The problem is blatant copying of the bitstream.

This is trivial whether it's in ROM or not, for anyone capable of
making a device, so gate-array firmware is *no excuse* for keeping the
driver code obscured, not even a _5 excuse.

-- Jamie
