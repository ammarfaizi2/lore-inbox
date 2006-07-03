Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWGCGID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWGCGID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWGCGID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:08:03 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53891 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750704AbWGCGIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:08:01 -0400
Date: Mon, 3 Jul 2006 08:03:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@mbligh.org, linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: [patch] sched: fix macro -> inline function conversion bug
Message-ID: <20060703060320.GA15782@elte.hu>
References: <44A8567B.2010309@mbligh.org> <20060702164113.6dc1cd6c.akpm@osdl.org> <20060703052538.GB13415@elte.hu> <20060702224247.21e8aa8f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060702224247.21e8aa8f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5239]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > i checked the scheduler queue and nothing jumped out at me, except 
> > the cleanup bug fixed by the patch below. (which should be harmless 
> > in this particular case - nr_running should never be smaller than 0 
> > or larger than ~4 billion. A fix is warranted nevertheless.)
> 
> Did you work out which divide is getting the div-by-zero?  I started 
> at it a bit and wasn't sure - am getting wildly different code 
> generation over here.

my bet is on sched-group-cpu-power-setup-cleanup.patch.

	Ingo
