Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131694AbRCXPH7>; Sat, 24 Mar 2001 10:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131695AbRCXPHv>; Sat, 24 Mar 2001 10:07:51 -0500
Received: from www.wen-online.de ([212.223.88.39]:19976 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131694AbRCXPHj>;
	Sat, 24 Mar 2001 10:07:39 -0500
Date: Sat, 24 Mar 2001 16:06:57 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Jonathan Morton <chromi@cyberspace.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <l03130317b6e246476b8b@[192.168.239.101]>
Message-ID: <Pine.LNX.4.33.0103241531280.436-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2001, Jonathan Morton wrote:

> >General thread comment:
> >To those who are griping, and obviously rightfully so, Rik has twice
> >stated on this list that he could use some help with VM auto-balancing.
> >The responses (visible on this list at least) was rather underwhelming.
> >I noted no public exchange of ideas.. nada in fact.
> >
> >Get off your lazy butts and do something about it.  Don't work on the
> >oom-killer though.. that's only a symptom.  Work on the problem instead.
>
> Since I'm hacking around in this area anyway (warning: kernel newbie
> alert!), I'd be happy to help examine the balancing code from a fresh
> perspective.  Where should I be looking?

Everything in mm plus fs/buffer.c at least. (plus includes)  A good
place to start is with __alloc_pages().. that will drag you through
a lot of the balancing code.  Following entry points (sys_brk, sys_mmap
etc) is highly recommended.  Be prepared for dizzy spells if you've
never toured mm-land before :)

	-Mike

