Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161267AbVIPTAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161267AbVIPTAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161269AbVIPTAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:00:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:63949 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161267AbVIPTAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:00:41 -0400
Date: Fri, 16 Sep 2005 15:00:40 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <caphrim007@gmail.com>, David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: Lost keyboard on Inspiron 8200 at 2.6.13
In-Reply-To: <20050916184440.GA11413@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0509161455240.4433-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005, Greg KH wrote:

> On Fri, Sep 16, 2005 at 05:00:49PM +0100, Alan Cox wrote:
> > On Gwe, 2005-09-16 at 10:25 -0500, Dmitry Torokhov wrote:
> > > Interdependencies between ACPI, PNP, USB Legacy emulation and I8042 is
> > > very delicate and quite often changes in ACPI/PNP break that balance.
> > > USB legacy emulation is just evil. We need to have "usb-handoff" thing
> > > enabled by default, it fixes alot of problems.
> > 
> > I would definitely agree with this. There are very few, if any, cases
> > usb handoff doesn't work now that the Nvidia problems are fixed.
> 
> Are we sure?  Yeah, SuSE has shipped that code "enabled" for a while,
> but I'm still not comfortable making that the default.
> 
> Only if we merge the code that does the handoff, with the same code that
> does it in the usb core, would I feel more comfortable to enable this
> always.  I had a patch from David Brownell to do this, but it had some
> link errors at times, so I had to drop it :(

Merging the code would be a good thing.  As it stands right now, bad
interactions between the PCI handoff code and uhci-hcd will prevent UHCI
controllers from retaining state across a suspend-to-disk.

Alan Stern

