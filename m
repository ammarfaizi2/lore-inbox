Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275813AbRJ2Qyw>; Mon, 29 Oct 2001 11:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276477AbRJ2Qym>; Mon, 29 Oct 2001 11:54:42 -0500
Received: from waste.org ([209.173.204.2]:58397 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S275813AbRJ2Qyg>;
	Mon, 29 Oct 2001 11:54:36 -0500
Date: Mon, 29 Oct 2001 10:58:28 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Andreas Dilger <adilger@turbolabs.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random.c bugfix 
In-Reply-To: <200110291615.f9TGFYYY010564@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.30.0110291053240.5815-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Horst von Brand wrote:

> Andreas Dilger <adilger@turbolabs.com> said:
>
> [...]
>
> > (*) I don't know enough about the hash functions to know how to add a
> >     few odd bytes into the store in a useful and safe way.  We don't
> >     really want to discard them either - think if a user-space random
> >     daemon on an otherwise entropy-free system only writes one byte at
> >     a time...
>
> I'm no expert either, but padding with anything (zeroes?) to get the right
> length should be safe, no?

No. A 4-byte accumulator is the right answer. We have to be careful here
though - the actual entropy might be in the partial words, we have to
account for it conservatively.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

