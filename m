Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131418AbQKYSUA>; Sat, 25 Nov 2000 13:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131532AbQKYSTu>; Sat, 25 Nov 2000 13:19:50 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:49395 "EHLO
        brutus.conectiva.com.br") by vger.kernel.org with ESMTP
        id <S131418AbQKYSTf>; Sat, 25 Nov 2000 13:19:35 -0500
Date: Sat, 25 Nov 2000 15:49:25 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Roger Larsson <roger.larsson@norran.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nigel Gamble <nigel@nrg.org>
Subject: Re: *_trylock return on success?
In-Reply-To: <00112516072500.01122@dox>
Message-ID: <Pine.LNX.4.21.0011251547210.8818-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000, Roger Larsson wrote:

> Questions:
>   What are _trylocks supposed to return?

It depends on the type of _trylock  ;(

>   Does spin_trylock and down_trylock behave differently?
>   Why isn't the expected return value documented?

The whole trylock stuff is, IMHO, a big mess. When you
change from one type of trylock to another, you may be
forced to invert the logic of your code since the return
code from the different locks is different.

For bitflags, for example, the trylock returns the state
the bit had before the lock (ie. 1 if the thing was already
locked).

For spinlocks, it'll probably return something else ;/

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
