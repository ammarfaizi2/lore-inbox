Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbRGBDQz>; Sun, 1 Jul 2001 23:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266355AbRGBDQp>; Sun, 1 Jul 2001 23:16:45 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:65034 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266356AbRGBDQb>; Sun, 1 Jul 2001 23:16:31 -0400
Date: Sun, 1 Jul 2001 20:14:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Removal of PG_marker scheme from 2.4.6-pre
In-Reply-To: <Pine.LNX.4.33L.0107012358460.9312-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107012000440.7651-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correction: I said -ac13 was bad, but ac13 was actually ok. It was ac14
that was the problem spot.

Also note how Alan happened to merge the MM patches in the reverse order
from the preX series: in the -ac series, Rik's page_launder() patch is in
-ac14, while my VM changes are merged in -ac15. In my series, it was the
other way around: mine went in in -pre2, while Rik went into -pre3. In
both cases, it's the page_launder() thing that triggers it.

And in the -ac tree, there wasn't any interaction with other patches at
all, and ac14 has the "pure" page_launder() patch that was reversed in
-pre7.

And to make doubly sure, Tim <tcm@nac.net> also tested out various
pre-kernels and unofficial combinations. Thanks.

			Linus

