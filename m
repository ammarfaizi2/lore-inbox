Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132996AbRADNgo>; Thu, 4 Jan 2001 08:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133010AbRADNgf>; Thu, 4 Jan 2001 08:36:35 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:14836 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132996AbRADNga>; Thu, 4 Jan 2001 08:36:30 -0500
Date: Thu, 4 Jan 2001 11:34:57 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Zlatko Calusic <zlatko@iskon.hr>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] add PF_MEMALLOC to __alloc_pages()
In-Reply-To: <87g0j0qlvy.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.21.0101041134300.1188-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jan 2001, Zlatko Calusic wrote:
> Rik van Riel <riel@conectiva.com.br> writes:
> 
> > +			current->flags |= PF_MEMALLOC;
> >  			try_to_free_pages(gfp_mask);
> > +			current->flags &= ~PF_MEMALLOC;
> 
> Hm, try_to_free_pages already sets the PF_MEMALLOC flag!

Yes. Linus already pointed out this error to me
yesterday (and his latest tree should be fine).

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
