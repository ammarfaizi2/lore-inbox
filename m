Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbRAJUMF>; Wed, 10 Jan 2001 15:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129992AbRAJUL4>; Wed, 10 Jan 2001 15:11:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44805 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129903AbRAJULh>; Wed, 10 Jan 2001 15:11:37 -0500
Date: Wed, 10 Jan 2001 12:11:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andi Kleen <ak@suse.de>, Trond Myklebust <trond.myklebust@fys.uio.no>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <E14GQyR-0000mh-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101101210080.4572-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, Alan Cox wrote:
> 
> That is extremely undesirable behaviour. setuid() changes for pthreads crud
> should be done by the library emulation layer. Many people have very real
> and very good reasons for running multiple parallel ids. Just try writing
> a threaded ftp daemon (non anonymous) without that, or an nfs server

I absolutely think that "one thread, one ID" is the way to go.

That said, we can easily support the notion of CLONE_CRED if we absolutely
have to (and sane people just shouldn't use it), so if somebody wants to
work on this for 2.5.x...

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
