Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313261AbSDOU7S>; Mon, 15 Apr 2002 16:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313264AbSDOU7R>; Mon, 15 Apr 2002 16:59:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13841 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S313261AbSDOU7Q>; Mon, 15 Apr 2002 16:59:16 -0400
Date: Mon, 15 Apr 2002 17:58:58 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, <wli@holomorphy.com>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
In-Reply-To: <Pine.LNX.4.33.0204151344200.13034-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0204151755491.16531-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2002, Linus Torvalds wrote:
> On Mon, 15 Apr 2002, Rik van Riel wrote:
> > replace slightly obscure while loops with for_each_zone and
> > for_each_pgdat macros, this version has the added optimisation
> > of skipping empty zones       (thanks to William Lee Irwin)
>
> I'd suggest against making this kind of complicated inlien functions, and
> I also don't see why the for_each_zone() isn't a simpler doubly nested
> for-loop instead of being forced into a less obvious iterative loop?

Because code that doesn't care about pgdats shouldn't have to
learn about them, IMHO.  I used to have the doubly nested for
loop in -rmap, but William Irwin came up with a way to make
it a singly nested loop for code that only cares about zones.

> In short, this looks syntactically simple, but the syntactic simplicity
> comes at the expense of a unnecessarily complex implementation.

Since it was mostly done to clean up code I guess it makes
sense to simplify the thing a bit, if possible.

However, I really don't like the fact of teaching now-simple
VM code about pgdats again ;)

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

