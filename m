Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287406AbSACQj3>; Thu, 3 Jan 2002 11:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287409AbSACQjT>; Thu, 3 Jan 2002 11:39:19 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:50446 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287406AbSACQjI>;
	Thu, 3 Jan 2002 11:39:08 -0500
Date: Thu, 3 Jan 2002 14:38:55 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: <harald.holzer@eunet.at>, <linux-kernel@vger.kernel.org>,
        <wookie@osdl.org>, <velco@fadata.bg>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
In-Reply-To: <20020103153355.612bd269.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33L.0201031437500.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Stephan von Krawczynski wrote:
> On Thu, 3 Jan 2002 11:28:45 -0200 (BRST)
> Rik van Riel <riel@conectiva.com.br> wrote:
>
> > Another item to look into is removing the page cache hash table
> > and replacing it by a radix tree or hash trie, in the hopes of
> > improving scalability while at the same time saving some space.
>
> Ah, didn't we see such a patch lately in LKML? If I remember correct I
> saw some comparison charts too and some people testing it were happy
> with it. Just searched through the list: 24. dec :-) by Momchil
> Velikov Can someone with big mem have a look at the saving? How about
> 18-pre?

>From what velco told me on IRC, he is still tuning his work
and looking at further improvements.

One thing to keep in mind is that most pages are in the
page cache; we wouldn't want to reduce space in one data
structure just to use more space elsewhere, this is
something to look at very carefully...

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

