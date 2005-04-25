Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVDYUwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVDYUwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVDYUwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:52:20 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:24567 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261173AbVDYUwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:52:08 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH] PCI: Add pci shutdown ability
From: Alexander Nyberg <alexn@dsv.su.se>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Amit Gud <gud@eth.net>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Mon, 25 Apr 2005 22:52:03 +0200
Message-Id: <1114462323.983.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Not sure what you mean by "make kexec work nicer" but if it is because
> > some devices don't work after a kexec I have some objections.
> 
> That was indeed the reason, at least in my case.  The newly-rebooted
> kernel doesn't work too well when there are active devices, with no driver
> loaded, doing DMA and issuing IRQs because they were never shut down.
>
> > What about the kexec-on-panic?
> > 
> > In the end at least every storage device should work after a
> > kexec-on-panic or else there might be cases where we cannot get dumps of
> > what happened. My guess is that having access to the network might come
> > in handy after a kexec-on-panic as well.
> > 
> > So if this patch is because some devices don't work across kexec I don't
> > think this is a good idea because the same devices won't work after a
> > kexec-on-panic.
> 
> Do I understand your argument correctly?  You seem to be saying that 
> because this new facility sometimes won't work (the kexec-on-panic case) 
> it shouldn't be added at all.  What about all the other times when it will 
> work?

No, I was saying that this approach doesn't solve all problems that
exist with kexec and kexec-on-panic is a very important coming
functionality. If there is going to be prepatory work for its coming we
might as well at least try to consider all the problems that are at
hand.
Otherwise the same problems will just appear again when kexec-on-panic
starts to get used in the real world.

