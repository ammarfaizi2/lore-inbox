Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbUBZJ7j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 04:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbUBZJ7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 04:59:39 -0500
Received: from aun.it.uu.se ([130.238.12.36]:51430 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262753AbUBZJ7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 04:59:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16445.50041.813575.425095@alkaid.it.uu.se>
Date: Thu, 26 Feb 2004 10:59:21 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ross@datscreative.com.au
Cc: a.verweij@student.tudelft.nl, Arjen Verweij <A.Verweij2@ewi.tudelft.nl>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       <linux-kernel@vger.kernel.org>, Jamie Lokier <jamie@shareable.org>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>, Daniel Drake <dan@reactivated.net>
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround instead of apic ack delay.
In-Reply-To: <200402261013.38536.ross@datscreative.com.au>
References: <Pine.GHP.4.44.0402252234370.16736-100000@elektron.its.tudelft.nl>
	<200402261013.38536.ross@datscreative.com.au>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson writes:
 > > Something else that strikes me as odd, is that 2.6.3-mm like I built it,
 > > immediately locks up solid if you omit apic_tack=2, but 2.4 with acpi and
 > > apic enabled, without Ross' patches would not react this vigorously.
 > 
 > I have found it to be the 1000Hz timer ticks by default in 2.6 whereas in
 > 2.4 you only have 100Hz ticks. By default you can have 10 times the quantity of
 > disconnects and reconnects per second with 2.6 as compared with 2.4. 
 > The -CPU? -Chipset? -memory? -power supply? -track layout? -bios timings? etc.
 > combo the way it is set up on a lot of Nforce2 boards cannot hack it.

One option is to reduce HZ, by e.g. applying
http://www.csd.uu.se/~mikpe/linux/patches/2.6/patch-config-hz-2.6.3
and selecting CONFIG_HZ_100.

I did this originally to prevent clock slowdown on a 486 during
heavy disk I/O, but at least one person reported that it helped
his PIII as well: that could very well have been a chipset or
#SMM BIOS issue.
