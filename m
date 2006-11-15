Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030829AbWKOSdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030829AbWKOSdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030830AbWKOSdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:33:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56284 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030829AbWKOSdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:33:14 -0500
Date: Wed, 15 Nov 2006 19:31:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
Message-ID: <20061115183152.GA3160@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <20061115173252.GA24062@elte.hu> <455B557C.7020602@goop.org> <200611151905.04712.dada1@cosmosbay.com> <455B5C54.1050301@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455B5C54.1050301@goop.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0005]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> [...] However, when I measured segment register use timings, I didn't 
> see any dramatic costs associated with segment register use which 
> would account for a 5% hit in your benchmark.

if by that measurement you mean time-segops.c, i dont think it correctly 
measures 'mixed' use of different selector values for the same %gs 
segment selector. And that's what i suggested for you to measure in 
September, and that's what Eric's testcase triggers too.

	Ingo
