Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136228AbRASUxr>; Fri, 19 Jan 2001 15:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136275AbRASUxj>; Fri, 19 Jan 2001 15:53:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:44380 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136228AbRASUx3>; Fri, 19 Jan 2001 15:53:29 -0500
Date: Fri, 19 Jan 2001 21:54:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010119215400.B8717@athlon.random>
In-Reply-To: <20010118220428.G28276@athlon.random> <200101191752.UAA24169@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101191752.UAA24169@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Fri, Jan 19, 2001 at 08:52:53PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 08:52:53PM +0300, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > I thought setsockopt is meant to set an option in the socket,
> 
> It is not.

The manpage disagrees with you:

       getsockopt, setsockopt - get and set options on sockets                              
				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

SIOCPUSH doesn't fit in get/setsockopt, face it.

> > controls the I/O (aka ioctl ;). Anyways either ioctl or setsockopt is fine in
> > pratice
> 
> After BKL is moved down.

The BKL will be moved down in the next months regardless of where we put the
functionality, as said in my original email choosing in function of the BKL in
ioctl VFS is wrong IMHO.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
