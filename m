Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261990AbREYWgW>; Fri, 25 May 2001 18:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbREYWgM>; Fri, 25 May 2001 18:36:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:50440 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261990AbREYWgD>; Fri, 25 May 2001 18:36:03 -0400
Date: Fri, 25 May 2001 19:35:58 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <Pine.LNX.4.31.0105251410040.7867-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0105251932380.10469-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Linus Torvalds wrote:
> On Fri, 25 May 2001, Rik van Riel wrote:
> >
> > OK, shoot me.  Here it is again, this time _with_ patch...
>
> I'm not going to apply this as long as it plays experimental
> games with "shrink_icache()" and friends. I haven't seen anybody
> comment on the performance on this, and I can well imagine that
> it would potentially shrink the dcache too aggressively when
> there are lots of inactive-dirty pages around, where
> page_launder is the right thing to do, and shrinking
> icache/dcache might not be.

Your analysis exactly describes what happens in your current
code, though I have to admit that my patch doesn't change it.

Without the patch my workstation (with ~180MB RAM) usually has
between 50 and 80MB of inode/dentry cache and real usable stuff
gets  swapped out.

Either you can go make Linux 2.4 usable again for normal people,
or you can go buy us all a gig of ram.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

