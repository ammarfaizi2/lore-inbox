Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271759AbRHUWfa>; Tue, 21 Aug 2001 18:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRHUWfU>; Tue, 21 Aug 2001 18:35:20 -0400
Received: from hera.cwi.nl ([192.16.191.8]:42647 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271759AbRHUWfI>;
	Tue, 21 Aug 2001 18:35:08 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 21 Aug 2001 22:35:20 GMT
Message-Id: <200108212235.WAA197891@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, bcrl@redhat.com
Subject: Re: FYI  PS/2 Mouse problems -- userland issue
Cc: linux-kernel@vger.kernel.org, satch@fluent-access.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Armed with docs I was able to see just why our code
> is completely wrong for handling things like the ps/2
> mouse being removed at runtime.

Yes, or being added, to be more precise. But it will not be
easy to do it right. So many different ps2-like types of mouse.
There are heuristics, like the AA 00 that I gave last week or so.
(But not every ps2-mouse emits this sequence.)
And one can keep track of the timing. But the fact that the length
of a packet is unknown (3, 4, 5, 8 bytes), and that in some modes
and relative positions arbitrary data is legal, makes it more or less
impossible to write code that is provably correct.
Also state machines have difficulties. Many types of mouse react
to special sequences of ordinary commands, and enter a non-ps2 mode.

As we already remarked in the previous round,
this is no kernel business.

Andries

[departing now - probably away from email for a while]

