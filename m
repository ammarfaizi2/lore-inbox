Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262977AbVFWUjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbVFWUjb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbVFWUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:39:23 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:38821 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262977AbVFWUij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 16:38:39 -0400
Message-ID: <42BB1DBD.5060808@comcast.net>
Date: Thu, 23 Jun 2005 16:38:21 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Roberto Oppedisano <roppedisano.oppedisano@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx> <42BAEEB3.6080309@gmail.com> <200506231200.43671.bjorn.helgaas@hp.com>
In-Reply-To: <200506231200.43671.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note: this is not with 8139cp, but with 8139too, particularly 8139b

in 2.6.12, 2.6.12-mm1 and 2.6.12-RT-V0.7.49-01
With preempt enabled/disabled/rt/voluntary...
With mmio and pio in 8139too , with old rx reset and combinations of 
enabled and disabled

Even changed ethernet cables ... nothing stopped my Tx problems.
This is all occurring on a box that until yesterday, had an uptime of 
over 410 days on 2.6.0-mm1, so it's not the hardware, also, reverting to 
that kernel remedied the problem.

Here is a snip from dmesg

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timeout, status 0c 0055 c07f media 00.
eth0: Tx queue start entry 78  dirty entry 74.
eth0:  Tx descriptor 0 is 0008a03c.
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c. (queue head)
eth0:  Tx descriptor 3 is 0008a03c.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

I'm not sure if this is exactly related to the thread, but it seemed too 
much of a coincidence to think that it's not. 

The symptoms of the problem is short bursts of traffic with 30 second or 
so pauses of absolutely no response, repeating. The higher the bandwidth 
the worse the situation, but it occurs regardless. 

No other errors are reported or seen on the box except this Tx problem.  
I'm tempted to go ahead and try 2.6.11, but haven't yet.

