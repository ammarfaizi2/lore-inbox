Return-Path: <linux-kernel-owner+w=401wt.eu-S932523AbXAQQ30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbXAQQ30 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbXAQQ30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:29:26 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38178 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932523AbXAQQ3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:29:25 -0500
Date: Wed, 17 Jan 2007 17:28:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: On some configs, sparse spinlock balance checking is broken
Message-ID: <20070117162817.GB14727@elte.hu>
References: <adaejpumt41.fsf@cisco.com> <20070117063450.GC14027@elte.hu> <adavej5k6ld.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adavej5k6ld.fsf@cisco.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.3 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roland Dreier <rdreier@cisco.com> wrote:

> And actually the lock stuff is OK, since it's not inlined -- it's the 
> unlock stuff that goes directly to the __raw versions.  But something 
> like the following works for me; does it look OK to you?

yeah, it looks good to me too. Hopefully this will work with the include 
file ordering of all platforms.

	Ingo
