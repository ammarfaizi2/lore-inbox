Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbRETKE4>; Sun, 20 May 2001 06:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261513AbRETKEq>; Sun, 20 May 2001 06:04:46 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:40719 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261511AbRETKEl>;
	Sun, 20 May 2001 06:04:41 -0400
Date: Sun, 20 May 2001 07:04:31 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105201104090.610-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0105200703270.5531-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Mike Galbraith wrote:

> but ;-)
> 
> Looking at the locking and trying to think SMP (grunt) though, I
> don't like the thought of taking two locks for each page until

> 100%.  The data in that block is toast anyway.  A big hairy SMP
> box has to feel reclaim_page(). (they probably feel the zone lock
> too.. probably would like to allocate blocks)

Indeed, but this is a separate problem.  Doing per-CPU private
(small, 8-32 page?) free lists is probably a good idea, but I
don't really think it's related to kreclaimd ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

