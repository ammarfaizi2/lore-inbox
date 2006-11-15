Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030825AbWKOSpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030825AbWKOSpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030853AbWKOSp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:45:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41381 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030825AbWKOSpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:45:25 -0500
Date: Wed, 15 Nov 2006 19:44:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
Message-ID: <20061115184433.GB5078@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <45075829.701@goop.org> <20060913095942.GA10075@elte.hu> <45082F1C.8000003@goop.org> <20061115182613.GA2227@elte.hu> <20061115182915.GA2705@elte.hu> <455B5FB6.7010009@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455B5FB6.7010009@goop.org>
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

> > that loads (and uses) a single selector value for %fs, and doesnt do 
> > any mixed use as far as i can see.
> 
> I'm not sure what you're getting at.  Each loop iteration is analogous 
> to a user->kernel->user transition with respect to the 
> save/reload/use/restore pattern on the segment register.  In this 
> case, %fs starts as a null selector, gets reloaded with a non NULL 
> selector, and then is restored to null.  Do you mean some other 
> mixing?

yeah, mixed use: i.e. set up /two/ selector values and load them into 
%gs and read+write memory through them. It might not change the results, 
but that's what i meant under 'mixed use'.

	Ingo
