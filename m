Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWIAIyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWIAIyI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 04:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWIAIyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 04:54:08 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59360 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932447AbWIAIyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 04:54:06 -0400
Date: Fri, 1 Sep 2006 10:46:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [ BUG: bad unlock balance detected! ] in 2.6.18-rc5
Message-ID: <20060901084642.GA11232@elte.hu>
References: <20060901064319.GA2065@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901064319.GA2065@ff.dom.local>
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


* Jarek Poplawski <jarkao2@o2.pl> wrote:

> spin_unlock_irqrestore() goes through lockdep but 
> spin_lock_irqrestore() doesn't.

good catch! Andrew: i think this is a must-have for 2.6.18.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
