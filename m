Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262090AbREQRho>; Thu, 17 May 2001 13:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262092AbREQRhe>; Thu, 17 May 2001 13:37:34 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54279 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262090AbREQRhR>;
	Thu, 17 May 2001 13:37:17 -0400
Date: Thu, 17 May 2001 14:37:03 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Chris Evans <chris@scary.beasts.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.30.0105171815230.14119-100000@ferret.lmh.ox.ac.uk>
Message-ID: <Pine.LNX.4.21.0105171434320.5531-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001, Chris Evans wrote:
> On Thu, 17 May 2001, Alan Cox wrote:
> 
> > 2.4.4-ac10
> [...]
> > 	- now 2.4.5pre vm seems sane dump other vmscan
> > 	  experiments
> 
> Has anyone benched 2.4.5pre3 vs 2.4.4 vs. ?

Marcelo saw a 30% speed increase from 2.4.4 to 2.4.5pre3
on several tests.

At the moment the main issues left seem to be:
- balancing the inode + dentry caches versus the rest of
  the memory users  (I'm working on it now)
- simplifying __alloc_pages() a bit  (I've got some things
  ready but I'm waiting for some other people who say they
  also have some stuff to add)
- making sure we get rid of all the highmem flushing
  deadlocks ... there may still be a few around (ben, marcelo?)


regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

