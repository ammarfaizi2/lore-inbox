Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbUCRMpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbUCRMpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:45:20 -0500
Received: from aun.it.uu.se ([130.238.12.36]:30706 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262592AbUCRMpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:45:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16473.39381.452618.398385@alkaid.it.uu.se>
Date: Thu, 18 Mar 2004 13:45:09 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tulip (pnic) errors in 2.6.5-rc1
In-Reply-To: <40597E68.7090908@pobox.com>
References: <16473.28514.341276.209224@alkaid.it.uu.se>
	<40597123.8020903@pobox.com>
	<405971B3.3080700@pobox.com>
	<16473.32039.160055.63522@alkaid.it.uu.se>
	<40597E68.7090908@pobox.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
 > Mikael Pettersson wrote:
 > > Jeff Garzik writes:
 > >  > er, oops... lemme find the right patch...
 > > 
 > > No change, still a flood of those tulip_rx() interrupt messages.
 > 
 > hmmm.  Well, it is something unrelated to tulip driver, then.
 > 
 > Did you recently change module options, or forget to disable tulip_debug 
 > in modprobe.conf or modules.conf ?
 > 
 >          if (tulip_debug > 4)
 >                  printk(KERN_DEBUG "%s: exiting interrupt, csr5=%#4.4x.\n",
 >                             dev->name, inl(ioaddr + CSR5));
 > 
 > Those messages only appear if a non-default verbosity has been selected.

I had the same .config and kernel boot parameters as for 2.6.4,
except I disabled modules and everything non-essential, and
didn't apply my private patches.

440BX chipset, no I/O-APIC, no ACPI, no PREEMPT, direct PCI access,
two FA310TXs (eth0 idle, eth1 had light traffic).
