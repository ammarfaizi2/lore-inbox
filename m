Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161206AbWBTXp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161206AbWBTXp1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 18:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWBTXp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 18:45:26 -0500
Received: from iabervon.org ([66.92.72.58]:33033 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964853AbWBTXp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 18:45:26 -0500
Date: Mon, 20 Feb 2006 18:45:56 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Missing file
In-Reply-To: <Pine.LNX.4.61.0602201333360.5440@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0602201810260.6773@iabervon.org>
References: <Pine.LNX.4.61.0602201201200.4888@chaos.analogic.com>
 <1140456505.2979.66.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0602201333360.5440@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2006, linux-os (Dick Johnson) wrote:

> On Mon, 20 Feb 2006, Arjan van de Ven wrote:
> 
> > On Mon, 2006-02-20 at 12:08 -0500, linux-os (Dick Johnson) wrote:
> >>
> >> Hello,
> >> Linux-2.6.15.4 fails to contain the file:
> >>  	/usr/src/linux-2.6.15.4/drivers/pci/devlist.h
> >>
> >> This contains product NAMES used to identity various PCI
> >> devices when they are installed. What replaces this file?
> >>
> >> The file existed up until at least linux-2.6.13.4 and
> >> should not have been removed just because some audit
> >> may have determined that it's "not in use." It is in
> >> use by vendors which need to convert "Computerese" to
> >> "Customer readable" stuff.
> >
> >
> > actually an entirely different file is used for that;
> > /usr/share/hwdata/pci.ids
> >
> > which comes from the pci id repo on sourceforge (same as the file you
> > want to look at). Distributions at least tend to update pci.ids file
> > more frequent than the kernel updated devlist.h...
> 
> Thanks. Changes like that make tons of work! Great, there will
> always be something for us to do. Now all I have to do is
> modify a tool to be Linux version-specific so I get the right
> ASCII put into driver(s). The drivers don't run in anything
> that has a shell or anything like that. They need to "know"
> the vendor-name of some interface chips so the name(s) were
> compiled in, based upon OS headers.

If you actually want a "devlist.h" file, 2.6.11 has a program 
gen-devlist.c that generates it (and "classlist.h") from pci.ids. The 
kernel source hasn't come with a devlist.h file since before the dawn of 
time (i.e., the beginning of the git repository). The only recent change 
is not including a pci.ids or generating a devlist.h from it.

	-Daniel
*This .sig left intentionally blank*
