Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266248AbUGJNyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUGJNyx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 09:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUGJNyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 09:54:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60905 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266248AbUGJNyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 09:54:51 -0400
Date: Sat, 10 Jul 2004 15:55:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: ismail =?iso-8859-1?Q?d=F6nmez?= <ismail.donmez@gmail.com>
Cc: Redeeman <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710135555.GA31068@elte.hu>
References: <20040709182638.GA11310@elte.hu> <1089407610.10745.5.camel@localhost> <20040710080234.GA25155@elte.hu> <20040710085044.GA14262@elte.hu> <2a4f155d040710035512f21d34@mail.gmail.com> <20040710123520.GA27278@elte.hu> <2a4f155d04071005585b5d8999@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a4f155d04071005585b5d8999@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=0, required 5.9,
	autolearn=not spam
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* ismail dönmez <ismail.donmez@gmail.com> wrote:

> > what filesystem are you using?
> > 
> 
> XFS

i've fixed latencies in ext3, i'm not sure how bad XFS is. But 2-3
seconds delay is almost impossible to be a true scheduling latency -
it's probably IO latency impacting your audio application. (it could
also be normal preemption latency, if those tasks are not running as
SCHED_FIFO - but 2-3 seconds preemption latency should not be caused by
a simple cp -a. This leaves IO latency.).

	Ingo
