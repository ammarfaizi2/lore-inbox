Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUHSH5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUHSH5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUHSH5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:57:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:1931 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263743AbUHSH5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:57:22 -0400
Date: Thu, 19 Aug 2004 09:57:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Roger Luethi <rl@hellgate.ch>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040819075752.GA2360@elte.hu>
References: <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <1092612264.867.9.camel@krustophenia.net> <20040816080745.GA18406@k3.hellgate.ch> <1092696835.13981.61.camel@krustophenia.net> <20040817205255.GA32252@k3.hellgate.ch> <1092776417.1297.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092776417.1297.4.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > > What do you think of Ingo's solution of trying to move the problematic
> > > call to mdio_read out of the spinlocked section?  It does seem that the
> > 
> > Can't comment on that, I missed it. I am aware that locking in via-rhine
> > needs work, though, it's one of the things I haven't touched.
> > 
> > > awfully long time.  In a live audio setting you would actually get lots
> > > of media events.
> > 
> > Don't trip over the network cables. Duh.
> > 
> 
> You might want to intentionally plug or unplug them.  Live music != a
> server room.  Think laptop DJs.  It would be bad if plugging into the
> network caused a click in your sound output - this could be VERY loud
> depnding on the setting!

right now the mdio_read() latency causes a latency of 140 usecs which
isnt that bad. But looking at it in isolation, mdio_read() is 70 usecs a
pop which is excessive for a kernel function.

	Ingo
