Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbTLTQhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 11:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTLTQhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 11:37:16 -0500
Received: from mx1.elte.hu ([157.181.1.137]:48051 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263840AbTLTQhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 11:37:14 -0500
Date: Sat, 20 Dec 2003 17:36:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, hawkes@babylon.engr.sgi.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: [RFC][PATCH] 2.6.0-test11 sched_clock() broken for "drifty ITC"
Message-ID: <20031220163628.GA27842@elte.hu>
References: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com> <20031220105031.GA17848@elte.hu> <3FE46345.1040102@cyberone.com.au> <20031220070532.05b7b268.akpm@osdl.org> <3FE466ED.5060701@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE466ED.5060701@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <piggin@cyberone.com.au> wrote:

> I'm just thinking that computers with unsynched clocks have less need
> for good interactivity, but thats probably too narrow and x86 a view
> anyway.

it's also a matter of predictable behavior. The scheduler should not
behave differently just because there's no synchronized clock. 
Behavioral forks like that tend to come back and cause trouble later.

	Ingo
