Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbTKUTLx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 14:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTKUTLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 14:11:53 -0500
Received: from palrel10.hp.com ([156.153.255.245]:32232 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264420AbTKUTLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 14:11:51 -0500
Date: Fri, 21 Nov 2003 11:11:49 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Bill Nottingham <notting@redhat.com>, Andi Kleen <ak@muc.de>
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] All my Pcmcia cards are 'eth0'
Message-ID: <20031121191149.GA26357@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Nottingham wrote :
> 
> Andi Kleen (ak@muc.de) said: 
> > > There are some situations where you have to jump through hoops
> > > because it can't atomically swap two device names (i.e.,
> > > eth0 <-> eth1, but the code itself seems to work ok in use here...
> > 
> > Adding such swapping should not be very hard if someone is motivated.
> > Interestingly you're the first to complain about it missing...
> 
> When I looked at it, I assumed it was a limitation of the
> kernel interface, in that it only operated on one device at
> a time... or are you talking about just doing the switch in
> nameif itself with a temporary device name?

	Have you tried with nameif running from hotplug ? I'm sure
that would fix your problem, because the first device would be renamed
before the second would even be created (but you may want to test).
	That's probably a second reason why running nameif from
hotplug is the right way forward.

> Bill

	Jean
