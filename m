Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129818AbRAEUYo>; Fri, 5 Jan 2001 15:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130095AbRAEUYe>; Fri, 5 Jan 2001 15:24:34 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:60934 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129875AbRAEUY1>; Fri, 5 Jan 2001 15:24:27 -0500
Date: Fri, 5 Jan 2001 16:32:50 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <906850000.978724261@tiny>
Message-ID: <Pine.LNX.4.21.0101051630150.2882-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Jan 2001, Chris Mason wrote:

> 
> 
> On Friday, January 05, 2001 01:43:07 PM -0200 Marcelo Tosatti
> <marcelo@conectiva.com.br> wrote:
> 
> > 
> > On Fri, 5 Jan 2001, Chris Mason wrote:
> > 
> >> 
> >> Here's the latest version of the patch, against 2.4.0.  The
> >> biggest open issues are what to do with bdflush, since
> >> page_launder could do everything bdflush does.  
> > 
> > I think we want to remove flush_dirty_buffers() from bdflush. 
> > 
> 
> Whoops.  If bdflush doesn't balance the dirty list, who does?

Who marks buffers dirty. 

Linus changed mark_buffer_dirty() to use flush_dirty_buffers() in case
there are too many dirty buffers.

Also, I think in practice page_launder will help on balancing. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
