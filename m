Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUBCLHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 06:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUBCLHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 06:07:53 -0500
Received: from mail023.syd.optusnet.com.au ([211.29.132.101]:34536 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265974AbUBCLHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 06:07:48 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.1 Hyperthread smart "nice" 2
Date: Tue, 3 Feb 2004 22:07:38 +1100
User-Agent: KMail/1.6
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
References: <200401291917.42087.kernel@kolivas.org> <200402032152.46481.kernel@kolivas.org> <20040203105758.GA7783@elte.hu>
In-Reply-To: <20040203105758.GA7783@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402032207.38006.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004 21:58, Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> > At least it appears Intel are well aware of the priority problem, but
> > full priority support across logical cores is not likely. However I
> > guess these new instructions are probably enough to work with if
> > someone can do the coding.
>
> these instructions can be used in the idle=poll code instead of rep-nop.
> This way idle-wakeup can be done via the memory bus in essence, and the
> idle threads wont waste CPU time. (right now idle=poll wastes lots of
> cycles on HT boxes and is thus unusable.)

Thanks for explaining.

> for lowprio tasks they are of little use, unless you modify gcc to
> sprinkle mwait yields all around the 'lowprio code' - not very practical
> i think.

Yuck!

Looks like the kernel is the only thing likely to be smart enough to do this 
correctly for some time yet. 

Nick, any chance of seeing something like this in your sched domains? (that 
would be the right way unlike my hacking sched.c directly for a specific 
architecture).

Con
