Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131700AbQLVL4i>; Fri, 22 Dec 2000 06:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131992AbQLVL42>; Fri, 22 Dec 2000 06:56:28 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:29687 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131700AbQLVL4O>; Fri, 22 Dec 2000 06:56:14 -0500
Date: Fri, 22 Dec 2000 09:24:54 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Robert Read <rread@datarithm.net>
cc: Sourav Sen <sourav@csa.iisc.ernet.in>, linux-kernel@vger.kernel.org
Subject: Re: Wiring down Pages
In-Reply-To: <20001221150845.I24558@tenchi.datarithm.net>
Message-ID: <Pine.LNX.4.21.0012220914010.1613-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2000, Robert Read wrote:
> On Thu, Dec 21, 2000 at 06:46:33PM -0200, Rik van Riel wrote:
> > 
> > page_cache_drop(page); <= removes your extra count
> 
> I can't find that function, do you mean page_cache_free() and
> page_cache_release(), both are aliases for __free_page(). Maybe
> we need another alias. :)

page_cache_release(), indeed. My bad...

> Should non-page cache related code use get_page() and
> __free_page() directly?  Or should the page_cache_* macros be
> used everywhere?

The non-page cache related code should use get_page() and
__free_page() (put_page?) directly. There may come a day
where the pagecache page size can be different from the
page size ...

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
