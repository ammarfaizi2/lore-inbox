Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131403AbQK2Tg7>; Wed, 29 Nov 2000 14:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131485AbQK2Tgu>; Wed, 29 Nov 2000 14:36:50 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:15599 "EHLO
        brutus.conectiva.com.br") by vger.kernel.org with ESMTP
        id <S131403AbQK2Tgp>; Wed, 29 Nov 2000 14:36:45 -0500
Date: Wed, 29 Nov 2000 17:05:20 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <20001129195630.A6006@athlon.random>
Message-ID: <Pine.LNX.4.21.0011291704140.5302-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Andrea Arcangeli wrote:
> On Wed, Nov 29, 2000 at 04:08:26AM -0500, Alexander Viro wrote:
> > Problem fixed by Jens' patch had been there since March, so if it's a
> 
> No, it's there only since Jens fixed the request merging bug in
> test11 or so.
> 
> With previous kernel the head pointer couldn't change so that
> change was unnecessary and initializing it outside the critical
> section was a micro scalability optimization :).

To be honest, I have a big problem with micro optimisations
that prevent the big optimisations from happening.

Would it be an idea to explicitly comment such dangerous
micro optimisations so people implementing the big optimisations
later on won't run into nasty surprises?

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
