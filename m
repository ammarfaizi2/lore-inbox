Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbTFLWXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbTFLWXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:23:18 -0400
Received: from dp.samba.org ([66.70.73.150]:52660 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265024AbTFLWXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:23:17 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16104.65329.190055.862284@nanango.paulus.ozlabs.org>
Date: Fri, 13 Jun 2003 08:31:13 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Miles Lane <miles.lane@attbi.com>,
       willy@debian.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Looks like your PCI patch broke the PPC build (and others)?
In-Reply-To: <1055424925.604.39.camel@gaston>
References: <3EE77FD6.9020502@attbi.com>
	<20030611202811.GA26387@kroah.com>
	<16104.10078.284006.569894@cargo.ozlabs.ibm.com>
	<1055424925.604.39.camel@gaston>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

> Well... asm/pci-bridge.h includes linux/pci.h which includes asm/pci.h,
> so we have a circular include here...

True, but it seems that the multiple inclusion protection saves us. :)

> What I did in my tree is to move the definition of pci_controller
> from asm/pci-bridge.h to asm/pci.h. I'm now considering removing
> asm/pci-bridge.h, what do you think ?

We could do that.  It might be simpler to just take pci_domain_nr out
of line again though.

Paul.
