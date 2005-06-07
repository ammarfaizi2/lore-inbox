Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVFGDeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVFGDeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 23:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVFGDeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 23:34:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:61583 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261568AbVFGDeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 23:34:17 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@novell.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       Karsten Keil <kkeil@suse.de>
In-Reply-To: <20050607025710.GD3289@neo.rr.com>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <1118110545.6850.31.camel@gaston>  <20050607025710.GD3289@neo.rr.com>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 13:32:03 +1000
Message-Id: <1118115123.6850.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It should probably test for message state, it's not worth doing
> > pci_set_power_state(D3) if PMSG_FREEZE is passed... (just slows down
> > suspend to disk)
> 
> Yeah, I added pci_choose_state in my last email.  This will at least help
> avoid powering off.  Still, I agree this needs to be handled specifically.
> Currently, I don't think many drivers support PMSG_FREEZE.

Nope, but I've been improving swsusp support on macs lately and have
already a bunch of driver fixes waiting.

Now I need to get Pavel, Patrick and I to agree about the PM toplevel
core changes before I can send all that stuff to Andrew :)

Ben.


