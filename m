Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbTI1PwL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 11:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbTI1PwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 11:52:11 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:35741 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262576AbTI1PwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 11:52:09 -0400
Date: Sun, 28 Sep 2003 17:52:08 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with
 48mb ram under moderate load
In-Reply-To: <3F76DCEC.60508@softhome.net>
Message-ID: <Pine.LNX.4.58.0309281747460.13202@artax.karlin.mff.cuni.cz>
References: <ArQ0.821.23@gated-at.bofh.it> <ArQ0.821.25@gated-at.bofh.it>
 <ArQ0.821.21@gated-at.bofh.it> <ArZC.8f1.9@gated-at.bofh.it>
 <3F75EC3B.4030305@softhome.net> <20030927202148.GA31080@k3.hellgate.ch>
 <3F76DCEC.60508@softhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Oh, it does matter. My workstation has 1 GB RAM and 2 GB swap and I hardly
> > see any problems with paging <g>.
> >
>
>    Because your workload doesn't hit the 1GB limit.
>    Actually we just do not have fast enough I/O + CPU to utilize 1GB of
> RAM efficiently.
>
>    But if you will go into 128MB of RAM - you will see difference, where
> should be no difference.
>
>    Let's say (my personal exp.) cp'ing of kernel source with 0.5/0.25 GB
> RAM dosn't differ. Aproximately the same time. 0.25GB little bit faster
> - but it can be written off to noise. But try to do the same cp with
> 0.125GB - this cp (as of RH 2.4.20-20.9 +ext3 -swap) takes _*two*_ times
> longer. Should it be?

Yes, it should. If you have 0.25GB, it can be copied into cache. If you
have 0.125GB, it doesn't fit there.

Mikulas
