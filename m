Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276940AbRJCSdM>; Wed, 3 Oct 2001 14:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276941AbRJCSdC>; Wed, 3 Oct 2001 14:33:02 -0400
Received: from [208.129.208.52] ([208.129.208.52]:1540 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S276940AbRJCScw>;
	Wed, 3 Oct 2001 14:32:52 -0400
Date: Wed, 3 Oct 2001 11:37:23 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: jamal <hadi@cyberus.ca>
cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Andreas Dilger <adilger@turbolabs.com>,
        <linux-netdev@oss.sgi.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110031101460.4833-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.40.0110031130430.1575-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, jamal wrote:
> > NAPI seems to be very promising to fix the total system overload case
> > (so many packets arrive that despite irq mitigation the system is still
> > overloaded).
> >
> > But the implementation of irq mitigation is driver specific, and a 10
> > millisecond stop is far too long.
> >
>
> violent agreement.

The Ingo's solution move the mitigation control into the kernel with the
immediate advantage that it'll work right now with existing drivers.
I think that the idea of kirqpoll is good but the long term solution
should be the move of the mitigation knowledge inside the drivers that
will register their own kirqpoll callbacks when they're going to mask
irqs.
In this case the "intelligence" about irq rates is left in the place where
there's more knowledge about the I/O traffic nature.



- Davide


