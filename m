Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSGSRYd>; Fri, 19 Jul 2002 13:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSGSRYd>; Fri, 19 Jul 2002 13:24:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46088 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316213AbSGSRYd>; Fri, 19 Jul 2002 13:24:33 -0400
Date: Fri, 19 Jul 2002 10:28:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
Subject: Re: [PATCH]: scheduler complex macros fixes
In-Reply-To: <Pine.LNX.4.44.0207201913400.17697-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207191025410.8500-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Jul 2002, Ingo Molnar wrote:
>
> well, SCHED_BATCH is in fact ready, so we might as well put it in. All the
> suggestions mentioned on lkml (or in private) are now included, there are
> no pending (known) problems, no objections, and a number of people are
> using it with success.

Well, I do actually have objections, mainly because I think it modifies
code that I'd rather have cleaned up in other ways _first_ (ie the return
path to user mode, which has pending irq_count/bh_count/preempt issues
that I consider to be about a million times more important than batch
scheduling).

So I'd rather have the non-batch stuff done first and independently.

			Linus

