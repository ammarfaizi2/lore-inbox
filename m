Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135749AbREGX3O>; Mon, 7 May 2001 19:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135977AbREGX3E>; Mon, 7 May 2001 19:29:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:64005 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135749AbREGX2w>; Mon, 7 May 2001 19:28:52 -0400
Date: Mon, 7 May 2001 18:50:19 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105071621220.1475-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105071848210.7515-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 May 2001, Linus Torvalds wrote:

> 
> On Mon, 7 May 2001, Marcelo Tosatti wrote:
> > 
> > On 7 May 2001, Linus Torvalds wrote:
> > 
> > > But it is important to re-calculate the deadness after getting the
> > > lock. Before, it was just an informed guess. After the lock, it is
> > > knowledge. And you can use informed guesses for heuristics, but you
> > > must _not_ use them for any serious decisions.
> > 
> > And thats what swap_writepage() is doing:
> 
> Ehh.. swap_writepage() is called with the page locked. So it _can_ depend
> on it.

So the "dead_swap_page" logic is _not_ buggy and you are full of shit when
telling Alan to revert the change. (sorry, I could not avoid this one)

