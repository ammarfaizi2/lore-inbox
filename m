Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283658AbRLWFhF>; Sun, 23 Dec 2001 00:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283714AbRLWFg4>; Sun, 23 Dec 2001 00:36:56 -0500
Received: from tierra.ucsd.edu ([132.239.214.132]:51369 "EHLO burn")
	by vger.kernel.org with ESMTP id <S283708AbRLWFgm>;
	Sun, 23 Dec 2001 00:36:42 -0500
Date: Sat, 22 Dec 2001 21:35:37 -0800
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        billh@tierra.ucsd.edu, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011222213537.A12352@burn.ucsd.edu>
In-Reply-To: <20011219224717.A3682@redhat.com> <E16HTPN-0000v0-00@the-village.bc.nu> <20011221121644.A15926@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011221121644.A15926@redhat.com>; from bcrl@redhat.com on Fri, Dec 21, 2001 at 12:16:45PM -0500
From: Bill Huey <billh@tierra.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 12:16:45PM -0500, Benjamin LaHaise wrote:
> On Fri, Dec 21, 2001 at 05:24:33PM +0000, Alan Cox wrote:
> > select/poll is a win - and Java recently discovered poll/select semantics 8)
> 
> Anything is a win over Java's threading model.
> 
> 		-ben

Yeah, it's just another abstraction layer that lives on top of native threading
model, so you don't have to worry about stuff like spinlock contention since
it's been pushed down into the native threading implementation. It doesn't really
add a tremendous amount of overhead given how delegates all of that to the
native OS threading model.

Also, t would be nice to have some regular way of doing read-write lock without
having to implement it in Java language itself, but it's not too critical since
folks don't really push or use the JVM in that way just yet. It's certainly
important in certain high contention systems in the kernel.

bill

