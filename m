Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277568AbRKAChU>; Wed, 31 Oct 2001 21:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277667AbRKAChM>; Wed, 31 Oct 2001 21:37:12 -0500
Received: from [208.129.208.52] ([208.129.208.52]:53266 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277580AbRKACgz>;
	Wed, 31 Oct 2001 21:36:55 -0500
Date: Wed, 31 Oct 2001 18:18:10 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andi Kleen <ak@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cache colour task_structs
In-Reply-To: <p73668vqn9j.fsf@amdsim2.suse.de>
Message-ID: <Pine.LNX.4.40.0110311816490.1484-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Nov 2001, Andi Kleen wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> >
> > We need to perturb esp colour too. It might be the right way to do this
> > is slab based kernel stacks, it might be that your code is cheaper than
> > the cost of getting current the really hard way and we should just add
> > random numbers to the initial esp of a task ?
>
> You could do that even today (without slab task_struct) by using a
> random/coloured at fork time value for esp0.  This could just be a static
> colour counter that is subtracted.

Hey, ... I do that in userspace at thread creation time with a random
alloca(), ... but it's to prevent stack pointer guessing in case of buffer
overflows :)




- Davide


