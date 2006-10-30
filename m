Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965471AbWJ3JH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965471AbWJ3JH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965472AbWJ3JH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:07:26 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40404 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965471AbWJ3JHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:07:23 -0500
Date: Mon, 30 Oct 2006 10:06:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Jiri Kosina <jikos@jikos.cz>,
       Marcel Holtmann <marcel@holtmann.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/2] lockdep: annotate bcsp driver
Message-ID: <20061030090655.GA28026@elte.hu>
References: <1162199005.24143.169.camel@taijtu> <1162199192.24143.172.camel@taijtu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162199192.24143.172.camel@taijtu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.18-1.2699.fc6 #1
> ---------------------------------------------
> swapper/0 is trying to acquire lock:
>  (&list->lock#3){+...}, at: [<c05ad307>] skb_dequeue+0x12/0x43
> 
> but task is already holding lock:
>  (&list->lock#3){+...}, at: [<df98cd79>] bcsp_dequeue+0x6a/0x11e [hci_uart]
> 
> 
> Two different list locks nest, annotate so.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
