Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286399AbSAAXuV>; Tue, 1 Jan 2002 18:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286395AbSAAXuL>; Tue, 1 Jan 2002 18:50:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26385 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286387AbSAAXt4>;
	Tue, 1 Jan 2002 18:49:56 -0500
Message-ID: <3C324B21.B5620DE6@mandrakesoft.com>
Date: Tue, 01 Jan 2002 18:49:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Re: NFS "dev_t" issues..
In-Reply-To: <Pine.LNX.4.33.0201011524440.957-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 1 Jan 2002, Jeff Garzik wrote:
> >
> > What do you think about the attached simple patch, making the cookie
> > size more explicit?
> 
> Well, I suspect that we actually should also make the format explicit, and
> basically use the same translation that I did for the NFS filehandle. That
> way it's still just a cookie, but it's a cookie with (a) explicit size and
> (b) meaning that won't change over different kernel revisions.

true, each filesystem needs to figure out how to make sure their on-disk
format doesn't change across kernel revisions...  Storing the raw i_rdev
onto disk definitely silly but it appears to be an issue some
filesystems will have to deal with.  I'm leaving reiserfs alone so they
can make a policy decision...

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
