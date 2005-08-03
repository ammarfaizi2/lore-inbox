Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVHCHuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVHCHuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 03:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVHCHuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 03:50:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21429 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262133AbVHCHux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 03:50:53 -0400
Date: Wed, 3 Aug 2005 09:51:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jack Steiner <steiner@sgi.com>
Subject: Re: [patch 1/2] sched: reduce locking in newidle balancing
Message-ID: <20050803075129.GA6013@elte.hu>
References: <42EF65A9.1060408@yahoo.com.au> <42EF65FF.2000102@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EF65FF.2000102@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Similarly to the earlier change in load_balance, only lock the 
> runqueue in load_balance_newidle if the busiest queue found has a 
> nr_running > 1. This will reduce frequency of expensive remote 
> runqueue lock aquisitions in the schedule() path on some workloads.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
