Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286294AbRLJSGI>; Mon, 10 Dec 2001 13:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286338AbRLJSF6>; Mon, 10 Dec 2001 13:05:58 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:64272 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286294AbRLJSFl>; Mon, 10 Dec 2001 13:05:41 -0500
Date: Mon, 10 Dec 2001 16:05:14 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <volodya@mindspring.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: mm question
In-Reply-To: <Pine.LNX.4.20.0112101226500.17940-100000@node2.localnet.net>
Message-ID: <Pine.LNX.4.33L.0112101557520.4755-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001 volodya@mindspring.com wrote:
> On Mon, 10 Dec 2001, Alan Cox wrote:
>
> > > I don't want to move them - I just want to collect all that are free and
> > > then try to free some more.
> >
> > How will you free them, you don't know who owns them.
>
> I think you misunderstood me - this allocation happens in response to
> the system call _not_ in an interrupt handler. So it is ok to wait -
> as long as needed. I was thinking of calling page swapper or something
> and perhaps going after I/O buffers first.

Even if you have a handle on a physical page, you don't know
what processes are using the page, nor if there are additional
users besides the processes.

This makes it rather hard to go around trying to free pages
within a certain physical range.

cheers,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

