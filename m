Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318986AbSHSTHL>; Mon, 19 Aug 2002 15:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318987AbSHSTHL>; Mon, 19 Aug 2002 15:07:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11787 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318986AbSHSTHL>; Mon, 19 Aug 2002 15:07:11 -0400
Date: Mon, 19 Aug 2002 12:10:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Dave McCracken <dmccr@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
In-Reply-To: <Pine.LNX.4.44.0208192034260.30906-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.31.0208191210040.6752-100000@torvalds-p95.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Aug 2002, Ingo Molnar wrote:
>
> well, this means that we'd still have to iterate through both lists in
> wait4(), and we'd have to maintain the ptrace list(s) in all the relevant
> codepaths - does this buy us anything relative to -B4?

Ok, you've convinced me. The reparenting is fairly ugly, but it sounds
like other implementations would be fairly equivalent and it would be
mainly an issue of just which list we'd work on.

		Linus

