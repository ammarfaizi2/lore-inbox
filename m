Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968312AbWLEPmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968312AbWLEPmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968322AbWLEPmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:42:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55134 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968312AbWLEPme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:42:34 -0500
Date: Tue, 5 Dec 2006 16:41:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Christoph Lameter'" <clameter@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [-mm patch] sched remove lb_stopbalance counter
Message-ID: <20061205154147.GA4865@elte.hu>
References: <20061205153224.GA3204@elte.hu> <000101c71883$78e626c0$a884030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101c71883$78e626c0$a884030a@amr.corp.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> > but, please:
> > 
> > > -#define SCHEDSTAT_VERSION 13
> > > +#define SCHEDSTAT_VERSION 12
> > 
> > change this to 14 instead. Versions should only go upwards, even if 
> > we revert to an earlier output format.
> 
> Really?  sched-decrease-number-of-load-balances.patch has not yet hit 
> the mainline and I think it's in -mm for only a couple of weeks.  I'm 
> trying to back out the change after brief reviewing the patch.

not a big issue but it costs nothing to go to version 14 - OTOH if any 
utility has been updated to version 13 and is forgotten about, it might 
break spuriously if we again go to 13 in the future.

	Ingo
