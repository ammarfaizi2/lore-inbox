Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbTDRH2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 03:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTDRH2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 03:28:53 -0400
Received: from granite.he.net ([216.218.226.66]:21764 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262911AbTDRH2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 03:28:52 -0400
Date: Fri, 18 Apr 2003 00:37:54 -0700
From: Greg KH <greg@kroah.com>
To: John Bradford <john@grabjohn.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Patrick Mochel <mochel@osdl.org>,
       Grover Andrew <andrew.grover@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
Message-ID: <20030418073754.GA2753@kroah.com>
References: <20030417150926.GA25402@gtf.org> <200304171547.h3HFljoK000140@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304171547.h3HFljoK000140@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 04:47:45PM +0100, John Bradford wrote:
> > > > The video BIOS on a card often contains information that is found
> > > > -nowhere- else.  Not in the chip docs.  Not in a device driver.
> > > > Such information can and does vary from board-to-board, such as RAM
> > > > timings, while the chip remains unchanged.
> > > 
> > > Incidently, what happens if we:
> > > 
> > > * Suspend
> > > * Swap VGA card with another one
> > > * Restore
> > 
> > When it breaks, you get to keep both pieces.
> > 
> > That's a "Don't Do That" issue for any hardware between suspend
> > and resume.
> 
> Hmm, well what about with a PCI hotswap capable board - presumably
> then we could have the situation where a new VGA card appears that we
> _have_ to POST?

PCI Hotplug does not support video cards for just this reason.

greg k-h
