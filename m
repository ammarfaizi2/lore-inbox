Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263021AbVALF3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbVALF3s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVALF3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:29:48 -0500
Received: from ozlabs.org ([203.10.76.45]:1169 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263021AbVALF3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:29:45 -0500
Date: Wed, 12 Jan 2005 16:23:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: orinoco-devel@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [0/8] orinoco driver updates
Message-ID: <20050112052352.GA30426@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	orinoco-devel@lists.sourceforge.net, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are a bunch of patches which make a few more steps towards
the long overdue merge of the CVS orinoco driver into mainline.  These
do make behavioural changes to the driver, but they should all be
trivial and largely cosmetic.

Jeff, please apply.  Patches are against the netdev BK tree.

orinoco-printks
	Update printk()s and other cosmetic strings
orinoco-carrier
	Use netif_carrier_() functions instead of homegrown connected
	flag
orinoco-delays
	Use mdelay() and ssleep() instead of schedule_timeout() and
	other more complicated idioms.
orinoco-free-orinocodev
	Introduce free_orinocodev() function as a wrapper around
	free_netdev()
orinoco-cleanup-hermes
	Make cleanups to low-level driver code
orinoco-pccard-cleanups
	Cleanup initialization for PCMCIA/PC-Card devices.
orinoco-modparm
	Replace obsolete MODULE_PARM() constructions from orinoco.c
orinoco-pci-updates
	Cleanup initialization for PCI/PLX/TMD devices.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
