Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVCBWto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVCBWto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVCBWrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:47:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:45775 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262501AbVCBWnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:43:37 -0500
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-os@analogic.com
Cc: Linas Vepstas <linas@austin.ibm.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <Pine.LNX.4.61.0503021258260.6043@chaos.analogic.com>
References: <422428EC.3090905@jp.fujitsu.com> <42249A44.4020507@pobox.com>
	 <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
	 <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk>
	 <422524B1.10405@jp.fujitsu.com> <20050302174438.GH1220@austin.ibm.com>
	 <Pine.LNX.4.61.0503021258260.6043@chaos.analogic.com>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 09:40:51 +1100
Message-Id: <1109803251.5611.106.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-02 at 13:03 -0500, linux-os wrote:

> >   event->dev = dev;
> >   event->reset_state = rets[0];
> >   event->time_unavail = rets[2];
> >
> >   /* We may be called in an interrupt context */
> >   spin_lock_irqsave(&eeh_eventlist_lock, flags);
>      ^^^^^^^^^^^^^^^^^^
> >   list_add(&event->list, &eeh_eventlist);
> >   spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
>      ^^^^^^^^^^^^^^^^^^^^^
> 
> I don't think this is SMP safe from interrupt-context.
> You need the lock when you are building the event-list,
> not just when you queue it.

Go buy a clue, they are cheap these days.

Ben.


