Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131998AbRCVJGH>; Thu, 22 Mar 2001 04:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132026AbRCVJF5>; Thu, 22 Mar 2001 04:05:57 -0500
Received: from www.wen-online.de ([212.223.88.39]:32013 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131998AbRCVJFu>;
	Thu, 22 Mar 2001 04:05:50 -0500
Date: Thu, 22 Mar 2001 10:04:28 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Kevin Buhr <buhr@stat.wisc.edu>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <vba4rwm6fp5.fsf@mozart.stat.wisc.edu>
Message-ID: <Pine.LNX.4.33.0103220951460.1667-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Mar 2001, Kevin Buhr wrote:

> Mike Galbraith <mikeg@wen-online.de> writes:
> >
> > Yes.  I'm so used to UP numbers I didn't think.  I saw user larger than
> > real on my UP box yesterday during some testing, and then seeing this
> > post... oops.
>
> Okay, so you see "user > real" on a UP box running an SMP kernel.

On ac20 I see this (has rw_mmap_sem patch in place tho..), but not on
2.4.3-pre6 with Linus' deadlock fix.

[snip nice explanation.. thanks]  box is genuine UP btw.

> In any event, if the discrepancy is large: if user, for a
> single-threaded process, exceeds the real time by more than 1% (or a
> few hundredths of a second, whichever is greater) on any system, I
> think this indicates a serious problem.

Let me check virgin ac20 and see what it does.

2.4.2.ac20.virgin   2.4.3-pre6
real    11m0.708s   11m58.617s
user    15m8.720s   7m29.970s
sys     1m31.410s   0m41.590s

It looks like ac20 is doing some double accounting.

	-Mike

(fwiw, the smp/up numbers suck rocks compared to up/up)

