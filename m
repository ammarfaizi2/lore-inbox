Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTGHPFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263610AbTGHPFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:05:42 -0400
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:6922 "EHLO
	light-brigade.mit.edu") by vger.kernel.org with ESMTP
	id S263394AbTGHPFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:05:40 -0400
Date: Tue, 8 Jul 2003 11:20:16 -0400
From: Gerald Britton <gbritton@alum.mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: emperor@EmperorLinux.com, LKML <linux-kernel@vger.kernel.org>,
       EmperorLinux Research <research@EmperorLinux.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Linux and IBM : "unauthorized" mini-PCI : Cisco mpi350 _way_ sub-optimal
Message-ID: <20030708112016.A10882@light-brigade.mit.edu>
References: <1054658974.2382.4279.camel@tori> <20030610233519.GA2054@think> <200307071412.00625.durey@EmperorLinux.com> <1057672948.4358.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1057672948.4358.20.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Jul 08, 2003 at 03:02:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 03:02:31PM +0100, Alan Cox wrote:
> On Llu, 2003-07-07 at 19:12, Lincoln D. Durey wrote:
> > Ted,
> > 
> > This is an amazingly sub-optimal solution, and will make running Linux on the 
> > T40/X31 prohibitively difficult for most linux users.  Do you want everyone 
> > to use Linux?  Then tell IBM to let them use wifi cards that are easy to use, 
> > and support standard (and open) APIs.
> 
> You don't have to buy IBM products. Dunno what local prices are like but
> over here Comaq^WHP's come in at about two per thinkpad on price and do
> work once you have all the ACPI stuff set up

Some of them have issues with PCI resource allocation though.  Their BIOSes
don't allocate resources to Cardbus bridges so insertted devices can't get
resources and last i checked, we didn't handle this fixup.  On the notebooks
I worked with it required relocating the AGP bridge and several other devices
to make all the resources work out (quick hack is to just shove new resources
into the config registers prior to the kernel's initial pci scan).

				-- Gerald

