Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTKTKVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 05:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTKTKVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 05:21:20 -0500
Received: from aun.it.uu.se ([130.238.12.36]:57776 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261406AbTKTKVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 05:21:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16316.38292.729957.491201@alkaid.it.uu.se>
Date: Thu, 20 Nov 2003 11:21:08 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: john stultz <johnstul@us.ibm.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: high res timestamps and SMP
In-Reply-To: <1069297341.23568.130.camel@cog.beaverton.ibm.com>
References: <3FBBF148.20203@nortelnetworks.com>
	<1069297341.23568.130.camel@cog.beaverton.ibm.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz writes:
 > On Wed, 2003-11-19 at 14:40, Chris Friesen wrote:
 > > We have a requirement to have high-res timestamps available on SMP systems.
...
 > o PPC has a nice in-cpu time-base register (ppc folks, feel free to
 > smack or correct me on this) which is driven off the bus-clock and is
 > synced in hardware. 

Last time I checked, all 32-bit PowerPC chips ran that clock at 1/4
of the bus clock speed.

That may be adequate for time-of-day and I/O delays and such, but
it's worthless for timestamps or performance measurements.

It's possible to count core clocks via a performance counter, but
I don't know if they are synced between CPUs.
