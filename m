Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161438AbWG2EJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161438AbWG2EJt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 00:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161439AbWG2EJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 00:09:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:43208 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161438AbWG2EJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 00:09:48 -0400
Date: Sat, 29 Jul 2006 06:03:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Fulghum <paulkf@microgate.com>, ak@muc.de,
       linux-kernel@vger.kernel.org, ebiederm@xmission.com,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
Message-ID: <20060729040337.GB29875@elte.hu>
References: <20060727015639.9c89db57.akpm@osdl.org> <1154112276.3530.3.camel@amdx2.microgate.com> <20060728144854.44c4f557.akpm@osdl.org> <20060728233851.GA35643@muc.de> <1154132126.3349.8.camel@localhost.localdomain> <1154135792.2557.7.camel@localhost.localdomain> <20060728182450.8f5cbf76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728182450.8f5cbf76.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > 2.6.18-rc2 works fine with same config.
> > 
> > In this case the error is:
> > 
> > No per-cpu room for modules
> 
> yeah, sorry, that's a known problem which nobody appears to be doing 
> anything about.  The expansion of NR_IRQS gobbles all the percpu 
> memory in the kstat structure.

while the fundamental issue is the NR_IRQS problem which we'll fix 
separately, Steve has a patchset to make percpu room dynamic:

  http://lkml.org/lkml/2006/4/14/137

	Ingo
