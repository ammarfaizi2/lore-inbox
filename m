Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbTBOWO3>; Sat, 15 Feb 2003 17:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTBOWO3>; Sat, 15 Feb 2003 17:14:29 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:42382 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265246AbTBOWO2>; Sat, 15 Feb 2003 17:14:28 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 15 Feb 2003 14:31:37 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: James Antill <james@and.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <m3fzqpgxlx.fsf@code.and.org>
Message-ID: <Pine.LNX.4.50.0302151430230.1891-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com>
 <Pine.LNX.4.50.0302141553020.988-100000@blue1.dev.mcafeelabs.com>
 <m3fzqpgxlx.fsf@code.and.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, James Antill wrote:

> > I would personally like it a lot to have timer events available on
> > pollable fds. Am I alone in this ?
>
>  Think of "timer events" as a single TCP connection, so you have...
>
> time X: empty
> time X+Y: timed event "Arrives"
> time X+Z: timed event "Arrives"
>
> ...at which point it's pretty obvious that if you "poll" the timer
> event queue from anytime before X+Y it'll be empty, and anytime after
> X+Y it'll be "full". There isn't any point in being able to distinguish
> between the events X+Y and X+Z, you only need to know a timed event has
> occurred so you should process all timed events that are needed.
>  At which point you just need to work out the difference between X and
> X+Y, and pass that to poll/sigtimedwait/etc.

I'm sorry, I'm a bit confused. What's the point here ?



- Davide

