Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbVKILaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbVKILaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 06:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVKILaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 06:30:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:62435 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751377AbVKILai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 06:30:38 -0500
Date: Wed, 9 Nov 2005 12:30:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john cooper <john.cooper@timesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: MIPS PREEMPT_RT update..
Message-ID: <20051109113053.GA1012@elte.hu>
References: <436B85E1.1050103@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436B85E1.1050103@timesys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john cooper <john.cooper@timesys.com> wrote:

> As a qualification, I am still chasing a few problems which I suspect 
> are related to the Malta patch for 2.6.14 rather than the mips-rt 
> patch.  One appears to be a TLB handler problem in 2.6.14.  The other 
> appears to be potentially excessive context switching, although I 
> haven't had the opportunity yet to fully investigate this issue.  I 
> will follow up should resolution of these feed back into generic 
> mips-rt support.

FYI, i have released your big MIPS merge as part of 2.6.14-rt9. [please 
double-check i did not mis-merge any component]

wrt. your TLB problems: it might be related that TLB handling got 
simplified (and sped up) with the introduction of a generic, preemptible 
method to handle TLB-gathers. There's no tlb-simple.h anymore.

excessive context-switching might happen in some cases when we ping-pong 
short-held locks, and i'm certainly interested in a reproducer or 
analysis (or patch! :-).

	Ingo
