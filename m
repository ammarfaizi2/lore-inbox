Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275756AbRI1B3Y>; Thu, 27 Sep 2001 21:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275774AbRI1B3O>; Thu, 27 Sep 2001 21:29:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5903 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275756AbRI1B24>; Thu, 27 Sep 2001 21:28:56 -0400
Date: Thu, 27 Sep 2001 18:28:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>,
        Robert Macaulay <robert_macaulay@dell.com>,
        Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs.
 2.4.9-ac14/15(+stuff)]
In-Reply-To: <Pine.LNX.4.33L.0109272050570.19147-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0109271827001.3101-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note that if you do end up applying my suggested patch for testing, you
also need to add __GFP_WAITBUF to SLAB_LEVEL_MASK in <linux/slab.h>
otherwise the slab allocator will be really unhappy the first time it sees
any normal allocation..

(Ie very early at boot).

		Linus

