Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129684AbQLRVVF>; Mon, 18 Dec 2000 16:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129930AbQLRVUq>; Mon, 18 Dec 2000 16:20:46 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:45048 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129684AbQLRVUi>; Mon, 18 Dec 2000 16:20:38 -0500
Date: Mon, 18 Dec 2000 18:48:50 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Chris Lattner <sabre@nondot.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <20001218214252.B23365@athlon.random>
Message-ID: <Pine.LNX.4.21.0012181847360.2595-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, Andrea Arcangeli wrote:
> On Mon, Dec 18, 2000 at 06:29:24PM -0200, Rik van Riel wrote:
> > Wrong. Getblk won't deadlock, it will just sleep and another
> 
> getblk will deadlock.

OUCH. The only protection we have against this is the fact
that atomic allocations are not allowed to eat up all memory
in the system and that every thread can only have 1 getblk
operation at a time, right?

But even so, the deadlock is still theoretically possible and
should probably be fixed, this sounds too much like a time
bomb waiting to go off... ;(

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
