Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318370AbSG3Rqb>; Tue, 30 Jul 2002 13:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSG3Rqa>; Tue, 30 Jul 2002 13:46:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4100 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318367AbSG3RqY>; Tue, 30 Jul 2002 13:46:24 -0400
Date: Tue, 30 Jul 2002 14:49:39 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5-rmap: VM strict overcommit
In-Reply-To: <20020729222052.GA15219@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L.0207301449100.8815-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Pavel Machek wrote:

> > > In what scenario can "strict overcommit" kill?
> >
> > When the kernel grabs over 50% of RAM. Remember that includes page
> > tables. I've seen the kernel taking 35% of RAM.
>
> But it could happen that kernel would attempt to allocate 101% of RAM
> for page tables, right? At that even "paranoid overcommit" might be OOM,
> right?

Indeed, there are a number of places where memory allocation
by the kernel is pretty much unbound.

IMHO we need to fix those.

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

