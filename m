Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbRGXEyO>; Tue, 24 Jul 2001 00:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266929AbRGXEyF>; Tue, 24 Jul 2001 00:54:05 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:48904 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266917AbRGXExx>;
	Tue, 24 Jul 2001 00:53:53 -0400
Date: Mon, 23 Jul 2001 21:53:16 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.7
Message-ID: <20010723215316.B15564@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I've made another release of the Compaq Hotplug PCI driver available at:
	http://www.kroah.com/linux/hotplug/
It is against 2.4.7.

Changes since last release:
	- forward ported to 2.4.7
	- fixed a problem with adding new cards that could cause oopses.
	- moved some pci_access_config calls to native pci_write and
	  pci_read calls where it could be done (pci_access_config is
	  still necessary due to the driver needing to talk to pci cards
	  before the pci_func structure is set up by the pci core.)
	- replaced lots of magic numbers with the proper PCI_* defines.

I think I've addressed all problems that people have told me about in
the past.  If there are any outstanding issues with the driver that
anyone sees could be a problem, please let me know.

thanks,

greg k-h
