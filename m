Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136668AbREARPs>; Tue, 1 May 2001 13:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136666AbREARPn>; Tue, 1 May 2001 13:15:43 -0400
Received: from bigmama.rhoen.de ([62.67.55.51]:60433 "EHLO rhoen.de")
	by vger.kernel.org with ESMTP id <S136670AbREARP2>;
	Tue, 1 May 2001 13:15:28 -0400
Date: Tue, 1 May 2001 19:12:50 +0200
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac2
Message-ID: <20010501191250.A669@macbeth.rhoen.de>
In-Reply-To: <20010501170632.A1057@werewolf.able.es> <Pine.LNX.4.21.0105011644170.1399-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.21.0105011644170.1399-100000@localhost.localdomain>; from hugh@veritas.com on Tue, May 01, 2001 at 04:50:52PM +0100
From: boris <boris@macbeth.rhoen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 04:50:52PM +0100, Hugh Dickins wrote:
 
> Don't ask me why, but I think you may find it's Peter's patch to
> the women-and-children-first in kernel/fork.c: I'm not yet running
> -ac2, but I am trying that patch, fine on UP but hanging right there
> (well, I get a "go go go" message too) on SMP.
> 
> Try reversing the:
> 
> -	p->counter = current->counter;
> -	current->counter = 0;
> +	p->counter = (current->counter + 1) >> 1;
> +	current->counter >>= 1;
> +	current->policy |= SCHED_YIELD;
> 
> and see if that works for you too.

OK works here ...


                 boris
 

