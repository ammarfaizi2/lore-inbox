Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129490AbRBTWTQ>; Tue, 20 Feb 2001 17:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130115AbRBTWTG>; Tue, 20 Feb 2001 17:19:06 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:37638 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130096AbRBTWSu>; Tue, 20 Feb 2001 17:18:50 -0500
Date: Tue, 20 Feb 2001 18:30:29 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exclusive wakeup for lock_buffer
In-Reply-To: <E14V3Du-0005Py-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102201827520.3901-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Feb 2001, Alan Cox wrote:

> > --- linux/include/linux/locks.h.orig	Mon Feb 19 23:16:50 2001
> > +++ linux/include/linux/locks.h	Mon Feb 19 23:21:48 2001
> > @@ -13,6 +13,7 @@
> >   * lock buffers.
> >   */
> >  extern void __wait_on_buffer(struct buffer_head *);
> > +extern void __lock_buffer(struct buffer_head *);
> 
> So are we starting 2.5 now ?

Alan,

This patch only avoids unecessary wakeups. It doesn't add any new
functionality.




