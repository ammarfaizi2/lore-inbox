Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbTFKP1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTFKP1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:27:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19208 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262486AbTFKP1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:27:01 -0400
Date: Wed, 11 Jun 2003 16:40:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030611164040.E16643@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Wed, Jun 11, 2003 at 03:48:01PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 03:48:01PM +0100, Matthew Wilcox wrote:
> Look in /sys/bus/pci/devices/  There you have all the PCI devices
> lumped together in one place, and we obviously need the domain number
> in the name.  I don't know where the 0 on the end of /sys/devices/pci0/
> comes from, but if we could, I wouldn't say no to:

See pci_alloc_primary_bus_parented() in drivers/pci/probe.c.  The '0'
is the bus number passed in.  So, the names include the pci bus numbers
of the root buses.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

