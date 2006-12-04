Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934488AbWLDJwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934488AbWLDJwK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 04:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935303AbWLDJwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 04:52:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53939 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S934488AbWLDJwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 04:52:08 -0500
Date: Mon, 4 Dec 2006 10:51:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in	latency_trace.c (take 3)
Message-ID: <20061204095131.GE7872@elte.hu>
References: <200611132252.58818.sshtylyov@ru.mvista.com> <457326A2.2020402@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457326A2.2020402@ru.mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

>    What was the destiny of that patch? I haven't seen it accepted, 
> haven't seen any comments... while this is not a mere warning fix. 
> What am I expected to do to get it accepted -- recast it against 
> 2.6.19-rt1?

i'd suggest to redo it - but please keep it simple and clean. Those 
dozens of casts to u64 are quite ugly. Why is cycles_t 32-bits on some 
of the arches to begin with?

	Ingo
