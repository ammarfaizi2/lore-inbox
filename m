Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275031AbRIYPEg>; Tue, 25 Sep 2001 11:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275032AbRIYPE1>; Tue, 25 Sep 2001 11:04:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:9223 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S275027AbRIYPEN>; Tue, 25 Sep 2001 11:04:13 -0400
Date: Tue, 25 Sep 2001 12:04:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 VM: what avoids from having lots of unwriteable inactive
 pages
In-Reply-To: <Pine.LNX.4.33.0109241817060.23252-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0109251203560.26091-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, Linus Torvalds wrote:
> On Mon, 24 Sep 2001, Marcelo Tosatti wrote:
> >
> > We keep calling swap_out(), which will not deactivate pages which _can_ be
> > written out, until we deactivate the pte's from the pages which are on the
> > inactive list.
>
> swap_out() will deactivate everything it finds to be not-recently used,
> and that's how the inactive list ends up getting replenished.

mlock()

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

