Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132786AbRDUSBL>; Sat, 21 Apr 2001 14:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132788AbRDUSBC>; Sat, 21 Apr 2001 14:01:02 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:31503 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132786AbRDUSAv>;
	Sat, 21 Apr 2001 14:00:51 -0400
Date: Sat, 21 Apr 2001 14:55:52 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: try_to_swap_out() deactivating pages w. count > 2
In-Reply-To: <Pine.LNX.4.21.0104211450560.1685-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0104211454580.1685-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Rik van Riel wrote:
> On Sat, 21 Apr 2001, Linus Torvalds wrote:

> > Ehh... And if we didn't do that, then how could they every become less
> > active?
> > 
> > We should _absolutely_ do the swap space reclaiming without looking at
> > the page count.
> 
> page->age != page->count

Umm, forget that.  We only decrease page->age in refill_inactive_scan,
so we NEED to put it there. You're right, I should wake up and think
a bit more about my own code ;)

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

