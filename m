Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317605AbSGXW3T>; Wed, 24 Jul 2002 18:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317627AbSGXW3T>; Wed, 24 Jul 2002 18:29:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1796 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317605AbSGXW3T>; Wed, 24 Jul 2002 18:29:19 -0400
Date: Wed, 24 Jul 2002 15:32:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Larson <plars@austin.ibm.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
In-Reply-To: <1027547187.7700.67.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0207241530060.10886-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24 Jul 2002, Paul Larson wrote:
>
> Error building 2.5.28:

Yes, a number of drivers won't compile on SMP because they want the global
lock (that is gone). This includes the cmd640 IDE driver, and the parallel
port driver (and a largish number of others too, but I think those two are
the really common ones).

It should all work the same way it always did on UP, and hopefully the
straggling drivers will be converted to use local spinlocks soon (and in
some cases the global irq lock might not even be needed at all)

		Linus

