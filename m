Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVFDAUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVFDAUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 20:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFDAUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 20:20:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:57311 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261188AbVFDAT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 20:19:57 -0400
Subject: Re: pci_enable_msi() for everyone?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <gregkh@suse.de>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com, davem@davemloft.net,
       Michael Chan <mchan@broadcom.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <42A0F10D.8020308@pobox.com>
References: <20050603224551.GA10014@kroah.com>  <42A0E4B4.3050309@pobox.com>
	 <1117843264.31082.204.camel@gaston>  <42A0F10D.8020308@pobox.com>
Content-Type: text/plain
Date: Sat, 04 Jun 2005 10:16:08 +1000
Message-Id: <1117844169.31082.210.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Honestly I can think of situations where one driver would want a bit per 
> BAR, and many others would just need a single MMIO bit.  Don't forget 
> legacy decoding too:  with -only- a bit per BAR, the driver cannot tell 
> the PCI layer that disabling IO means disabling a legacy ISA region 
> that's not listed in the PCI BARs.

VGA is too much of a special case here. I'm currently working on a VGA
arbitrer but it will need a separate API (along with a userland
interface). Maybe the kernel side of this API could be folded in that
pci_enable() thing though, I'll have to give it a though...

Ben.


