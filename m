Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131714AbRCTEm5>; Mon, 19 Mar 2001 23:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131717AbRCTEmr>; Mon, 19 Mar 2001 23:42:47 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:10504 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131714AbRCTEmh>; Mon, 19 Mar 2001 23:42:37 -0500
Date: Mon, 19 Mar 2001 20:41:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 3rd version of R/W mmap_sem patch available
In-Reply-To: <Pine.LNX.4.33.0103200133240.2830-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0103192037270.819-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Mar 2001, Rik van Riel wrote:
>
> (ie the patch really isn't ready yet to be included in the
> main kernel ... OTOH, the changes needed to make it ready
> are all trivial and tedious ;))

They are trivial and tedious only if done wrong - which will also add tons
of new places where we lock and unlock only to lock again.

My -pre5 has the non-trivial "fix the calling convention and require that
pmd/pgd_alloc() be called with the lock held" version of the patch.

		Linus

