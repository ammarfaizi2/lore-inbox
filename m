Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286904AbSA2Xi4>; Tue, 29 Jan 2002 18:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286871AbSA2Xhe>; Tue, 29 Jan 2002 18:37:34 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:26117 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287109AbSA2XgA>;
	Tue, 29 Jan 2002 18:36:00 -0500
Date: Tue, 29 Jan 2002 21:35:38 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <E16VhjU-0005Vb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0201292133400.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Alan Cox wrote:

> > We can let oracle shared memory segments use 4 MB pages,
> > but still use the normal page cache code to look up the
> > pages.
>
> That has some potential big wins beyond oracle. Some of the big number
> crunching algorithms also benefit heavily from 4Mb pages even when you
> try and minimise tlb misses.

Note that I'm not sure whether the complexity of using
4 MB pages is worth it or not ... I just like the fact
that the radix tree page cache gives us the opportunity
to easily implement and try it.

I like radix trees for making our design more flexible
and opening doors to possible new functionality.

It could even be a CONFIG option for the embedded folks,
if we can keep the code isolated enough ;)

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

