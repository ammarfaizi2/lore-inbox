Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272606AbRHaFLL>; Fri, 31 Aug 2001 01:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272607AbRHaFKv>; Fri, 31 Aug 2001 01:10:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64260 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272606AbRHaFKp>; Fri, 31 Aug 2001 01:10:45 -0400
Date: Thu, 30 Aug 2001 22:08:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108310128.f7V1SSn08071@moisil.badula.org>
Message-ID: <Pine.LNX.4.33.0108302204350.15159-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Aug 2001, Ion Badulescu wrote:
>
> Really? How so? We _know_ that the result of sizeof() fits confortably within
> "int"'s range. So the natural way to write that comparison would be
>
> 	if (len <= (int) sizeof(short) || len > (int) sizeof(*sunaddr))

You're so full of shit that it's incredible.

I'mnot going to argue this, when people call stuff like the above the
"natural way". This is not worth it.

The fact is, the way gcc currently does things, -Wsign-compare is useless.
Anybody who is honest would admit that. In order for the warning to become
useful, gcc would need to do value range analysis - which people have been
talking about, but which is not there yet.

There have been some constructive comments here (the automatic detection
of bad comparisons etc), but yours is just stupid.

		Linus

