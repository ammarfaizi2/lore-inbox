Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313677AbSDPNnO>; Tue, 16 Apr 2002 09:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313678AbSDPNnN>; Tue, 16 Apr 2002 09:43:13 -0400
Received: from mark.mielke.cc ([216.209.85.42]:26122 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S313677AbSDPNnM>;
	Tue, 16 Apr 2002 09:43:12 -0400
Date: Tue, 16 Apr 2002 09:38:24 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <l_girdwood@bitwise.co.uk>,
        BALBIR SINGH <balbir.singh@wipro.com>,
        William Olaf Fraczyk <olaf@navi.pl>,
        Lee Irwin III <wli@holomorphy.com>
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020416093824.A4025@mark.mielke.cc>
In-Reply-To: <AAEGIMDAKGCBHLBAACGBEEONCEAA.balbir.singh@wipro.com> <1018952961.31914.446.camel@swordfish> <20020416100148.GA17560@venus.local.navi.pl> <1018964120.13527.37.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 03:35:19PM +0200, Terje Eggestad wrote:
> I seem to recall from theory that the 100HZ is human dependent. Any
> higher and you would begin to notice delays from you input until
> whatever program you're talking to responds. 

I suspect by "higher" you mean "each tick takes up more of a second".

As in, if the HZ is *less* than 100HZ, you would notice delays when
typing, or similar.

Increasing the HZ can only improve responsiveness, however, there is a
cost (mentioned by others). The cost is that the scheduler is executed
more often per second. If the scheduler does the same amount of work
per tick, but there are more ticks per second, the scheduler does more
work overall, and the CPU is free for use by the processes less.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

