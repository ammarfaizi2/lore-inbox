Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWCITAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWCITAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 14:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWCITAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 14:00:09 -0500
Received: from kanga.kvack.org ([66.96.29.28]:64463 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750972AbWCITAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 14:00:08 -0500
Date: Thu, 9 Mar 2006 13:39:29 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@vger.kernel.org, shai@scalex86.org, Andi Kleen <ak@suse.de>
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
Message-ID: <20060309183929.GF5410@kvack.org>
References: <20060308211733.GA5410@kvack.org> <20060308222528.GE4493@localhost.localdomain> <20060308224140.GC5410@kvack.org> <20060308154321.0e779111.akpm@osdl.org> <20060309001803.GF4493@localhost.localdomain> <20060308163258.36f3bd79.akpm@osdl.org> <20060309080651.GA3599@localhost.localdomain> <440FE3E2.1060307@yahoo.com.au> <20060309082251.GB3599@localhost.localdomain> <440FEA24.3060307@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440FEA24.3060307@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 07:41:08PM +1100, Nick Piggin wrote:
> Considering that local_t has been broken so that basically nobody
> is using it, now is a great time to rethink the types before it
> gets fixed and people start using it.

I'm starting to get more concerned as the per-cpu changes that keep adding 
more overhead is getting out of hand.

> And modelling the type on the atomic types would make the most
> sense because everyone already knows them.

Except that the usage models are different; local_t is most likely to be 
used for cpu local statistics or for sequences, where making them signed 
is a bit backwards.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
