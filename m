Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313734AbSDPQD5>; Tue, 16 Apr 2002 12:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313737AbSDPQDW>; Tue, 16 Apr 2002 12:03:22 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:59284 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S313739AbSDPQDI>; Tue, 16 Apr 2002 12:03:08 -0400
Message-ID: <3CBC4D5B.C7EF2C8C@nortelnetworks.com>
Date: Tue, 16 Apr 2002 12:12:11 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mark Mielke <mark@mark.mielke.cc>,
        Terje Eggestad <terje.eggestad@scali.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <l_girdwood@bitwise.co.uk>,
        BALBIR SINGH <balbir.singh@wipro.com>,
        William Olaf Fraczyk <olaf@navi.pl>,
        Lee Irwin III <wli@holomorphy.com>
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <Pine.LNX.4.44L.0204161231440.16531-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Tue, 16 Apr 2002, Mark Mielke wrote:
> 
> > Increasing the HZ can only improve responsiveness, however, there is a
> > cost (mentioned by others). The cost is that the scheduler is executed
> > more often per second. If the scheduler does the same amount of work
> > per tick, but there are more ticks per second, the scheduler does more
> > work overall, and the CPU is free for use by the processes less.
> 
> Why are you discussing Linux 1.2 ?
> 
> Linux is not running the scheduler each cpu tick and hasn't
> done this for years.

Very true.  However it does run the timer/clock code every tick, which is still
additional overhead when the tick time is reduced.

The basic idea (increased overhead at higher HZ) is sound, the details are not.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
