Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131336AbRCSDBR>; Sun, 18 Mar 2001 22:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131344AbRCSDBH>; Sun, 18 Mar 2001 22:01:07 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:29968 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131336AbRCSDBA>; Sun, 18 Mar 2001 22:01:00 -0500
Date: Sun, 18 Mar 2001 23:59:18 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process
 information?)
In-Reply-To: <Pine.LNX.4.31.0103181719440.2956-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0103182358200.13050-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001, Linus Torvalds wrote:
> On Sun, 18 Mar 2001, Rik van Riel wrote:
> >
> > Indeed, having threaded apps do multiple page faults at the
> > same time is the main goal of this patch. However, I don't
> > see how it would be good for scalability to have multiple
> > threads fault in the same page at the same time, when they
> > could just wait for one of them to do the work.
> 
> But they will.
> 
> That's what lock_page() etc are there for - there's no need for the VM
> to synchronize because we already have the synchronization primitives
> at a lower level.

Indeed. I'll go multithread the do_no_page and do_swap_page
functions tomorrow (maybe even tonight ;)).

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

