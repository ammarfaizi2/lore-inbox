Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUG3S7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUG3S7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 14:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267789AbUG3S7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 14:59:24 -0400
Received: from web14929.mail.yahoo.com ([216.136.225.94]:1449 "HELO
	web14929.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267793AbUG3S7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 14:59:22 -0400
Message-ID: <20040730185921.99631.qmail@web14929.mail.yahoo.com>
Date: Fri, 30 Jul 2004 11:59:21 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
To: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20040730181205.GW10025@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Matthew Wilcox <willy@debian.org> wrote:
> My problem is with this is the following passage from PCI 2.2 and PCI
> 2.3:
> 
>   In order to minimize the number of address decoders needed, a
> device may share a decoder between the Expansion ROM Base Address 
> register and other Base Address registers.  When expansion ROM decode
> is enabled, the decoder is used for accesses to the expansion ROM 
> and device independent software must not access the device through
> any other Base Address registers.

Alan Cox knows more about this, but I believe there is only one PCI
card in existence that does this.

For the one or two cards that do this, the device drivers could flag
this to the PCI subsystem. In the flagged case the sysfs read code
could  shut off interrupts, enable the ROM, copy it, and then reenable
interrupts. 


=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
