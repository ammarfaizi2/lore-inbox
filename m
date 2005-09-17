Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVIQEMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVIQEMY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 00:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVIQEMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 00:12:24 -0400
Received: from mx1.rowland.org ([192.131.102.7]:26639 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750865AbVIQEMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 00:12:23 -0400
Date: Sat, 17 Sep 2005 00:12:19 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pete Zaitcev <zaitcev@redhat.com>, Greg KH <greg@kroah.com>,
       <dtor_core@ameritech.net>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <caphrim007@gmail.com>,
       <david-b@pacbell.net>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: Lost keyboard on Inspiron 8200 at 2.6.13
In-Reply-To: <1126914891.17038.30.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0509170005450.689-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Sep 2005, Alan Cox wrote:

> On Gwe, 2005-09-16 at 15:24 -0700, Pete Zaitcev wrote:
> > I see why you would want to merge them, but is it worth the trouble?
> > They are not identical. For one thing, early handoff installs its own
> > fake interrupt handlers (Alan Cox insisted on it in the RHEL
> > implementation).

Where does early handoff install a fake interrupt handler for UHCI?  I 
don't see any in drivers/pci/quirks.c.

> You need them because an IRQ could be pending on the channel at the
> point you switch over or triggered on the switch and a few people saw
> this behaviour.

Yes, that would be needed if you have edge-triggered interrupts.  But 
isn't PCI supposed to be level-triggered?

> I'd like to see it shared but that means handoff belongs in the input
> layer code and the USB layer needs to call into it if appropriate.

Why does it mean that?  And why the input layer as opposed to the PCI 
layer, where it is now?

Alan Stern

