Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310637AbSDDTpz>; Thu, 4 Apr 2002 14:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311147AbSDDTpp>; Thu, 4 Apr 2002 14:45:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29189 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310637AbSDDTpj>; Thu, 4 Apr 2002 14:45:39 -0500
Date: Thu, 4 Apr 2002 11:45:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: Dave Hansen <haveblue@us.ibm.com>, "Adam J. Richter" <adam@yggdrasil.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
 boot time
In-Reply-To: <1017947795.22303.516.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0204041139060.12895-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Apr 2002, Robert Love wrote:
> 
> Eh, maybe - what about all the code that sets non-running before putting
> itself on a wait queue?

In most cases that code will call a schedule itself.

Of course, we might make just ZOMBIE a special case, but in general I
think it's simply absolutely wrong for the preemption to change task
internal data structures on its own.

		Linus

