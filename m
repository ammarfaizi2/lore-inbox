Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265444AbRFVPvc>; Fri, 22 Jun 2001 11:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265452AbRFVPvW>; Fri, 22 Jun 2001 11:51:22 -0400
Received: from www.wen-online.de ([212.223.88.39]:52743 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S265444AbRFVPvO>;
	Fri, 22 Jun 2001 11:51:14 -0400
Date: Fri, 22 Jun 2001 17:50:19 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Alan Cox <laughing@shared-source.org>
Subject: Re: Linux 2.4.5-ac15 / 2.4.6-pre5
In-Reply-To: <20010622160821.A7032@frodo.uni-erlangen.de>
Message-ID: <Pine.LNX.4.33.0106221747090.782-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2001, Walter Hofmann wrote:

> Ok, I managed to press SysRq-T this time ond got a trace for my hang.
> Symbols are resolved by klog. If you prefer ksymopps please tell me, I
> used klog because ksymopps seems to drop all lines without symbols.

Someone else might want that and/or a complete trace.  I can see enough
to say it looks an awful lot like a little gremlin that's been plagueing
me off and on for months. (off at the moment. if he moved into your box,
you can keep him.. I don't want him back:))

> There seem to be no kernel deamons in the trace? Is this normal, or is
> the log buffer too small? If it is the latter, how can I increase its
> size?

I don't think it matters much.  I strongly suspect we'd just see more
of the same.  Try commenting out the current->policy |= SCHED_YIELD in
__alloc_pages() just for grins (more or less).

>  6  5  1  77232   2692   2136  47004 560 892  2048  1524 10428 285529   2  98   0
                                                           ^^^^^
Was disk running?  (I bet not.. bet it stopped just after stall began)

	-Mike

