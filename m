Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132785AbRDUR4b>; Sat, 21 Apr 2001 13:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132784AbRDUR4V>; Sat, 21 Apr 2001 13:56:21 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:23311 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132786AbRDUR4D>;
	Sat, 21 Apr 2001 13:56:03 -0400
Date: Sat, 21 Apr 2001 14:51:25 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: try_to_swap_out() deactivating pages w. count > 2
In-Reply-To: <200104211742.KAA17813@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0104211450560.1685-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Linus Torvalds wrote:
> In article <Pine.LNX.4.21.0104211336390.1685-100000@imladris.rielhome.conectiva>,
> Rik van Riel  <riel@conectiva.com.br> wrote:
> >
> >What I _am_ worried about is the fact that we do this to pages with
> >a really high page age. These things are in active use and cannot
> >be swapped out any time soon, yet we do claim swap space for it ...
> 
> Ehh... And if we didn't do that, then how could they every become less
> active?
> 
> We should _absolutely_ do the swap space reclaiming without looking at
> the page count.

page->age != page->count

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

