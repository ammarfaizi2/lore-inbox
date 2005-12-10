Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbVLJKfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbVLJKfr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 05:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVLJKfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 05:35:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40716 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965125AbVLJKfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 05:35:46 -0500
Date: Sat, 10 Dec 2005 10:35:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jason Dravet <dravet@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Message-ID: <20051210103538.GB16104@flint.arm.linux.org.uk>
Mail-Followup-To: Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Jason Dravet <dravet@hotmail.com>, linux-kernel@vger.kernel.org
References: <BAY103-F33F72FF201DD9A0728D2EBDF450@phx.gbl> <200512091254.44770.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512091254.44770.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 12:54:44PM -0700, Bjorn Helgaas wrote:
> On Friday 09 December 2005 7:37 am, Jason Dravet wrote:
> > The question I have 
> > is with all of this plug and play stuff in our PCs shouldn't it be possible 
> > to get the correct number of ports, ask the bios or the pci bus or 
> > something?
> 
> Yes.  ACPI (or even PNPBIOS) should tell us about all the "legacy"
> ports, and PCI or other bus enumeration should tell us about all the
> rest.

Unless I stick a serial card into an industrial PC.  And yes, ISA
serial cards are still sold:

http://www.amplicon.co.uk/dr-prod3.cfm/groupId/10740/secid/10177.htm

ISA serial cards will not show up in ACPI, PNPBIOS or any other bus
enumeration scheme.  The only way to use them is via setserial.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
