Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVAJISr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVAJISr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 03:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVAJISr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 03:18:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:52114 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262143AbVAJISp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 03:18:45 -0500
Date: Sun, 9 Jan 2005 23:19:54 -0800
From: Greg KH <greg@kroah.com>
To: "Bhupesh Kumar Pandey, Noida" <bhupeshp@noida.hcltech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: regarding hotpluggable devices adn linux kernel
Message-ID: <20050110071954.GA13232@kroah.com>
References: <267988DEACEC5A4D86D5FCD780313FBB03500DB7@exch-03.noida.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB03500DB7@exch-03.noida.hcltech.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 12:39:56PM +0530, Bhupesh Kumar Pandey, Noida wrote:
> "Hotplug of FC-HBA on PCI Express bus

This would involve the pci hotplug driver.  On 2.6, look in
/sys/bus/pci/slots for the different pci slots (after you have loaded
the proper pci hotplug driver for your hardware.)  To add or remove a
card, simply echo 0 or 1 in the power file in the slot that you wish to
turn on or off.  I recommend using the pcihpview program if you don't
like using echo, as it is a gui driven program to do the same thing.

The FC-HBA portion is the same if it's hotplugged or not, no difference
there.

> and PnP of SCSI disk".

It should just be added, if the whole FC-HBA comes up.  If you mean
adding another one later on, after the controller card has scanned the
bus, I don't know, ask the scsi people.

Hope this helps.

greg k-h
