Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135251AbREGXcY>; Mon, 7 May 2001 19:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135977AbREGXcO>; Mon, 7 May 2001 19:32:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60842 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135251AbREGXcF>;
	Mon, 7 May 2001 19:32:05 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.12397.976973.932858@pizda.ninka.net>
Date: Mon, 7 May 2001 16:31:57 -0700 (PDT)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105071621220.1475-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0105071820460.7506-100000@freak.distro.conectiva>
	<Pine.LNX.4.21.0105071621220.1475-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds writes:
 > 
 > On Mon, 7 May 2001, Marcelo Tosatti wrote:
 > > And thats what swap_writepage() is doing:
 > 
 > Ehh.. swap_writepage() is called with the page locked. So it _can_ depend
 > on it.
 > 
 > If the page isn't locked there, then THAT is a bug. A major one.

Linus, he's trying to point out that writepage() will recheck (under
lock) what you think my dead_swap_page thing is not checking :-)

My changes always call writepage() and always redo all the checks
under the proper locks.

Later,
David S. Miller
davem@redhat.com
