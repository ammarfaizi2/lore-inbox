Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbTFKOxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbTFKOxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:53:01 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:47559 "EHLO gaston")
	by vger.kernel.org with ESMTP id S262319AbTFKOwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:52:41 -0400
Subject: Re: pci_domain_nr vs. /sys/devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk>
References: <1055341842.754.3.camel@gaston>
	 <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055343980.755.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 17:06:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 16:48, Matthew Wilcox wrote:

> I don't think sysfs works like that (please correct me if I've
> misunderstood, mochel..)

Looks like nobody really understands it then ;)

> Look in /sys/bus/pci/devices/  There you have all the PCI devices
> lumped together in one place, and we obviously need the domain number
> in the name.  I don't know where the 0 on the end of /sys/devices/pci0/
> comes from, but if we could, I wouldn't say no to:

Nah, you are mixing up /sys/bus/* which is a flat list of busses in the
machine, with /sys/devices/* which is the hierarchical device tree.

> I don't think the extra level of hierarchy in your suggestion is necessary
> or particularly desirable.

It's probably not, then it's a matter of properly renaming the pciN entries
in /sys/devices to be /sys/devices/pciDD:NN where DD is the domain number
and NN is the first bus on this domain, or just pciDD (though I like having
the bus number there as well)

Ben.



