Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWGMCBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWGMCBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 22:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWGMCBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 22:01:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28867 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751483AbWGMCBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 22:01:42 -0400
Date: Wed, 12 Jul 2006 19:00:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, ak@suse.de, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, bunk@stusta.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [patch] let CONFIG_SECCOMP default to n
In-Reply-To: <20060712185103.f41b51d2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607121859420.5623@g5.osdl.org>
References: <20060630014050.GI19712@stusta.de> <20060630045228.GA14677@opteron.random>
 <20060630094753.GA14603@elte.hu> <20060630145825.GA10667@opteron.random>
 <20060711073625.GA4722@elte.hu> <20060711141709.GE7192@opteron.random>
 <1152628374.3128.66.camel@laptopd505.fenrus.org> <20060711153117.GJ7192@opteron.random>
 <1152635055.18028.32.camel@localhost.localdomain> <p73wtain80h.fsf@verdi.suse.de>
 <20060712210732.GA10182@elte.hu> <20060712185103.f41b51d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jul 2006, Andrew Morton wrote:
> 
> But looking at it, I think it's a bit confused.  The patch needs
> s/DISABLE_TSC/ENABLE_TSC/ to make it right.

No, SECCOMP_DISABLE_TSC _enables_ the "disable TSC" feature.

Rather confusing naming, I'd agree.

That said, I still think the code is crap, and that if we want to support 
tasks that don't have access to the TSC, we should make that an 
independent feature of anything like SECCOMP. 

		Linus
