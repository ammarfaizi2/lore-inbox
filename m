Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267701AbUIHNs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267701AbUIHNs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269166AbUIHNrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:47:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32908 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267701AbUIHNjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:39:03 -0400
Date: Wed, 8 Sep 2004 15:40:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Scott Wood <scott@timesys.com>, Andrey Panin <pazke@donpac.ru>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908134032.GA24201@elte.hu>
References: <20040908120613.GA16916@elte.hu> <413EFB11.2000507@timesys.com> <20040908142529.A31922@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908142529.A31922@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Sep 08, 2004 at 08:29:05AM -0400, La Monte H.P. Yarroll wrote:
> > In the interests of full provinence, the TimeSys patches are based on
> > work by Andrey Panin.
> 
> Btw, Andrey's patches got all the things right I complained about :)

do you mean the irq and softirq threading patches? Unfortunately, while
they were rather clean the generic bits were also quite substantially
broken semantically on SMP so while i carried them for a while in the
voluntary-preempt patch i had to drop and redo them all from scratch.
Scott Wood then sent ppc bits which might be based on the other code. 
Anyway, it seems everyone wants roughly the same thing, it only has to
actually happen now ;-) Once we have kernel/hardirq.c then the
irq-threading patches become nicely local and maintainable.

	Ingo
