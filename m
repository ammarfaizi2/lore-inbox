Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313258AbSDOUvu>; Mon, 15 Apr 2002 16:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313260AbSDOUvt>; Mon, 15 Apr 2002 16:51:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17158 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313258AbSDOUvs>; Mon, 15 Apr 2002 16:51:48 -0400
Date: Mon, 15 Apr 2002 13:49:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
In-Reply-To: <Pine.LNX.4.44L.0204151248350.16531-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0204151344200.13034-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Apr 2002, Rik van Riel wrote:
> replace slightly obscure while loops with for_each_zone and
> for_each_pgdat macros, this version has the added optimisation
> of skipping empty zones       (thanks to William Lee Irwin)

I'd suggest against making this kind of complicated inlien functions, and
I also don't see why the for_each_zone() isn't a simpler doubly nested
for-loop instead of being forced into a less obvious iterative loop?

In short, this looks syntactically simple, but the syntactic simplicity 
comes at the expense of a unnecessarily complex implementation.

		Linus

