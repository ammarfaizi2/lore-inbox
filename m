Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbRE3N53>; Wed, 30 May 2001 09:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbRE3N5T>; Wed, 30 May 2001 09:57:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:47114 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262779AbRE3N5C>; Wed, 30 May 2001 09:57:02 -0400
Date: Wed, 30 May 2001 09:20:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jonathan Morton <chromi@cyberspace.org>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Plain 2.4.5 VM
In-Reply-To: <l03130301b73a9b647979@[192.168.239.105]>
Message-ID: <Pine.LNX.4.21.0105300913240.4783-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 May 2001, Jonathan Morton wrote:

> >The page aging logic does seems fragile as heck.  You never know how
> >many folks are aging pages or at what rate.  If aging happens too fast,
> >it defeats the garbage identification logic and you rape your cache. If
> >aging happens too slowly...... sigh.
> 
> Then it sounds like the current algorithm is totally broken and needs
> replacement.  If it's impossible to make a system stable by choosing the
> right numbers, the system needs changing, not the numbers.  I think that's
> pretty much what we're being taught in Control Engineering.  :)

The problem is that we allow _every_ task to age pages on the system at
the same time --- this is one of the things which is fucking up.

The another problem is that don't limit the writeout in the VM. 

We (me and Rik) are going to work on this later --- right now I'm busy
with the distribution release and Rik is travelling. 

