Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVLJOZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVLJOZA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 09:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVLJOZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 09:25:00 -0500
Received: from bay103-f40.bay103.hotmail.com ([65.54.174.50]:38966 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932362AbVLJOY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 09:24:59 -0500
Message-ID: <BAY103-F409E732E88BC156791C026DF440@phx.gbl>
X-Originating-IP: [68.77.33.226]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <20051210103538.GB16104@flint.arm.linux.org.uk>
From: "Jason Dravet" <dravet@hotmail.com>
To: rmk+lkml@arm.linux.org.uk, bjorn.helgaas@hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Date: Sat, 10 Dec 2005 08:24:59 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 10 Dec 2005 14:24:59.0612 (UTC) FILETIME=[806711C0:01C5FD95]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Russell King <rmk+lkml@arm.linux.org.uk>
>To: Bjorn Helgaas <bjorn.helgaas@hp.com>
>CC: Jason Dravet <dravet@hotmail.com>, linux-kernel@vger.kernel.org
>Subject: Re: wrong number of serial port detected
>Date: Sat, 10 Dec 2005 10:35:38 +0000
>
>On Fri, Dec 09, 2005 at 12:54:44PM -0700, Bjorn Helgaas wrote:
> > On Friday 09 December 2005 7:37 am, Jason Dravet wrote:
> > > The question I have
> > > is with all of this plug and play stuff in our PCs shouldn't it be 
>possible
> > > to get the correct number of ports, ask the bios or the pci bus or
> > > something?
> >
> > Yes.  ACPI (or even PNPBIOS) should tell us about all the "legacy"
> > ports, and PCI or other bus enumeration should tell us about all the
> > rest.
>
>Unless I stick a serial card into an industrial PC.  And yes, ISA
>serial cards are still sold:
>
>http://www.amplicon.co.uk/dr-prod3.cfm/groupId/10740/secid/10177.htm
>
>ISA serial cards will not show up in ACPI, PNPBIOS or any other bus
>enumeration scheme.  The only way to use them is via setserial.
>
>--
>Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core

How is this for an idea?  The serial driver enumerates ACPI, PNPBIOS, or 
whaterver it needs for the onboard serial ports.  If you have a PCI based 
serial card it would show up in the emuneration of the PCI bus, right?  For 
the case of ISA serial cards couldn't they have an option in modprobe.conf 
to tell the kernel about the ISA serial card and the proper number of serial 
ports on the card itself?

Thanks,
Jason


