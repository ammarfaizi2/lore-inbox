Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272164AbRHVXyy>; Wed, 22 Aug 2001 19:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272165AbRHVXyo>; Wed, 22 Aug 2001 19:54:44 -0400
Received: from 10cust182.starstream.net ([63.205.212.182]:46545 "HELO
	10cust182.starstream.net") by vger.kernel.org with SMTP
	id <S272164AbRHVXyc>; Wed, 22 Aug 2001 19:54:32 -0400
Date: Wed, 22 Aug 2001 16:54:45 -0700
From: Ted Deppner <ted@psyber.com>
To: Travis Shirk <travis@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Locking Up
Message-ID: <20010822165444.A25085@dondra.ofc.psyber.com>
Reply-To: Ted Deppner <ted@psyber.com>
In-Reply-To: <Pine.LNX.4.33.0108220938390.1152-100000@puddy.travisshirk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108220938390.1152-100000@puddy.travisshirk.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2001 at 09:46:14AM -0600, Travis Shirk wrote:
> Ever since I upgraded to the 2.4.x (currently running 2.4.8)
> kernels, my machine has been locking up every other day
> or so.  Does anyone have any hints/tips for figuring out
> what is going on.

As another data point, I've had similar problems with one machine (the
heaviest utilized), but none others.  I'm running about 20 2.4.x machines,
in various uses (I work for an ISP).

Kernels 2.4.6 through 2.4.7, and even a 2.4.7-ac8 I tried for good
measure.

The one running on a Dell PowerEdge 2450, dual P3-750s, 512mb ram, Mylex
ExcelRaid 2000, Intel EEPRO100, running a qmail setup transiting 20 to 40k
messages per day regularly locks up every 3 to 8 days.  No dmesg, no error
logs, no oops, nothing on the console.  

The death spiral didn't seem triggered by any particular thing, and
logged in ssh terminals were the still slightly usable for 2 to 5 commands
but then they'd stop working.

2.4.8 hasn't had any problems so far in 5 days, but I'm not holding my
breath too tightly.

The ONLY similarity in the death throws has been what looks like physical
cable or network card interrupt problems.  The packets in my ssh session
seem to block until I hit enter 5 to 10 times, then I get a burst of
traffic.  I've been able to do some simple commands in this situation, but
nothing complex.

ifconfig eth0 has shown millions of various errors (carrier, collisions),
and hundreds of thousands of them between typing the command in twice.
The Cisco 6000 series switch on the other side of the cable shows no such
errors.

-- 
Ted Deppner
http://www.psyber.com/~ted/
