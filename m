Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286338AbRLJSK2>; Mon, 10 Dec 2001 13:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbRLJSKS>; Mon, 10 Dec 2001 13:10:18 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:20914 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S286338AbRLJSKK>; Mon, 10 Dec 2001 13:10:10 -0500
Date: Mon, 10 Dec 2001 13:08:17 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <Pine.LNX.4.33L.0112101557520.4755-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.20.0112101307360.18115-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Rik van Riel wrote:

> On Mon, 10 Dec 2001 volodya@mindspring.com wrote:
> > On Mon, 10 Dec 2001, Alan Cox wrote:
> >
> > > > I don't want to move them - I just want to collect all that are free and
> > > > then try to free some more.
> > >
> > > How will you free them, you don't know who owns them.
> >
> > I think you misunderstood me - this allocation happens in response to
> > the system call _not_ in an interrupt handler. So it is ok to wait -
> > as long as needed. I was thinking of calling page swapper or something
> > and perhaps going after I/O buffers first.
> 
> Even if you have a handle on a physical page, you don't know
> what processes are using the page, nor if there are additional
> users besides the processes.
> 
> This makes it rather hard to go around trying to free pages
> within a certain physical range.

Well, what does kernel do when it runs out of memory ? For example when I
mmap a large file and start reading it back and force ?

                                   Vladimir Dergachev

> 
> cheers,
> 
> Rik
> -- 
> DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 

