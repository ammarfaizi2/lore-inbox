Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTCDVZn>; Tue, 4 Mar 2003 16:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbTCDVZn>; Tue, 4 Mar 2003 16:25:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23969
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261292AbTCDVZm>; Tue, 4 Mar 2003 16:25:42 -0500
Subject: Re: Displaying/modifying PCI device id tables via sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Greg KH <greg@kroah.com>,
       jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mochel@osdl.org
In-Reply-To: <Pine.LNX.4.44.0303041414270.23375-100000@chaos.physics.uiowa.edu>
References: <Pine.LNX.4.44.0303041414270.23375-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046817563.12231.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 04 Mar 2003 22:39:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 20:22, Kai Germaschewski wrote:
> It shares one caveat with the approach above, i.e. struct pci_device_id
> has a field called "unsigned long driver_data", and as such is really hard
> to fill from userspace. I think in the common case it's not used and can
> be just set to zero, but if the driver e.g. expects it to point to a
> driver-private structure describing the device, you lose.

Lots of drivers will simply do the wrong thing if you do that. Version
equivalence is rather more important. Of course if you know what equivalence
you are claiming you can look it up in the table to get the pci_device_id

