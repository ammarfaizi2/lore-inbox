Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUBTHPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 02:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267691AbUBTHPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 02:15:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:56745 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267651AbUBTHPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 02:15:32 -0500
Subject: Re: [BK PATCH] USB update for 2.6.3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040219230407.063ef209.davem@redhat.com>
References: <20040220012802.GA16523@kroah.com>
	 <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
	 <1077256996.20789.1091.camel@gaston>
	 <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
	 <1077258504.20781.1121.camel@gaston>
	 <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org>
	 <1077259375.20787.1141.camel@gaston>
	 <Pine.LNX.4.58.0402192257190.1107@ppc970.osdl.org>
	 <20040219230407.063ef209.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1077261041.20787.1181.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 18:10:41 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You miss how all of this stuff is being used :-)
> 
> USB drivers do things like map DMA memory, and the generic DMA layer vectors it
> so that if the USB device is attached to a PCI host the PCI DMA mapping routines
> get used.

Hrm... so if the USB device drivers are actually doing the dma mapping
themselves, it make sense for them to pass their own struct device, no ?

Or do they have always to pass their host controller one ?

In the former case, we need that inheritance stuff. In the later case
we don't. At this point, it's pretty much a matter of policy.

Ben.


