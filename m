Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267346AbUIOT7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267346AbUIOT7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUIOT7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:59:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37020 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267346AbUIOT7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:59:07 -0400
Date: Wed, 15 Sep 2004 22:00:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@novell.com>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040915200018.GA17773@elte.hu>
References: <20040913061641.GA11276@elte.hu> <41489B7A.6010407@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41489B7A.6010407@tmr.com>
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


* Bill Davidsen <davidsen@tmr.com> wrote:

> Okay, I'll be the one to ask... what overload of the IPL acronym are
> you using here? I asked google and several jargon files, and they all
> say that IPL (initial program load) is IBMspeak for cold boot. Somehow
> I don't think that's what you mean here.

i understood it as Interrupt Privilege Levels. The notion of having some
sort of scalar 'limit' - all interrupts with a higher priority than that
will execute, all interrupts with lower priority will block.  This is a
fundamentally dodgy concept because in reality interrupt sources are
independent entities so the natural description for of them is a bitmask
(or an array, or whatever), not a level.

	Ingo
