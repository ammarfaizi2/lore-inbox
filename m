Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289752AbSBESqF>; Tue, 5 Feb 2002 13:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289766AbSBESpz>; Tue, 5 Feb 2002 13:45:55 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:2052 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289752AbSBESpk>; Tue, 5 Feb 2002 13:45:40 -0500
Date: Tue, 5 Feb 2002 16:45:11 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Pavel Machek <pavel@suse.cz>
Cc: Jeff Garzik <garzik@havoc.gtf.org>, <arjan@fenrus.demon.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020205142154.D37@toy.ucw.cz>
Message-ID: <Pine.LNX.4.33L.0202051644340.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2002, Pavel Machek wrote:

> > > > the biggest reason for this is that we *suck* at readahead for mmap....
> > >
> > > Is there not also fault overhead and similar issues related to mmap(2)
> > > in general, that are not present with read(2)/write(2)?
> >
> > If a fault is more expensive than a system call, we're doing
> > something wrong in the page fault path ;)
>
> You can read 128K at a time, but you can't fault 128K...

Why not ?

If the pages are present (read-ahead) and the page table
is present, I see no reason why we couldn't fill in 32
page table entries at once.

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

