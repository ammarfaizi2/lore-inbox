Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbUCEUtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 15:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbUCEUtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 15:49:31 -0500
Received: from mail.shareable.org ([81.29.64.88]:41351 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262698AbUCEUta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 15:49:30 -0500
Date: Fri, 5 Mar 2004 20:49:16 +0000
From: Jamie Lokier <jamie@shareable.org>
To: walt <wa1ter@myrealbox.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.6.x]  USB Zip drive kills ps2 mouse.
Message-ID: <20040305204916.GC7254@mail.shareable.org>
References: <20040301122450.69a1f36e.rddunlap@osdl.org> <20040301215851.737c433d.rddunlap@osdl.org> <40452AB3.2060400@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40452AB3.2060400@myrealbox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've narrowed it down to the uhci_hcd module -- all the rest can
> be compiled in or as modules, doesn't matter.
> 
> Just in case I was vague:  the Zip drive works great regardless --
> it's only the ps2 mouse which is affected by this weird problem.
> No cursor movement at all if the Zip is plugged in during boot.

I don't know if it's related, but whenever I load the uhci_hcd module
on my laptop, or whenever I plug in a USB device while that module is
loaded (sorry, I forget which and can't test it now) - the floppy disk
motor and light are turned on for a couple of seconds!

Now, why would a USB event trigger the floppy disk motor?  It doesn't
happen with 2.4, and it doesn't happen on my desktop machine which is
OHCI+EHCI.

Perhaps the uhci_hcd driver is trampling on some ISA I/O port that it
shouldn't be, which is causing both my floppy motor oddity and your
mouse problem?

-- Jamie
