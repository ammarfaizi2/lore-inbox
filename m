Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267965AbUGaQAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267965AbUGaQAm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 12:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUGaQAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 12:00:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57254 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267965AbUGaQAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 12:00:37 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Sat, 31 Jul 2004 08:59:45 -0700
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
References: <20040730221528.2702.qmail@web14922.mail.yahoo.com>
In-Reply-To: <20040730221528.2702.qmail@web14922.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407310859.45769.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 30, 2004 3:15 pm, Jon Smirl wrote:
> If you set pci_dev->resource[PCI_ROM_RESOURCE] to C000:0 won't this
> mess up pci_assign_resource()/release_resource()?

Yeah, you're right, that wouldn't be a good thing to do.  I guess I'll have to 
hang a different structure off of the pci_dev so we can tell the sysfs rom 
handling code where to get the rom.  Doing it that way would allow us to deal 
with cards that really need a copy made too, though the default behavior 
would be to read it directly.

How does that sound?

Jesse
