Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131742AbRDWUok>; Mon, 23 Apr 2001 16:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131806AbRDWUob>; Mon, 23 Apr 2001 16:44:31 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:40789 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131742AbRDWUo1>; Mon, 23 Apr 2001 16:44:27 -0400
Message-ID: <3AE49402.BB093022@mvista.com>
Date: Mon, 23 Apr 2001 13:43:46 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert H. de Vries" <rhdv@rhdv.cistron.nl>,
        high-res-timers-discourse@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: high-res-timers start code.
In-Reply-To: <3AE45D01.F7B91E73@mvista.com> <01042319085701.01113@calvin> <3AE46A37.A0AF78BC@mvista.com> <01042320013203.01113@calvin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert H. de Vries" wrote:
> 
> On Monday 23 April 2001 19:45, you wrote:
> 
> > By the way, is the user land stuff the same for all "arch"s?
> 
> Not if you plan to handle the CPU cycle counter in user space. That is at
> least what I would propose.

Just got interesting, lets let the world look in.

What did you have in mind here?  I suspect that on some archs the cycle
counter is not available to user code.  I know that on parisc it is
optionally available (kernel can set a bit to make it available), but by
it self it is only good for intervals.  You need to peg some value to a
CLOCK to use it to get timeofday, for instance.

On the other hand, if there is an area of memory that both users and
system can read but only system can write, one might put the soft clock
there.  This would allow gettimeofday (with the cycle counter) to work
without a system call.  To the best of my knowledge the system does not
have such an area as yet.

comments?

George

> System call stuff, yes. There may be gotcha's in the area of 32/64
> interfaces. Almost all 64 bit archs also support 32 bit interfaces (check out
> the stuff in my patch regarding the SPARC, kindly donated by Jakub Jelinek).
> 
>         Robert
> 
> --
> Robert de Vries
> rhdv@rhdv.cistron.nl
