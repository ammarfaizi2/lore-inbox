Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWFWOCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWFWOCn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWFWN5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:57:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:47319 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750702AbWFWNpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:45:30 -0400
Date: Fri, 23 Jun 2006 15:40:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       Frank Pavlic <fpavlic@de.ibm.com>
Subject: Re: [patch 4/4] lock validator: fix qeth compile warning
Message-ID: <20060623134034.GD15113@elte.hu>
References: <20060623132811.GH9446@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623132811.GH9446@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> +#ifdef CONFIG_LOCKDEP
>  static struct lockdep_type_key qdio_out_skb_queue_key;
> +#endif

ok, that's fine for now. I'm cleaning this up via introducing 
per-lock-variant keys. But maybe the best would be to offer the lock 
validator in a binary way only - either for all lock variants at once, 
or for none at all?

	Ingo
