Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136670AbREAR23>; Tue, 1 May 2001 13:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136672AbREAR2X>; Tue, 1 May 2001 13:28:23 -0400
Received: from jalon.able.es ([212.97.163.2]:1001 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S136670AbREAR1e>;
	Tue, 1 May 2001 13:27:34 -0400
Date: Tue, 1 May 2001 19:27:26 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: boris <boris@macbeth.rhoen.de>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac2
Message-ID: <20010501192726.A1246@werewolf.able.es>
In-Reply-To: <20010501170632.A1057@werewolf.able.es> <Pine.LNX.4.21.0105011644170.1399-100000@localhost.localdomain> <20010501191250.A669@macbeth.rhoen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010501191250.A669@macbeth.rhoen.de>; from boris@macbeth.rhoen.de on Tue, May 01, 2001 at 19:12:50 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.01 boris wrote:
> On Tue, May 01, 2001 at 04:50:52PM +0100, Hugh Dickins wrote:
>  
> > Don't ask me why, but I think you may find it's Peter's patch to
> > the women-and-children-first in kernel/fork.c: I'm not yet running
> > -ac2, but I am trying that patch, fine on UP but hanging right there
> > (well, I get a "go go go" message too) on SMP.
> > 
> > Try reversing the:
> > 
> > -	p->counter = current->counter;
> > -	current->counter = 0;
> > +	p->counter = (current->counter + 1) >> 1;
> > +	current->counter >>= 1;
> > +	current->policy |= SCHED_YIELD;
> > 
> > and see if that works for you too.
> 
> OK works here ...
> 

Me too.

Perhaps this reschedules ok in UP but kinda fails in SMP...

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.4-ac1 #1 SMP Tue May 1 11:35:17 CEST 2001 i686

