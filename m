Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136648AbREAQId>; Tue, 1 May 2001 12:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136646AbREAQIW>; Tue, 1 May 2001 12:08:22 -0400
Received: from jalon.able.es ([212.97.163.2]:1510 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S136641AbREAQIG>;
	Tue, 1 May 2001 12:08:06 -0400
Date: Tue, 1 May 2001 18:07:58 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Hugh Dickins <hugh@veritas.com>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac2
Message-ID: <20010501180758.A1057@werewolf.able.es>
In-Reply-To: <20010501170632.A1057@werewolf.able.es> <Pine.LNX.4.21.0105011644170.1399-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0105011644170.1399-100000@localhost.localdomain>; from hugh@veritas.com on Tue, May 01, 2001 at 17:50:52 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.01 Hugh Dickins wrote:
> 
> Don't ask me why, but I think you may find it's Peter's patch to
> the women-and-children-first in kernel/fork.c: I'm not yet running
> -ac2, but I am trying that patch, fine on UP but hanging right there
> (well, I get a "go go go" message too) on SMP.
>

After APIC_DEBUG = 1, I also get the gogo, i will try reverting the change.

> Try reversing the:
> 
> -	p->counter = current->counter;
> -	current->counter = 0;
> +	p->counter = (current->counter + 1) >> 1;
> +	current->counter >>= 1;
> +	current->policy |= SCHED_YIELD;
> 

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.4-ac1 #1 SMP Tue May 1 11:35:17 CEST 2001 i686

