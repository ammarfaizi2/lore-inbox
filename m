Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269570AbTGJSns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269569AbTGJSnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:43:47 -0400
Received: from a3hr6fay45cl.bc.hsia.telus.net ([216.232.206.119]:13075 "EHLO
	cyclops.implode.net") by vger.kernel.org with ESMTP id S269570AbTGJSne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:43:34 -0400
Date: Thu, 10 Jul 2003 11:58:13 -0700
From: John Wong <kernel@implode.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB stops working with any of 2.4.22-pre's after 2.4.21
Message-ID: <20030710185813.GA526@gambit.implode.net>
References: <20030710065801.GA351@gambit.implode.net> <20030710170217.GA12098@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030710170217.GA12098@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is a duplicate...I received an error bounce

----
ACPI isn't absolutely needed, but it comes in handy for issuing a
shutdown.
Though I suppose I can use apm to do this as well.

On a uni-processor system, isn't the ACPI tables used to setup the
IO-APIC bits to have PCI IRQ routing so that I have more than 16
interrupts?  This was another reason I had enabled ACPI.

When I do get those interrupt problems, my network still continues to
function while the USB mouse fails.  I do agree it's not USB specific.
It's more tied in to ACPI/(IO-)APIC.

When I get back home, I'll try booting it with acpi=off on pre4 and see
how it goes.

John

On Thu, Jul 10, 2003 at 10:02:17AM -0700, Greg KH wrote:
> On Wed, Jul 09, 2003 at 11:58:01PM -0700, John Wong wrote:
> > Jul  9 23:39:44 gambit kernel: eth0: Resetting the Tx ring pointer.
> > Jul  9 23:39:51 gambit kernel: usb-ohci.c: unlink URB timeout
> > Jul  9 23:39:54 gambit kernel: NETDEV WATCHDOG: eth0: transmit timed out
> 
> Hm, looks like bad things are happening with your interrupts.
> 
> Do you need acpi to run this box?  What happens if you disable it?
> 
> As it looks like networking is also in trouble, I don't think this is a
> USB specific problem for you.
> 
> Good luck,
> 
> greg k-h
> 
