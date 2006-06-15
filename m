Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWFOKxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWFOKxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 06:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWFOKxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 06:53:44 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:40621 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964772AbWFOKxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 06:53:43 -0400
Date: Thu, 15 Jun 2006 12:52:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
       jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, fpavlic@de.ibm.com
Subject: Re: [patch] ipv4: fix lock usage in udp_ioctl
Message-ID: <20060615105208.GA2934@elte.hu>
References: <20060614194305.GB10391@osiris.ibm.com> <E1FqeXX-0008OE-00@gondolin.me.apana.org.au> <20060615052806.GA19803@elte.hu> <20060615065531.GA10411@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615065531.GA10411@osiris.ibm.com>
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

> How about the patch below? The warning goes away and I assume 
> "tmp_list" needs lockdep_reinit_key too, since it should have the same 
> locking rules as the rest of qeth's skb-queue management.

yeah, looks good.

	Ingo
