Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVAJIjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVAJIjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 03:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVAJIjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 03:39:42 -0500
Received: from ngate.noida.hcltech.com ([202.54.110.230]:19077 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S262150AbVAJIjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 03:39:31 -0500
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB0352DEA7@exch-03.noida.hcltech.com>
From: "Bhupesh Kumar Pandey, Noida" <bhupeshp@noida.hcltech.com>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: RE: regarding hotpluggable devices adn linux kernel
Date: Mon, 10 Jan 2005 14:06:32 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot.
Now I should try my own. 


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Thanks and Best Regards
Bhupesh Kumar Pandey


-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Monday, January 10, 2005 12:50 PM
To: Bhupesh Kumar Pandey, Noida
Cc: linux-kernel@vger.kernel.org
Subject: Re: regarding hotpluggable devices adn linux kernel

On Mon, Jan 10, 2005 at 12:39:56PM +0530, Bhupesh Kumar Pandey, Noida wrote:
> "Hotplug of FC-HBA on PCI Express bus

This would involve the pci hotplug driver.  On 2.6, look in
/sys/bus/pci/slots for the different pci slots (after you have loaded the
proper pci hotplug driver for your hardware.)  To add or remove a card,
simply echo 0 or 1 in the power file in the slot that you wish to turn on or
off.  I recommend using the pcihpview program if you don't like using echo,
as it is a gui driven program to do the same thing.

The FC-HBA portion is the same if it's hotplugged or not, no difference
there.

> and PnP of SCSI disk".

It should just be added, if the whole FC-HBA comes up.  If you mean adding
another one later on, after the controller card has scanned the bus, I don't
know, ask the scsi people.

Hope this helps.

greg k-h
