Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291102AbSBSKie>; Tue, 19 Feb 2002 05:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291096AbSBSKiY>; Tue, 19 Feb 2002 05:38:24 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:1285 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291106AbSBSKiU>;
	Tue, 19 Feb 2002 05:38:20 -0500
Date: Tue, 19 Feb 2002 07:38:02 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] reduce struct_page size
In-Reply-To: <Pine.LNX.4.33.0202181806340.24597-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0202190736290.1930-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Linus Torvalds wrote:
> On Mon, 18 Feb 2002, Rik van Riel wrote:
> >
> > o page->zone is shrunk from a pointer to an index into a small
> >   array of zones ... this means we have space for 3 more chars
> >   in the struct page to other stuff (say, page->age)
>
> Why not put "page->zone" into the page flags instead?

The original reason it's not in page->flags is that the
rmap patch also has page->age.

Furthermore, the NUMA folks wanted the ability to have
quite a few zones.

> The patch looks good, it's just silly to say that you made "struct page"
> smaller, and then waste four bytes.

If you want I'll look into shoving the zone bits into
page->flags ...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

