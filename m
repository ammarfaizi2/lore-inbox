Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274656AbRIYWg1>; Tue, 25 Sep 2001 18:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274655AbRIYWgR>; Tue, 25 Sep 2001 18:36:17 -0400
Received: from [195.223.140.107] ([195.223.140.107]:35056 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274653AbRIYWgJ>;
	Tue, 25 Sep 2001 18:36:09 -0400
Date: Wed, 26 Sep 2001 00:36:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Olivier Sessink <olivier@lx.student.wau.nl>, linux-kernel@vger.kernel.org
Subject: Re: weird memory related problems, negative memory usage or fake memory usage?
Message-ID: <20010926003626.L8350@athlon.random>
In-Reply-To: <20010924233139.A14548@fender.fakenet> <Pine.LNX.4.33L.0109241900550.1864-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109241900550.1864-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Mon, Sep 24, 2001 at 07:03:20PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 07:03:20PM -0300, Rik van Riel wrote:
> [Andrea, please read this bugreport ...]
> 
> On Mon, 24 Sep 2001, Olivier Sessink wrote:
> 
> > after upgrade from 2.4.10pre8 to 2.4.10 I have weird problems,
> > Xfree sometimes shows up with 99.9% memory in top (on a box with
> > 512 mb), and in ps axl it has 4294989036 in the RSS column. When
> > this happens the box starts to kill some processes, starts
> > heavily swapping (top reports > 400MB in the cache, but the
> > machine is heavily swapping!!!) and is completely unusable.
> 
> > Since this makes the machine completely unusable, and since it is not
> > happening on 2.4.10pre8 I guess it is a bug ;-)
> 
> >   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
> >  1262 root       5 -10 50764  -1M  1320 S <   2.7 99.9   0:01 XFree86
> 
> 
> It seems Andrea wasn't careful with the merge and
> backed out some of the locking wrt mm->rss.

thanks for forwarding this report, actually I just noticed this here and
that's good so I can reproduce :)

it is possible it is my mistake, but I don't think so, infact I don't
recall to have changed rss stuff or locking around it. Incidentally the
first time I reproduced it here was after the tlb shootdown patch from
Ben was introduced, never reproduced it here previously with only my
changes.  However it is possibly just a coincidence.

> 
> Andrea, you may want to spend some time auditing
> your VM like has been done with the other 2.4 VM.
> 
> cheers,
> 
> Rik
> --
> IA64: a worthy successor to the i860.
> 
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com/
> 
> 


Andrea
