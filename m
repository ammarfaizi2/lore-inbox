Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbUCEVNf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbUCEVNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:13:35 -0500
Received: from ida.rowland.org ([192.131.102.52]:2052 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262704AbUCEVNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:13:33 -0500
Date: Fri, 5 Mar 2004 16:13:31 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Jamie Lokier <jamie@shareable.org>
cc: walt <wa1ter@myrealbox.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [2.6.x]  USB Zip drive kills ps2 mouse.
In-Reply-To: <20040305204916.GC7254@mail.shareable.org>
Message-ID: <Pine.LNX.4.44L0.0403051609100.719-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004, Jamie Lokier wrote:

> > I've narrowed it down to the uhci_hcd module -- all the rest can
> > be compiled in or as modules, doesn't matter.
> > 
> > Just in case I was vague:  the Zip drive works great regardless --
> > it's only the ps2 mouse which is affected by this weird problem.
> > No cursor movement at all if the Zip is plugged in during boot.
> 
> I don't know if it's related, but whenever I load the uhci_hcd module
> on my laptop, or whenever I plug in a USB device while that module is
> loaded (sorry, I forget which and can't test it now) - the floppy disk
> motor and light are turned on for a couple of seconds!
> 
> Now, why would a USB event trigger the floppy disk motor?  It doesn't
> happen with 2.4, and it doesn't happen on my desktop machine which is
> OHCI+EHCI.
> 
> Perhaps the uhci_hcd driver is trampling on some ISA I/O port that it
> shouldn't be, which is causing both my floppy motor oddity and your
> mouse problem?
> 
> -- Jamie

No, the uhci-hcd driver isn't stepping on any extraneous ISA I/O ports.

Walt's problem was the result of a buggy BIOS, and turning off legacy USB 
support in the BIOS fixed it.  Maybe your problem is similar, though it's 
hard to imagine how.

I've got 3 computers with UHCI controllers.  On none of them does a USB 
event cause the floppy disk drive to do anything.

Alan Stern

