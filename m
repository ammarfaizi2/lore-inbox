Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136615AbRASBUM>; Thu, 18 Jan 2001 20:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136599AbRASBUD>; Thu, 18 Jan 2001 20:20:03 -0500
Received: from [129.94.172.186] ([129.94.172.186]:49650 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S136597AbRASBT4>; Thu, 18 Jan 2001 20:19:56 -0500
Date: Fri, 19 Jan 2001 11:19:08 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Vlad Bolkhovitine <vladb@sw.com.sg>, <linux-kernel@vger.kernel.org>
Subject: Re: mmap()/VM problem in 2.4.0
In-Reply-To: <Pine.LNX.4.21.0101181525150.4333-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0101191117460.3368-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Marcelo Tosatti wrote:
> On Thu, 18 Jan 2001, Rik van Riel wrote:
> > On Fri, 12 Jan 2001, Vlad Bolkhovitine wrote:
> >
> > > You can see, mmap() read performance dropped significantly as
> > > well as read() one raised. Plus, "interactivity" of 2.4.0 system
> > > was much worse during mmap'ed test, than using read()
> > > (everything was quite smooth here). 2.4.0-test7 was badly
> > > interactive in both cases.
> >
> > Could have to do with page_launder() ... I'm working on
> > streaming mmap() performance here and have been working
> > on this for a week now (amongst other things).
>
> Also remember that drop_behind() is not working for mmap(), yet...

filemap_sync(..., MS_INVALIDATE) needs a 2-line change to have
drop-behind. I have this running (more or less) on my laptop here.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
