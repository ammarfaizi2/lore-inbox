Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130356AbRADOc7>; Thu, 4 Jan 2001 09:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbRADOct>; Thu, 4 Jan 2001 09:32:49 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:18926 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129572AbRADOch>; Thu, 4 Jan 2001 09:32:37 -0500
Date: Thu, 4 Jan 2001 12:32:23 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: try_to_swap_out() return value problem?
In-Reply-To: <Pine.LNX.4.21.0101040308450.1174-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101041225140.1188-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Marcelo Tosatti wrote:

> Your latest changes to try_to_swap_out() does not seem to be
> obviously correct.

> Now refill_inactive() relies on the assumption that swap_out()
> returning 1 means we successfully freed a page:

The changes try_to_swap_out() has seen in recent
months indeed have the potential to really disturb
the balance between refill_inactive_scan() and
swap_out() ...

Looking into changing/fixing/... this balance may
have some influence on performance, but now that
aging has been reintroduced tweaking the balance no
longer seems to have the huge influence it had in
2.2.

Having said that, it may be good to re-balance the
VM a bit for 2.4.1...

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
