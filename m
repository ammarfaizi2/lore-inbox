Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276233AbRJCN2I>; Wed, 3 Oct 2001 09:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276234AbRJCN16>; Wed, 3 Oct 2001 09:27:58 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:42423 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S276233AbRJCN1v>;
	Wed, 3 Oct 2001 09:27:51 -0400
Date: Wed, 3 Oct 2001 09:25:32 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110030850480.4495-100000@shell.cyberus.ca>
Message-ID: <Pine.GSO.4.30.0110030919370.4833-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, jamal wrote:

>
>
> On Wed, 3 Oct 2001, Ingo Molnar wrote:
>
> >
> > but the objectives, judging from the description you gave, are i think
> > largely orthogonal,  with some overlapping in the polling part.
>
> yes. Weve done a lot of thoroughly thought work in that area and i think
> it will be a sin to throw it out.
>

I hit the send button to fast..
The dynamic irq limiting (it must not be set by a system admin to conserve
the principle of work) could be used as a last resort. The point is, if
you are not generating a lot of interupts to begin with (as is the case
with NAPI), i dont see the irq rate limiting kicking in at all. Maybe for
broken drivers and perhaps for other devices other than those within the
network subsystem (i think weve pretty much taken care of the network
subsystem). But you must fix the irq sharing issue first and be
able to precisely isolate and punish the rude devices.

cheers,
jamal

