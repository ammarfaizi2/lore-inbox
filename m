Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTKYAtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbTKYAtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:49:45 -0500
Received: from palrel10.hp.com ([156.153.255.245]:27862 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261782AbTKYAtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:49:43 -0500
Date: Mon, 24 Nov 2003 16:49:42 -0800
To: David Hinds <dhinds@sonic.net>
Cc: linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
Message-ID: <20031125004942.GA3002@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20031124235727.GA2467@bougret.hpl.hp.com> <20031124162628.A32213@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031124162628.A32213@sonic.net>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 04:26:28PM -0800, David Hinds wrote:
> On Mon, Nov 24, 2003 at 03:57:27PM -0800, Jean Tourrilhes wrote:
> > 	Hi,
> > 
> > 	I have a new Ricoh PCI-Carbus bridge and the kernel
> > 2.6.0-test9 doesn't seem to configure it properly (see below).
> > 	With the old Pcmcia package, the i82365 module had a bunch of
> > module options to change various irq stuff (see Pcmcia Howto 5.2). A
> > quick look in yenta_socket failed to show any module options, which
> > seems odd.
> > 	What is the correct way to workaround this stuff ?
> 
> Does this system do ACPI?

	This is a box from 1998, and the manual doesn't mention
anything about ACPI. I highly doubt it would support ACPI, but how do
I check that ?

>  Do you have that configured in your kernel?

	Could try.

> The yenta module doesn't have any options for overriding interrupt
> settings.  It relies on the PCI subsystem has to do the right thing.

	Which in this case failed. I think all I need is to configure
cp_pci_irq to the proper value.

> -- Dave

	Jean
