Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132564AbRDHOVb>; Sun, 8 Apr 2001 10:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132565AbRDHOVW>; Sun, 8 Apr 2001 10:21:22 -0400
Received: from beton.btnet.cz ([62.80.85.76]:1540 "HELO beton.btnet.cz")
	by vger.kernel.org with SMTP id <S132564AbRDHOVM>;
	Sun, 8 Apr 2001 10:21:12 -0400
Date: Sun, 8 Apr 2001 16:19:33 +0200
From: clock@beton.btnet.cz
To: linux-kernel@vger.kernel.org
Subject: TCP stack misbehaviour?
Message-ID: <20010408161933.A223@beton.btnet.cz>
Reply-To: clock@ghost.btnet.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The TCP stack in the linux kernel behaves this way:

I have got a FULL-DUPLEX 28.800kbps channel with BER <= 1*10-9
a) I start a long TCP connection in one direction
b) After 5 minutes I start another connection in the opposite direction

The second connection rusn for about half a minute, then converges to 0
throughtput. After several minutes, another 30 seconds of transmission ocuur.
The data path in the direction that should be used for this connection is
empty, except for occasional ACKs. The utilization of the channel is about 4%.

I would expect that both channels would be used for at least 95%. Instead, only
one is used.

Is this a bug of Linux kernel TCP stack, or a bug in the algorithm presented
in the appropriate RFC?

Isn't UDP more suitable for data transfers?

-- 
Karel Kulhavy                     http://atrey.karlin.mff.cuni.cz/~clock
