Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSIIBnW>; Sun, 8 Sep 2002 21:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSIIBnW>; Sun, 8 Sep 2002 21:43:22 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36768 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S315988AbSIIBnV>;
	Sun, 8 Sep 2002 21:43:21 -0400
Date: Mon, 9 Sep 2002 03:53:20 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Anton Altaparmakov <aia21@cantab.net>, <linux-kernel@vger.kernel.org>
Subject: Re: pinpointed: PANIC caused by dequeue_signal() in current Linus 
 BK tree
In-Reply-To: <Pine.LNX.4.44.0209081835260.1401-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209090342410.6004-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Sep 2002, Linus Torvalds wrote:

> 0x5a5a5a5a is the slab poisoning byte, I bet somebody free's the thing,
> and Ingo and I never noticed because we didn't have slab debugging
> enabled.
> 
> Ingo, mind looking at this a bit?

yes, i'm on it. It could also be the missing initialization of the
shared-pending queue. Funny - i usually have CONFIG_SLAB_DEBUGGING enabled
all the time - but not for this patch :-|

	Ingo

