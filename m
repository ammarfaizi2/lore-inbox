Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132805AbRDYWNJ>; Wed, 25 Apr 2001 18:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132881AbRDYWM7>; Wed, 25 Apr 2001 18:12:59 -0400
Received: from china.patternbook.com ([216.254.75.60]:24829 "EHLO
	free.transpect.com") by vger.kernel.org with ESMTP
	id <S132805AbRDYWMu>; Wed, 25 Apr 2001 18:12:50 -0400
Date: Wed, 25 Apr 2001 18:12:38 -0500
From: Whit Blauvelt <whit@transpect.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Dave Mielke <dave@mielke.cc>, Tim Moore <timothymoore@bigfoot.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 Realaudio masq problem
Message-ID: <20010425181238.A1616@free.transpect.com>
In-Reply-To: <Pine.LNX.4.30.0104251450550.1012-100000@dave.private.mielke.cc> <988232207.32641.4.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <988232207.32641.4.camel@nomade>; from xavier.bestel@free.fr on Wed, Apr 25, 2001 at 10:56:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2001 at 10:56:11PM +0200, Xavier Bestel wrote:
> Le 25 Apr 2001 14:52:56 -0400, Dave Mielke a �crit :

> > strace writes to standard error, not standard output, by default. Better yet,
> > though, use the -o option of strace to direct its output to a file, which
> > leaves the standard output streams alone for the aplication being traced.

Okay, so being unfamiliar with strace, I should be able to invoke something
like "strace -o log realplay some-realaudio-url"? And this should mean
something to me?

> I didn't follow this thread at all (just caught this last mail), but I
> use realplayer8 here, and I actually had to *rmmod* the realaudio
> masquerading module to make it stream audio from the internet on a
> masqueraded machine. The server is a debian with kernel 2.2.19, does
> NAT.

Thanks for reasuring me there's something broken in the module. Xavier, do
you happen to know what transport mode your realplay is using then? That
would show under View | Preferences | Transport. And if you hit the
Autoconfigure button therer, does it succeed? It doesn't for me either with
or without the module loaded, and it used to with a 2.2.17 kernel plus
realplay 7 rather than 8.

Of course, the masq module is only to handle udp - if real goes to tcp it
doesn't need it, so I suspect what Xavier's seeing is it working via tcp -
but perhaps some servers today refuse to do anything but udp connections?

Whit

PS: Please cc me, I'm not on the list.
