Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVDYUQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVDYUQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVDYUQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:16:34 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:30848 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S262779AbVDYUOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:14:14 -0400
Date: Mon, 25 Apr 2005 16:14:13 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Alexander Nyberg <alexn@dsv.su.se>
cc: Greg KH <greg@kroah.com>, Amit Gud <gud@eth.net>,
       <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <akpm@osdl.org>, <jgarzik@pobox.com>, <cramerj@intel.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
In-Reply-To: <1114458325.983.17.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, Alexander Nyberg wrote:

> Not sure what you mean by "make kexec work nicer" but if it is because
> some devices don't work after a kexec I have some objections.

That was indeed the reason, at least in my case.  The newly-rebooted
kernel doesn't work too well when there are active devices, with no driver
loaded, doing DMA and issuing IRQs because they were never shut down.

> What about the kexec-on-panic?
> 
> In the end at least every storage device should work after a
> kexec-on-panic or else there might be cases where we cannot get dumps of
> what happened. My guess is that having access to the network might come
> in handy after a kexec-on-panic as well.
> 
> So if this patch is because some devices don't work across kexec I don't
> think this is a good idea because the same devices won't work after a
> kexec-on-panic.

Do I understand your argument correctly?  You seem to be saying that 
because this new facility sometimes won't work (the kexec-on-panic case) 
it shouldn't be added at all.  What about all the other times when it will 
work?

Alan Stern

