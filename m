Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbUKUWba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUKUWba (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 17:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUKUWba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 17:31:30 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:3468 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261660AbUKUWap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 17:30:45 -0500
Date: Sun, 21 Nov 2004 23:30:38 +0100
Message-Id: <200411212230.iALMUcC17182@inv.it.uc3m.es>
From: ptb@lab.it.uc3m.es (Peter T. Breuer)
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: can kfree sleep?
In-Reply-To: <20041121211451.GA12826@infradead.org>
X-Newsgroups: gmane.linux.kernel
User-Agent: tin/1.7.4-20031226 ("Taransay") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041121211451.GA12826@infradead.org> you wrote:
> On Sun, Nov 21, 2004 at 01:10:38PM -0800, Andrew Morton wrote:
> > Nope.  All memory freeing codepaths are atomic and may be called from any
> > context except NMI handlers.
> 
> Not true for vfree()

My interest at the moment is in what can sleep and what cannot sleep.
Are you saying that vfree can sleep or that vfree cannot be called from
at least one other context in addition to the NMI handler context (from
which it cannot be called ...)?

:)

Peter
