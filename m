Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADPB6>; Thu, 4 Jan 2001 10:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRADPBt>; Thu, 4 Jan 2001 10:01:49 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:52978 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129267AbRADPBe>; Thu, 4 Jan 2001 10:01:34 -0500
Date: Thu, 4 Jan 2001 13:00:28 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache 2nd chance replacement
In-Reply-To: <20010104013201.B6256@athlon.random>
Message-ID: <Pine.LNX.4.21.0101041255320.1188-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Andrea Arcangeli wrote:
> On Wed, Jan 03, 2001 at 09:09:01PM -0200, Rik van Riel wrote:
> > Ever heard of slocate / updatedb ?
> 
> ever heard of somebody killing all other tasks while updatedb is
> running?

Other tasks tend not to stress the dcache like updatedb does,
leading to the effect that updatedb can "flush out" the other
cached values faster than the other processes reference them.

This is something no amount of 2nd chance replacement or even
aging can prevent.

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
