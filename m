Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVFGBJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVFGBJQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 21:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVFGBJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 21:09:16 -0400
Received: from avexch02.qlogic.com ([198.70.193.200]:14896 "EHLO
	avexch01.qlogic.com") by vger.kernel.org with ESMTP id S261800AbVFGBJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 21:09:12 -0400
Date: Mon, 6 Jun 2005 18:09:11 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Greg KH <gregkh@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Message-ID: <20050607010911.GA9869@plap.qlogic.org>
References: <20050607002045.GA12849@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607002045.GA12849@suse.de>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 07 Jun 2005 01:09:11.0766 (UTC) FILETIME=[83A27760:01C56AFD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jun 2005, Greg KH wrote:

> 
> Ok, as it seems there is a bit of confusion, here's real code that
> should help explain what I am proposing.  This works on my desktop, but
> I don't think it supports MSI :)
> 
> I'll go dig out an old 4-way AMD box that has MSI to see if this still
> works properly, but comments are welcome.


Thanks for posting some sample code.  Some comments though:

* What if the driver writer does not want MSI enabled for their
  hardware (even though there is an MSI capabilities entry)?  Reasons
  include: overhead involved in initiating the MSI; no support in some
  versions of firmware (QLogic hardware).

* A device (notably, our 4gb PCIe fibre-channel products) can support
  both MSI and MSI-X.  Since the driver has no way of 'disabling' MSI,
  how would it enable MSI-X?

Thanks,
Andrew
