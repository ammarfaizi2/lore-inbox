Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTIALow (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 07:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbTIALow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 07:44:52 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:10182 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262257AbTIALov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 07:44:51 -0400
Subject: Re: bandwidth for bkbits.net (good news)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030831232224.GF24409@dualathlon.random>
References: <20030831154450.GV24409@dualathlon.random>
	 <20030831162243.GC18767@work.bitmover.com>
	 <20030831163350.GY24409@dualathlon.random>
	 <20030831164802.GA12752@work.bitmover.com>
	 <20030831170633.GA24409@dualathlon.random>
	 <20030831211855.GB12752@work.bitmover.com>
	 <20030831224938.GC24409@dualathlon.random>
	 <1062370358.12058.8.camel@dhcp23.swansea.linux.org.uk>
	 <20030831230219.GD24409@dualathlon.random>
	 <20030831230728.GA4918@work.bitmover.com>
	 <20030831232224.GF24409@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062416635.13372.17.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Mon, 01 Sep 2003 12:43:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-01 at 00:22, Andrea Arcangeli wrote:
> the only difference I believe is that the connections are originated by
> my end, but that only changes the syn packet that normally accounts for
> a non significant amount of the bandwidth. And while this is located in
> a house, this isn't what I would call an home user usage.

Each ACK that has caused previous delays generally opens up a 64K window
so you get bursts of data incoming. A sequence of acks can cause the
incoming pipe to fill enough to screw up voip very easily.

Window bending stuff does help and certainly the packeteer boxes use it
to good effect. I've never tried that on Linux but even then Im dubious
that just cutting the routes down to an 8K window would help

