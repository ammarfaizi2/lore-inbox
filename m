Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264705AbUFQNMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbUFQNMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUFQNMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:12:00 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55431 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266483AbUFQNJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:09:06 -0400
Date: Thu, 17 Jun 2004 15:10:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andi Kleen <ak@muc.de>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040617131016.GA25920@elte.hu>
References: <20040617121356.GA24338@elte.hu> <CBC4546BAB9F1Aindou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBC4546BAB9F1Aindou.takao@soft.fujitsu.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Takao Indoh <indou.takao@soft.fujitsu.com> wrote:

> It sounds good because change of timer/tasklet code is not needed.
> But, I wonder whether this method is safe. For example, if kernel
> crashes because of problem of timer, clearing lists may be dangerous
> before dumping. Is it possible to clear all timer lists safely?

yes it can be done safely - just INIT_LIST_HEAD() all the timer list
heads - like init_timers_cpu() does.

	Ingo
