Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262109AbREZAXn>; Fri, 25 May 2001 20:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262108AbREZAXd>; Fri, 25 May 2001 20:23:33 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:58375 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262109AbREZAXP>; Fri, 25 May 2001 20:23:15 -0400
Date: Fri, 25 May 2001 17:23:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <Pine.LNX.4.33.0105252103570.10469-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0105251720110.1086-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh, also: the logic behind the change of the kmem_cache_reap() - instead
of making it conditional on the _reverse_ test of what it has historically
been, why isn't it just completely unconditional? You've basically
dismissed the only valid reason for it to have been (illogically)
conditional, so I'd have expected that just _removing_ the test is better
than reversing it like your patch does..

No?

		Linus

