Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267362AbTAMNkk>; Mon, 13 Jan 2003 08:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267748AbTAMNkk>; Mon, 13 Jan 2003 08:40:40 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8581 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267362AbTAMNkj>; Mon, 13 Jan 2003 08:40:39 -0500
Date: Mon, 13 Jan 2003 08:51:06 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Schwartz <davids@webmaster.com>
cc: mark@mark.mielke.cc, Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Nvidia and its choice to read the GPL "differently"
In-Reply-To: <20030112041934.AAA18620@shell.webmaster.com@whenever>
Message-ID: <Pine.LNX.3.95.1030113083054.20512A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2003, David Schwartz wrote:

[SNIPPED...]
> 
> 	A cheap hammer can drive in more nails than a top of the line 
> screwdriver.
> 
> 	DS

I like that! Reading this' month's "Computer", I noted that VxWorks
was reported to be used in the busses of satellites, i.e., manages
the IIC bus. That sounds like a good place for it. Unfortunately,
the hype is that it "runs all the satellites and is the operating
system of choice for satellites in high-radiation environments..."

VxWorks looks like this:

       void interrupt_stuff() {
           do_it();
       }

	main() {
            setup_stuff();
            for(;;) {
              funct0();
              funct1();
              funct2();
              functn();
            }
        }

    It's a big loop. Now, this might be okay for something that runs
the same events over and over again, an elevator controller, or the
"smarts" behind some protocol manager. But it would really suck if
funct0() ended up taking 1 second and functn() needs service in one 
millisecond. So, it's up to the function designer to make certain
that no function or, in some cases all functions combined, takes
more than the required latency specification to execute.

At some point, as complexity increases, you need to preempt. Preemption
takes some worse-case time. It's at that point that a system designer
will (should) throw out VxWorks and use some variation of Linux.

As system complexity continues to increase, eventually it becomes
best (currently, if it doesn't get screwed up) to use unmodified
Linux because it is optimized for "desktop" operation, meaning
it is optimized for systems of unknown complexity.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


