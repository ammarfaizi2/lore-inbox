Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264491AbTHaBFs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 21:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTHaBFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 21:05:48 -0400
Received: from mail0-96.ewetel.de ([212.6.122.96]:47080 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S264491AbTHaBFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 21:05:47 -0400
Date: Sun, 31 Aug 2003 03:05:37 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
In-Reply-To: <20030830230701.GA25845@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Aug 2003, Larry McVoy wrote:

>> All you have to do is drop the incoming packets if they exceed
>> a certain bandwidth. 
> If you think we haven't done that, think again.

> We're at the wrong end of the pipe to do that, I'm pretty sure that what 
> you are describing simply won't work. 

In a way, you're on the right end of the pipe because the system
that does your traffic shaping is part of the general network, viewed
from the machines behind the shaper.

Dropping the packets means that the sending side, at least if we're
talking TCP, will throttle its sending rate. But, depending on the
distance in hops to the sender, it may take up to a few seconds for
this to kick in. So I guess that's why it doesn't work for your
VoIP case - the senders don't notice fast enough that they should
slow down.

When my ISDN line is saturated with downloads from the rest of the
people here and data starts to come in for MY machine, it takes about
5 seconds until I get my bandwidth. Too slow for VoIP.

Traffic shaping on the side of your ISP will probably help since
they have a bigger incoming pipe. If they hadn't, they'd have the
same problem, though.

-- 
Ciao,
Pascal

