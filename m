Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTFKMkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 08:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTFKMkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 08:40:06 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:65247 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264448AbTFKMkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 08:40:02 -0400
Date: Wed, 11 Jun 2003 13:53:33 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] And yet more PCI fixes for 2.5.70
Message-ID: <20030611125333.GA1241@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1055290315109@kroah.com> <1055335057.2083.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055335057.2083.14.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 01:37:37PM +0100, Alan Cox wrote:
 > On Mer, 2003-06-11 at 01:11, Greg KH wrote:
 > >  			/* user supplied value */
 > >  			system_bus_speed = idebus_parameter;
 > > -		} else if (pci_present()) {
 > > +		} else if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) != NULL) {
 > 
 > That is just gross. pci_present() is far more readable even if you make
 > it an inline in pci.h that is pci_find_device(PCI_ANY_ID, PCI_ANY_ID,
 > NULL)

That was my argument I was trying to get across with the previous
lot of ugly PCI changes.  I lost that one, and lost the will to fight
this one.

		Dave

