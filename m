Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290454AbSBFMLg>; Wed, 6 Feb 2002 07:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290472AbSBFMKa>; Wed, 6 Feb 2002 07:10:30 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:57100 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290454AbSBFMKU>;
	Wed, 6 Feb 2002 07:10:20 -0500
Date: Tue, 5 Feb 2002 21:46:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jeff Garzik <garzik@havoc.gtf.org>, arjan@fenrus.demon.nl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020205204646.GB628@elf.ucw.cz>
In-Reply-To: <20020205142154.D37@toy.ucw.cz> <Pine.LNX.4.33L.0202051644340.12225-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0202051644340.12225-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > the biggest reason for this is that we *suck* at readahead for mmap....
> > > >
> > > > Is there not also fault overhead and similar issues related to mmap(2)
> > > > in general, that are not present with read(2)/write(2)?
> > >
> > > If a fault is more expensive than a system call, we're doing
> > > something wrong in the page fault path ;)
> >
> > You can read 128K at a time, but you can't fault 128K...
> 
> Why not ?
> 
> If the pages are present (read-ahead) and the page table
> is present, I see no reason why we couldn't fill in 32
> page table entries at once.

Ugh.

Okay, CPU will still have to fill its TLBs (it does not have to in
read case), but that is way easier operation. 

I did not think about this possibility, sorry.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
