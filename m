Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbTHaC5O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 22:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbTHaC5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 22:57:14 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:38335 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262440AbTHaC5M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 22:57:12 -0400
Date: Sat, 30 Aug 2003 19:56:59 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Pascal Schmidt <der.eremit@email.de>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831025659.GA18767@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Pascal Schmidt <der.eremit@email.de>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local> <20030831013928.GN24409@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831013928.GN24409@dualathlon.random>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 03:39:28AM +0200, Andrea Arcangeli wrote:
> > Dropping the packets means that the sending side, at least if we're
> > talking TCP, will throttle its sending rate. But, depending on the
> > distance in hops to the sender, it may take up to a few seconds for
> > this to kick in. So I guess that's why it doesn't work for your
> > VoIP case - the senders don't notice fast enough that they should
> > slow down.
> 
> that's because you don't limit the bkbits.net to a fixed rate. 

We not only limited bkbits.net to a fixed rate, we limited all TCP based
traffic to a fixed rate and it still didn't work.

I'm pretty convinced we can't solve the problem at our end.  Maybe we can
but I'm voting for throwing another T1 at the problem, we'll try working
with the ISP suggested solution of trunking them and rate limiting at
their end and if that doesn't work then we'll split them and use one for
bkbits.net and other bitmover related TCP traffic and use the other one
for phones.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
