Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317525AbSGTVQ2>; Sat, 20 Jul 2002 17:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317531AbSGTVQ2>; Sat, 20 Jul 2002 17:16:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20215 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317525AbSGTVQ1>; Sat, 20 Jul 2002 17:16:27 -0400
Subject: Re: [PATCH] generalized spin_lock_bit
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, riel@conectiva.com.br
In-Reply-To: <20020720211539.GG1096@holomorphy.com>
References: <1027196511.1555.767.camel@sinai>
	<Pine.LNX.4.44.0207201335560.1492-100000@home.transmeta.com> 
	<20020720211539.GG1096@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 14:19:31 -0700
Message-Id: <1027199971.1555.797.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 14:15, William Lee Irwin III wrote:

> I was hoping to devolve the issue of the implementation of it to arch
> maintainers by asking for this. I was vaguely aware that the atomic bit
> operations are implemented via hashed spinlocks on PA-RISC and some
> others, so by asking for the right primitives to come back up from arch
> code I hoped those who spin elsewhere might take advantage of their
> window of exclusive ownership.

Yah, me too ;)

> Would saying "Here is an address, please lock it, and if you must flip
> a bit, use this bit" suffice? I thought it might give arch code enough
> room to wiggle, but is it enough?

I would prefer to do nothing right now.  We can implement the general
interface but keep the pte_chain_lock abstraction.  Individual
architectures can optimize their bitwise locking.

If that does not suffice and their is a REAL problem in the future we
can look to a better approach...

	Robert Love

