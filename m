Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133113AbRDZFge>; Thu, 26 Apr 2001 01:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133110AbRDZFgY>; Thu, 26 Apr 2001 01:36:24 -0400
Received: from AMontpellier-201-1-2-100.abo.wanadoo.fr ([193.253.215.100]:19702
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S133113AbRDZFgK>; Thu, 26 Apr 2001 01:36:10 -0400
Subject: Re: 2.2.19 Realaudio masq problem
From: Xavier Bestel <xavier.bestel@free.fr>
To: Whit Blauvelt <whit@transpect.com>
Cc: Dave Mielke <dave@mielke.cc>, Tim Moore <timothymoore@bigfoot.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010425181238.A1616@free.transpect.com>
In-Reply-To: <Pine.LNX.4.30.0104251450550.1012-100000@dave.private.mielke.cc>
	<988232207.32641.4.camel@nomade>  <20010425181238.A1616@free.transpect.com>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10 (Preview Release)
Date: 26 Apr 2001 07:26:19 +0200
Message-Id: <988262902.32639.6.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25 Apr 2001 18:12:38 -0500, Whit Blauvelt a écrit :
> On Wed, Apr 25, 2001 at 10:56:11PM +0200, Xavier Bestel wrote:
> > Le 25 Apr 2001 14:52:56 -0400, Dave Mielke a écrit :
> 
> > > strace writes to standard error, not standard output, by default. Better yet,
> > > though, use the -o option of strace to direct its output to a file, which
> > > leaves the standard output streams alone for the aplication being traced.
> 
> Okay, so being unfamiliar with strace, I should be able to invoke something
> like "strace -o log realplay some-realaudio-url"? And this should mean
> something to me?
> 
> > I didn't follow this thread at all (just caught this last mail), but I
> > use realplayer8 here, and I actually had to *rmmod* the realaudio
> > masquerading module to make it stream audio from the internet on a
> > masqueraded machine. The server is a debian with kernel 2.2.19, does
> > NAT.
> 
> Thanks for reasuring me there's something broken in the module. Xavier, do
> you happen to know what transport mode your realplay is using then? That
> would show under View | Preferences | Transport. And if you hit the
> Autoconfigure button therer, does it succeed? It doesn't for me either with
> or without the module loaded, and it used to with a 2.2.17 kernel plus
> realplay 7 rather than 8.

Well, it says 'Automatically select best transport', and Autoconfigure
doesn't succeed. With or without ip_masq_raudio.

> Of course, the masq module is only to handle udp - if real goes to tcp it
> doesn't need it, so I suspect what Xavier's seeing is it working via tcp -
> but perhaps some servers today refuse to do anything but udp connections?

I confirm it uses TCP for streaming (I just looked with ethereal). The
problem is that when insmoding ip_masq_raudio on the firewall,
realplayer just hangs when buffering - if the server only supported UDP,
I suspect it would negociate TCP or something like that.

Xav


