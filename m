Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVCUIlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVCUIlO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 03:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVCUIlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 03:41:14 -0500
Received: from relay.rost.ru ([80.254.111.11]:23186 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S261688AbVCUIk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 03:40:58 -0500
Date: Mon, 21 Mar 2005 11:40:55 +0300
From: Andrey Panin <pazke@donpac.ru>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Jacques Goldberg <Jacques.Goldberg@cern.ch>
Subject: Re: Need break driver<-->pci-device automatic association
Message-ID: <20050321084055.GD2703@pazke>
Mail-Followup-To: Russell King <rmk+lkml@arm.linux.org.uk>,
	Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	Jacques Goldberg <Jacques.Goldberg@cern.ch>
References: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain> <20050318165124.GC14952@kroah.com> <Pine.LNX.4.58_heb2.09.0503192021431.11358@localhost.localdomain> <20050321081638.GC2703@pazke> <20050321082228.A22099@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321082228.A22099@flint.arm.linux.org.uk>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 080, 03 21, 2005 at 08:22:28AM +0000, Russell King wrote:
> On Mon, Mar 21, 2005 at 11:16:38AM +0300, Andrey Panin wrote:
> > On 078, 03 19, 2005 at 08:33:14PM +0200, Jacques Goldberg wrote:
> > >    That's really what is needed (mainline).
> > >    I attach the file which Sasha, author or the lmodem driver, has
> > > modified and then it works for the chips hard-wired in the routine.
> > >    To locate the patched area, look for 5457
> > 
> > We can use PCI quirk here. Patch attached.
> 
> I haven't seen any mail in this thread which provides the complete
> PCI ID information for these cards.

I took them from the patched 8250_pci.c file in Jacques' previous mail:

/*
 * pci devices with appropriate class declared, but known as
 * non modems or serial
 */
static struct pci_device_id __devinitdata non_serial_pci_tbl[] = {
	{	PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5451,
		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
	{	PCI_VENDOR_ID_AL, 0x5457,
		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
	{	PCI_VENDOR_ID_AL, 0x5459,
		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
	{ 0, }
};

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net
