Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132151AbRDNNgN>; Sat, 14 Apr 2001 09:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132167AbRDNNgE>; Sat, 14 Apr 2001 09:36:04 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:41735 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132151AbRDNNfs>;
	Sat, 14 Apr 2001 09:35:48 -0400
Date: Sat, 14 Apr 2001 10:35:36 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <Pine.LNX.4.31.0104132138310.24573-100000@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.21.0104141034420.12164-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Apr 2001, Linus Torvalds wrote:
> On Sat, 14 Apr 2001, Rik van Riel wrote:
> >
> > Also, have you managed to find a real difference with this?
> 
> It actually makes a noticeable difference on lmbench, so I think adam is
> 100% right.
> 
> > If it turns out to be beneficial to run the child first (you
> > can measure this), why not leave everything the same as it is
> > now but have do_fork() "switch threads" internally ?
> 
> Probably doesn't much matter. We've invalidated the TLB anyway due to
> the page table copy, so the cost of switching the MM is not all that
> noticeable.

And we don't even have to physically switch MM, we could simply
fake stuff by updating pointers in the parent MM instead of the
child so by the time we exit do_fork() we're in the child...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

