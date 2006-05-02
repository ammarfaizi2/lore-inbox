Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWEBOde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWEBOde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWEBOde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:33:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:26049 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964843AbWEBOdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:33:33 -0400
Date: Tue, 2 May 2006 16:38:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       coreteam@netfilter.org, "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [netfilter-core] Re: [lockup] 2.6.17-rc3: netfilter/sctp: lockup in	sctp_new(), do_basic_checks()
Message-ID: <20060502143814.GA3789@elte.hu>
References: <20060502113454.GA28601@elte.hu> <20060502134053.GA30917@elte.hu> <4457648C.6020100@trash.net> <20060502140102.GA31743@elte.hu> <4457654A.9040200@trash.net> <20060502141621.GA32284@elte.hu> <44576CD5.60603@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44576CD5.60603@trash.net>
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


* Patrick McHardy <kaber@trash.net> wrote:

> > +	/*
> > +	 * Dont trust the initial offset:
> > +	 */
> > +	offset = skb->nh.iph->ihl * 4 + sizeof(sctp_sctphdr_t);
> > +	if (offset >= skb->len)
> > +		return 1;
> > +
> 
> That part is unnecessary, the presence of one sctp_sctphdr_t
> has already been verified by skb_header_pointer() in sctp_new().

ok.

> How about this patch (based on your patch, but typos fixed and also 
> covers nf_conntrack)?

sure, fine with me!

	Ingo
