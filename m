Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUEYTxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUEYTxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUEYTxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:53:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19910 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265092AbUEYTx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:53:26 -0400
Date: Tue, 25 May 2004 21:54:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
Message-ID: <20040525195437.GA10784@elte.hu>
References: <40B3A35D.4020702@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B3A35D.4020702@colorfullife.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Manfred Spraul <manfred@colorfullife.com> wrote:

> >also, the 4:4 overhead is really a hardware problem - and there are
> >x86-compatible CPUs (amd64) where the TLB flush problem has already been
> >solved: on amd64 the 4:4 feature has no noticeable overhead.
> >
> Do you have an idea why amd64 is better for 4g4g? Which benchmark did
> you use for testing?

i used an althlon64 CPU. amd64 is better because it has a hardware
feature that 'watches' for memory updates to cached TLBs, and it tags
the TLBs by cr3. So it can avoid having to flush those TLBs that didnt
actually change. So an amd64 CPU has in excess of 1000+ TLBs ...

	Ingo
