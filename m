Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273904AbRJEUAH>; Fri, 5 Oct 2001 16:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273255AbRJET76>; Fri, 5 Oct 2001 15:59:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14856 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273065AbRJET7p>; Fri, 5 Oct 2001 15:59:45 -0400
Date: Fri, 5 Oct 2001 12:59:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: pre4 oom too soon
In-Reply-To: <Pine.LNX.4.21.0110051945080.1199-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0110051234040.2044-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Oct 2001, Hugh Dickins wrote:
>
> I'm not sure exactly what to blame in out_of_memory(), but it does
> look wrong to depend so much on whether nr_swap_pages happens to be 0
> at that instant or not, and a lot of that full swap is duplicated in
> the swap cache.  Probably that should be taken into consideration?

That sounds sane. If we have swap cache pages, we're not out of memory
yet.

		Linus

