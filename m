Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbTDRHhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 03:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTDRHhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 03:37:15 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:35712 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262926AbTDRHhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 03:37:14 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304180751.h3I7pBak000432@81-2-122-30.bradfords.org.uk>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
To: greg@kroah.com (Greg KH)
Date: Fri, 18 Apr 2003 08:51:11 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), jgarzik@pobox.com (Jeff Garzik),
       alan@lxorguk.ukuu.org.uk (Alan Cox), mochel@osdl.org (Patrick Mochel),
       andrew.grover@intel.com (Grover Andrew),
       benh@kernel.crashing.org (Benjamin Herrenschmidt),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20030418073754.GA2753@kroah.com> from "Greg KH" at Apr 18, 2003 12:37:54 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > The video BIOS on a card often contains information that is found
> > > > > -nowhere- else.  Not in the chip docs.  Not in a device driver.
> > > > > Such information can and does vary from board-to-board, such as RAM
> > > > > timings, while the chip remains unchanged.
> > > > 
> > > > Incidently, what happens if we:
> > > > 
> > > > * Suspend
> > > > * Swap VGA card with another one
> > > > * Restore
> > > 
> > > When it breaks, you get to keep both pieces.
> > > 
> > > That's a "Don't Do That" issue for any hardware between suspend
> > > and resume.
> > 
> > Hmm, well what about with a PCI hotswap capable board - presumably
> > then we could have the situation where a new VGA card appears that we
> > _have_ to POST?
> 
> PCI Hotplug does not support video cards for just this reason.

Hmm, so is there no way at all we could support it?  I know it sounds
a bit pointless for a typical server or desktop machine, but it's
getting increasingly possible, practical, and attractive to use Linux
boxes more like minicomputers - dual headed VGA cards are cheap, and
USB allows you to connect practically as many keyboards and mice as
you want to.

I'm just thinking that at some point in the future, buying a new
machine could be less pratical than hot plugging in an additional VGA
card, keyboard, monitor and mouse, and editing a config file
somewhere.  With the new input layer, we are very close to this being
a reality.

John.
