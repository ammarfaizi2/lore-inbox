Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276190AbRJCNF5>; Wed, 3 Oct 2001 09:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276194AbRJCNFr>; Wed, 3 Oct 2001 09:05:47 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:38839 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S276190AbRJCNFi>;
	Wed, 3 Oct 2001 09:05:38 -0400
Date: Wed, 3 Oct 2001 09:03:19 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110031108550.2679-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.30.0110030850480.4495-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Ingo Molnar wrote:

>
> On Tue, 2 Oct 2001, jamal wrote:
>
> > This already is done in the current NAPI patch which you should have
> > seen by now. [...]
>

The paper is at: http://www.cyberus.ca/~hadi/usenix-paper.tgz
Robert can point you to the latest patches.

>
> but the objectives, judging from the description you gave, are i think
> largely orthogonal,  with some overlapping in the polling part.

yes. Weve done a lot of thoroughly thought work in that area and i think
it will be a sin to throw it out.

> The polling
> part of my patch is just a few quick lines here and there and it's not
> intrusive at all.

NAPI is not intrusive either, it is backward compatible.

> I needed it to make sure all problems are solved and
> that the system & network is actually usable in overload situations.
>

And you can; look at my previous email. I would rather patch 2.4 to use
NAPI than see your patch in there.

> you i think are concentrating on router performance (i'd add dedicated
> networking appliances to the list), using cooperative drivers. I trying to
> solve a DoS attack against 2.4 boxes, and i'm trying to guarantee the
> uninterrupted (pun unintended) functioning of the system from the point of
> the IRQ handler code.

No. NAPI is for any type of network activities not just for routers or
sniffers. It works just fine with servers. What do you see in there that
will make it not work with servers?

cheers,
jamal

