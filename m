Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932751AbWF1Gnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751AbWF1Gnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 02:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbWF1Gns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 02:43:48 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53429 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932747AbWF1Gnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 02:43:47 -0400
Date: Wed, 28 Jun 2006 08:38:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Zou Nan hai <nanhai.zou@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] jbd commit code deadloop when installing Linux
Message-ID: <20060628063859.GA9726@elte.hu>
References: <1151470123.6052.17.camel@linux-znh> <20060627234005.dda13686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627234005.dda13686.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > We see system hang in ext3 jbd code
> > when Linux install program anaconda copying 
> > packages. 
> > 
> > That is because anaconda is invoked from linuxrc 
> > in initrd when system_state is still SYSTEM_BOOTING.

[ argh ...! ]

> > Thus the cond_resched checks in  journal_commit_transaction 
> > will always return 1 without actually schedule, 
> > then the system fall into deadloop.
> 
> That's a bug in cond_resched().
> 
> Something like this..

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
