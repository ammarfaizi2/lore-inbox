Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275816AbRJFW6h>; Sat, 6 Oct 2001 18:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275809AbRJFW62>; Sat, 6 Oct 2001 18:58:28 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:61702 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275813AbRJFW6W>; Sat, 6 Oct 2001 18:58:22 -0400
Date: Sun, 7 Oct 2001 00:58:41 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Anton Blanchard <anton@samba.org>, Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <E15q09C-0002X7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1011007003803.18004D-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Nothing dangeorus there. The -ac vm isnt triggering these cases.
> > 
> > Sorry, but it can be triggered by _ANY_ VM since buddy allocator was
> > introduced. You have no guarantee, that you find two or more consecutive
> > free pages. And if you don't, poll() fails. 
> 
> The two page case isnt one you need to worry about.  To all intents and
> purposes it does not happen,

How do you know it? I showed a simple case where it may happen.

> and if you do the maths it isnt going to
> fail in any interesting ways. Once you go to the 4 page set the odds get
> a lot longer and then rapidly get very bad indeed,

I hope you don't want to count probability that the server will or won't
crash (yes, crash, because when poll in main loop fails, the server
process has not many choices - it can only terminate itself). This reminds
me some Microsoft announcement saying that Windows NT are 3 times more
stable than Windows 95 :-) 

And it does happen - see this:
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0012.3/0711.html
Maybe probability was reduced somehow, but the problem is still there.

Mikulas

