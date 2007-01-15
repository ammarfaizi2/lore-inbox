Return-Path: <linux-kernel-owner+w=401wt.eu-S932089AbXAOHWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbXAOHWT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 02:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbXAOHWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 02:22:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55529 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089AbXAOHWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 02:22:19 -0500
Date: Mon, 15 Jan 2007 08:17:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.20-rc4-mm1 md problem
Message-ID: <20070115071747.GA31267@elte.hu>
References: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0016]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> My system hangs on this
> http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/bug2.jpg
> http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/mm-config
> 
> Debug plan:
> - revert md-* patches
> - binary search
> 
> Does someone have a better idea?

Thomas saw something similar yesterday and he the partial results that 
git.block (between rc2-mm1 and rc4-mm1) breaks certain disk drivers or 
filesystems drivers. For me it worked fine, so it must be only on some 
combinations. The changes to ll_rw_block.c look quite extensive.

	Ingo
