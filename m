Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136537AbREDWUy>; Fri, 4 May 2001 18:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136543AbREDWUo>; Fri, 4 May 2001 18:20:44 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22541 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136537AbREDWUe>; Fri, 4 May 2001 18:20:34 -0400
Date: Fri, 4 May 2001 15:20:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3 one-liner bugfixes
In-Reply-To: <3AF32872.9137D070@colorfullife.com>
Message-ID: <Pine.LNX.4.31.0105041518080.1059-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 May 2001, Manfred Spraul wrote:
>
> * missing/wrong lock_kernel calls in fs/fcntl.c: getlk/setlk run without
> the big kernel lock. The ..64 function acquire the lock.

This is wrong. The big lock (if it is needed, but I thought the current
locking should be safe) should be pushed down into the point where it is
needed, not at the caller..

		Linus

