Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTE3K3A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 06:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbTE3K3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 06:29:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52696
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263558AbTE3K27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 06:28:59 -0400
Subject: Re: [PATCH] pci bridge class code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Mark Haverkamp <markh@osdl.org>, Pat Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030529214044.B30661@flint.arm.linux.org.uk>
References: <1054239461.28608.74.camel@markh1.pdx.osdl.net>
	 <20030529214044.B30661@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054287852.23562.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 May 2003 10:44:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-29 at 21:40, Russell King wrote:
> On Thu, May 29, 2003 at 01:17:42PM -0700, Mark Haverkamp wrote:
> > This adds pci-pci bridge driver model class code.  Entries appear in 
> > /sys/class/pci_bridge.
> 
> Hmm.  Ok.
> 
> How do you propose to handle the following case:
> 
> Mobility Electronics supply a Cardbus to PCI bridged "docking station"
> which has a PCI-PCI bridge on with vendor stuff above 0x40.  It appears
> as a standard PCI-PCI bridge; the only specific identifying information
> are the device and vendor IDs.  How can I guarantee that a driver I
> write for this device will be picked up in preference to your driver.
> 
> (Given that your driver would probably be always loaded, and my driver
> could well be a loadable module.)

The same is true of serveral hot docking bridges such as the one on the
IBM TP600 and also of other devices which happen to be both a PCI-PCI
bridge and have other magic stuck on them. 


