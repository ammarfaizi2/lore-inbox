Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQL2QkP>; Fri, 29 Dec 2000 11:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131463AbQL2QkF>; Fri, 29 Dec 2000 11:40:05 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:20498 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129828AbQL2Qju>; Fri, 29 Dec 2000 11:39:50 -0500
Date: Fri, 29 Dec 2000 12:16:54 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Juan Quintela <quintela@fi.udc.es>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove __mark_buffer_dirty and related changes
In-Reply-To: <200012291031.eBTAVO301699@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0012291208190.13063-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2000, Russell King wrote:

> Marcelo Tosatti writes:
> > +int mark_buffer_dirty(struct buffer_head *bh)
> >  {
> > +	if (!atomic_set_buffer_dirty(bh)) {
> > +		return 1;
> > +	}
> > +	return 0;
> >  }
> 
> Any particular reason why you don't to:
> 
> 	return !atomic_set_buffer_dirty(bh);
> 
> which generates better code on some systems?

No. 

If Linus applies the patch I'll change the code to the way you suggested.

Thanks. 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
