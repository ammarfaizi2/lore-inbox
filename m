Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030894AbWKOTEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030894AbWKOTEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030893AbWKOTEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:04:40 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37086 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030895AbWKOTEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:04:39 -0500
Date: Wed, 15 Nov 2006 20:03:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
Message-ID: <20061115190308.GA9303@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <45075829.701@goop.org> <20060913095942.GA10075@elte.hu> <45082F1C.8000003@goop.org> <20061115182613.GA2227@elte.hu> <455B5ED8.5090005@goop.org> <20061115184315.GA5078@elte.hu> <455B611C.3010503@goop.org> <20061115184936.GA6389@elte.hu> <455B63D8.7000601@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455B63D8.7000601@goop.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Ingo Molnar wrote:
> > i'd not even use glibc's %gs but set up two separate selectors. 
> > (that's a more controlled experiment - someone might run a non-TLS 
> > glibc, etc.)
> >   
> 
> Well, in that case they probably don't care whether the kernel uses 
> %fs or %gs ;)
> 
> But either way, this doesn't have much bearing on Eric's test; we'd be 
> only talking about a few ns per kernel exit, rather than 5% for 
> read/write.

if the timings are different then it very much has bearing on the 
argument that i made against the current i386 PDA patchset, that mixed 
use segments are suboptimal.

So i'm NAK-ing the i386 PDA patchset until this has been properly 
measured (and fixed if needed).

	Ingo
