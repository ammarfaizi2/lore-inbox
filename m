Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266917AbUHDA5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266917AbUHDA5f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266921AbUHDA5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:57:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14557 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266917AbUHDA5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:57:15 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Exposing ROM's though sysfs
Date: Tue, 3 Aug 2004 17:55:56 -0700
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       Jon Smirl <jonsmirl@yahoo.com>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
References: <1091207136.2762.181.camel@rohan.arnor.net> <1091226981.5066.15.camel@localhost.localdomain> <1091569261.1862.18.camel@gaston>
In-Reply-To: <1091569261.1862.18.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408031755.56833.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 3, 2004 2:41 pm, Benjamin Herrenschmidt wrote:
> > emu86 is rather buggy. It can't boot C&T BIOSes for example. qemu might
> > be a better engine for this anyway in truth.
>
> And I like the idea of chosing a solution that won't limit us to x86 hosts
> anyway ;)

Yeah, me too!

> With proper support from the "VGA arbitration driver" that Jon talked about
> earlier, that should be quite portable, the kernel driver doing the job of
> providing PIO accessors to VGA space and mmap functionality for VGA memory
> hole if it exist (can modern cards be POST'ed with an x86 BIOS on machines
> that won't let you access any VGA memory hole, that is that won't let you
> generate PCI memory cycles to low addresses that overlap RAM ? If yes, then
> pmacs would be able to soft-boot x86 cards that way).

So you can do port I/O on low addresses but not memory accesses?  For some 
cards simply throwing away reads and writes to the low memory area is 
probably ok since it'll just be doing things like printing a BIOS banner or a 
pretty logo.  But then again, I've never disassembled one so I can't be sure.  
Alan would probably know though :)

If you can't do legacy port I/O on a given bus though, I think you'd be out of 
luck wrt POSTing a card with an x86 BIOS.

Jesse
