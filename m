Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262241AbTCMLkd>; Thu, 13 Mar 2003 06:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262243AbTCMLkc>; Thu, 13 Mar 2003 06:40:32 -0500
Received: from [80.190.48.67] ([80.190.48.67]:36870 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id <S262241AbTCMLkc> convert rfc822-to-8bit; Thu, 13 Mar 2003 06:40:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] bug in 2.4 bh_kmap_irq() breaks IDE under preempt patch
Date: Thu, 13 Mar 2003 12:50:58 +0100
User-Agent: KMail/1.4.3
Cc: Joe Korty <joe.korty@ccur.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
References: <200303122213.WAA17415@rudolph.ccur.com> <200303131126.17963.m.c.p@wolk-project.de> <20030313102854.GC827@suse.de>
In-Reply-To: <20030313102854.GC827@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303131250.58828.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 March 2003 11:28, Jens Axboe wrote:

Hi Jens,

> > 	local_irq_enable();
> > ^ isn't this missing too with your suggested one-liner?
> no, the local_irq_restore() brings back the irq flags from before we did
> the irq disable. if interrupts were disabled before bh_kmap_irq() was
> called, we must not enable them. basically, maintain the same flags.
hmm, then I am blind 8-) ... Thanks.

ciao, Marc
