Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLOU06>; Fri, 15 Dec 2000 15:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLOU0t>; Fri, 15 Dec 2000 15:26:49 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:35315 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129183AbQLOU0m>; Fri, 15 Dec 2000 15:26:42 -0500
Date: Fri, 15 Dec 2000 17:55:08 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Mike Black <mblack@csihq.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
In-Reply-To: <20001215195433.G17781@inspiron.random>
Message-ID: <Pine.LNX.4.21.0012151752421.3596-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2000, Andrea Arcangeli wrote:

> x()
> {
> 
> 	switch (1) {
> 	case 0:
> 	case 1:
> 	case 2:
> 	case 3:
> 	;
> 	}
> }
> 
> Why am I required to put a `;' only in the last case and not in
> all the previous ones?

That `;' above is NOT in just the last one. In your above
example, all the labels will execute the same `;' statement.

In fact, the default behaviour of the switch() operation is
to fall through to the next defined label and you have to put
in an explicit `break;' if you want to prevent `case 0:' from
reaching the `;' below the `case 3:'...

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
