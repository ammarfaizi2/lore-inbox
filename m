Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSFENhw>; Wed, 5 Jun 2002 09:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314485AbSFENhv>; Wed, 5 Jun 2002 09:37:51 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1540 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311749AbSFENhv>; Wed, 5 Jun 2002 09:37:51 -0400
Date: Wed, 5 Jun 2002 09:33:00 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
In-Reply-To: <1022539726.4124.2.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1020605092821.910B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 May 2002, Alan Cox wrote:

> On Mon, 2002-05-27 at 22:22, H. Peter Anvin wrote:
    <_snip_>
> > Well, if you can't fork a new process because that would push you into
> > overcommit, then you usually can't actually do anything useful on the
> > machine.
> 
> Thats actually easy to deal with and on my list for modes 4 and 5 (2 and
> 3 with root granted a reserved fraction)

It seems to me that selectively limiting the number of processes in a
pgroup, or selectively killing large RSS programs in a large pgroup
(non-root) would be one way to identify the processes which were either
clone/fork looping, or have children begetting children. After than
perhaps killing or restricting from the high numerical uid down. That
might tend to spare system and/or well-behaved processes.

Comment?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

