Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132326AbRDOVBf>; Sun, 15 Apr 2001 17:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbRDOVBZ>; Sun, 15 Apr 2001 17:01:25 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:9485 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S132326AbRDOVBR>; Sun, 15 Apr 2001 17:01:17 -0400
Date: Sun, 15 Apr 2001 23:01:08 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: Re: KERNEL: assertion (tp->lost_out == 0) failed at tcp_input.c(1202):tcp_remove_reno_sacks
Message-ID: <20010415230107.A28340@ping.be>
In-Reply-To: <20010414164254.A13247@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <20010414164254.A13247@ping.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2001 at 04:42:54PM +0200, Kurt Roeckx wrote:
> While running 2.4.3, I saw the following message a few times:
> 
> KERNEL: assertion (tp->lost_out == 0) failed at
> tcp_input.c(1202):tcp_remove_reno_sacks

Nobody seems to be intrested in fixing this bug?

Anyway, I was looking at some statistics of the box, which I
think might be related to this problem.

netstat -s shows this under TCP:

Tcp:
    11681 active connections openings
    0 passive connection openings
    84689 failed connection attempts
    0 connection resets received
    94 connections established
    10963047 segments received
    11476087 segments send out
    392891 segments retransmited
    772 bad segments received.
    24083 resets sent

It seems it has to retransmit 3.4% of the TCP segments, which is
rather high.

The box is just up for 10 days, this means it has to retransmit
about .45 segments / second, and the rate seems to be going up.

I hope this helps.

If there is anything else I can do, please ask.


Kurt

