Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbREHGuk>; Tue, 8 May 2001 02:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbREHGub>; Tue, 8 May 2001 02:50:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52909 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129282AbREHGuU>;
	Tue, 8 May 2001 02:50:20 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.38698.313444.486904@pizda.ninka.net>
Date: Mon, 7 May 2001 23:50:18 -0700 (PDT)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105072038280.8237-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0105072234580.7685-100000@freak.distro.conectiva>
	<Pine.LNX.4.21.0105072038280.8237-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds writes:
 > My most favourite approach by far is to just remove the magic for
 > different writepage's altogether, and just unconditionally do a
 > writepage. But passing in enough information so that the writepage can
 > come to the right decision.
 ...
 > In fact, it might even clean stuff up. Who knows? At least
 > page_launder() would not need to know about magic dead swap pages, because
 > the decision would be entirely in writepage().

Sure this would work.

The only downside would be that the formerly "quick case" in the loop
of dealing with referenced pages would now need to go inside the page
lock.  It's probably a non-issue...

Later,
David S. Miller
davem@redhat.com

