Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262591AbREOA6O>; Mon, 14 May 2001 20:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262592AbREOA6E>; Mon, 14 May 2001 20:58:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:34063 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262591AbREOA5v>; Mon, 14 May 2001 20:57:51 -0400
Date: Mon, 14 May 2001 21:57:16 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmscan.c fixes
In-Reply-To: <Pine.LNX.4.21.0105141922490.32493-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0105142155520.18102-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, Marcelo Tosatti wrote:
> On Mon, 14 May 2001, Rik van Riel wrote:
>
> > +	/* XXX: dynamic free target is complicated and may be wrong... */
> >  	int freetarget = freepages.high + inactive_target / 3;
>
> I think its better if we just remove " + inactive_target / 3" here ---
> callers already account for the inactive_target when trying to
> calculate the free target anyway.

Right, there's really only one thing this "+ inactive_target / 3"
achieves ... more agressive flushing of dirty pages, by trying to
keep a larger free target.

Whether this is good or not I really don't know; this basically
boils down to the old "pre-flushing vs. delaying IO" thing.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

