Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268805AbUILTez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268805AbUILTez (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268812AbUILTez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:34:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:21720 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268805AbUILTes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:34:48 -0400
Date: Sun, 12 Sep 2004 21:35:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chris Wedgwood <cw@f00f.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjanv@redhat.com>,
       Andrea Arcangeli <andrea@novell.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040912193542.GB28791@elte.hu>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <1095016687.1306.667.camel@krustophenia.net> <20040912192515.GA8165@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912192515.GA8165@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chris Wedgwood <cw@f00f.org> wrote:

> > The glaring exception is the IDE io completion, which can run for
> > 2000+ usec even with a modern chipset and drive.
> 
> does un-masking irqs help?

no. A 2 msec nonpreemptable delay is a 2 msec delay, irqs on or off
alike.

but it's not a big problem with IRQ threading, there most hardirqs are
preemptable.

	Ingo
