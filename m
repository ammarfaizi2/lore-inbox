Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbWECG5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbWECG5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 02:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWECG5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 02:57:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:63948 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965106AbWECG5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 02:57:02 -0400
Date: Wed, 3 May 2006 09:01:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC, PATCH] cond_resched() added to close_files()
Message-ID: <20060503070152.GB23921@elte.hu>
References: <20060419112130.GA22648@elte.hu> <44577822.8050103@mbligh.org> <20060502155244.GA5981@elte.hu> <200605022155.31990.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605022155.31990.dada1@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric Dumazet <dada1@cosmosbay.com> wrote:

> This patch makes sure a cond_resched() call is done every 32 (or 64) 
> files closed. This also helps reducing number of files waiting in RCU 
> queues for final freeing as call_rcu() might have called 
> force_quiescent_state()

the -rt tree already has this latency breaker (and had it for a long 
time), it just somehow didnt get pushed upstream.

> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
