Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273976AbRI3S23>; Sun, 30 Sep 2001 14:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273977AbRI3S2T>; Sun, 30 Sep 2001 14:28:19 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:6389 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S273976AbRI3S2B>; Sun, 30 Sep 2001 14:28:01 -0400
Message-ID: <3BB76492.76D014BE@kegel.com>
Date: Sun, 30 Sep 2001 11:29:38 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nimesh vakharia <nvakhari@clio.rad.sunysb.edu>
Subject: Re: [PATCH] tcp_v4_get_port() and ephemeral ports
In-Reply-To: <Pine.LNX.4.40.0109301114390.7223-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Sun, 30 Sep 2001, Dan Kegel wrote:
> 
> > I'm doing ftp server benchmarking, doing lots of connect()'s.
> > Since ports aren't supposed to be reused for 2MSL (theoretically 120 seconds),
> > the absolute limit on connections per second is 64K/120 = 500.
> > This actually could pose a problem for me.  (Yeah, 2MSL is
> > set to 30 seconds in linux, so the problem isn't as severe
> > as the standard says, but it's still a problem.)
> 
> net.ipv4.tcp_tw_recycle=1
> net.ipv4.tcp_fin_timeout=8
> 
> ONLY FOR TESTING !! :)

OK, thanks, that will help!

I'm still interested in whether that patch I posted makes sense.
bind() *should* work that way, darn it :-)

- Dan
