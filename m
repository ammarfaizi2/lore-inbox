Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263066AbTCSOpD>; Wed, 19 Mar 2003 09:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263067AbTCSOpD>; Wed, 19 Mar 2003 09:45:03 -0500
Received: from sabre.velocet.net ([216.138.209.205]:43536 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S263066AbTCSOpB>;
	Wed, 19 Mar 2003 09:45:01 -0500
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: gsstark@mit.edu, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-ac2 Memory Leak?
References: <8765qgb6z0.fsf@stark.dyndns.tv>
	<1048030102.1521.77.camel@tux.rsn.bth.se>
In-Reply-To: <1048030102.1521.77.camel@tux.rsn.bth.se>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 19 Mar 2003 09:55:48 -0500
Message-ID: <871y139zij.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, 2003-03-19 at 00:17, Gregory Stark wrote:
> > My router box has a problem, it seems to be running out of memory. Programs
> > that worked fine earlier are now swapping like crazy. 
> > 
> > What confuses me is that if I add up all the RSS of the processes I get 5.9M,
> > a number drastically lower than the available RAM on the machine (24M) and
> > drastically lower than the amount of RAM "free" says is taken (22M).
> > 
> > It seems something in kernel space has taken a ton of memory out of play?
> > Or is my diagnosis wrong?

One thing I find suspicious is that my ISP was down yesterday morning, causing
pppd to try repeatedly to connect. It seems it attempted to connect over 3,000
times while the ISP was down. Every connection failed at the PAP
authentication stage.

Perhaps there's a memory leak in the pppoe connection initiation process?
Even so that would be about 4k per pppoe connection attempt. Hm, a page?

--
greg

