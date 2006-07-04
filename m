Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWGDMBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWGDMBu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWGDMBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:01:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:57788 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932228AbWGDMBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:01:49 -0400
Date: Tue, 4 Jul 2006 13:56:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Zach Brown <zach.brown@oracle.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH] mthca: initialize send and receive queue locks separately
Message-ID: <20060704115656.GA1539@elte.hu>
References: <20060704085653.GA13426@elte.hu> <20060704094219.GO21049@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704094219.GO21049@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5063]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michael S. Tsirkin <mst@mellanox.co.il> wrote:

> > Has no effect on non-lockdep kernels.
> 
> Hmm ... adding parameters to function still has text cost, I think. No?

it shouldnt - it's a static function and the parameter is unused _and_ 
is of a type that is zero-size [on non-lockdep kernels] - gcc ought to 
be able to optimize it out.

	Ingo
