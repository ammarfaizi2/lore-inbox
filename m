Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbRGIM1g>; Mon, 9 Jul 2001 08:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbRGIM1Q>; Mon, 9 Jul 2001 08:27:16 -0400
Received: from www.wen-online.de ([212.223.88.39]:25619 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S267049AbRGIM1I>;
	Mon, 9 Jul 2001 08:27:08 -0400
Date: Mon, 9 Jul 2001 14:26:21 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Christoph Rohland <cr@sap.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <m3r8vq8hla.fsf@linux.local>
Message-ID: <Pine.LNX.4.33.0107091420580.405-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jul 2001, Christoph Rohland wrote:

> Hi Mike,
>
> On Mon, 9 Jul 2001, Mike Galbraith wrote:
> >> > But still this may be a hint.
> >
> > _Anyway_, tmpfs is growing and growing from stdout.  If I send
> > output to /dev/null, no growth.  Nothing in tmpfs is growing, so I
> > presume the memory is disappearing down one of X or KDE's sockets.
>
> So tmpfs is not growing, but you still have a mem leak only with
> tmpfs? Is there some deleted file allocating blocks? Or did
> redirecting stdout fix the problem. I am not sure that I understand
> the situation.

tmpfs is growing.  Redirecting output to /dev/null fixes it.  (whee)

> > No such leakage without tmpfs, and I can do all kinds of normal
> > file type use of tmpfs with no leakage.
>
> BTW I am running /tmp on tmpfs all the time with KDE and never
> experienced something like that. But of course I ran oom without size
> limits.

I only started using tmpfs for /tmp after I found out how much faster
gcc runs without the -pipe switch.  Writing temp files to disk is
much faster than using -pipe.. with tmpfs, it's even faster :)

	-Mike

