Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVBXENb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVBXENb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVBXENb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:13:31 -0500
Received: from ozlabs.org ([203.10.76.45]:13750 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261776AbVBXENX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:13:23 -0500
Date: Thu, 24 Feb 2005 14:53:55 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [0/14] Orinoco driver updates
Message-ID: <20050224035355.GA32001@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, please apply:

Here's a big stack of patches that make a significant step forward on
the long overdue orinoco driver merge.  Still quite a long way to go,
but it's something.  This patch stack is againt Linus' vanilla +
Viro's big iomap cleanup patch, as requested.

The first 9 patches make only trivial or cosmetic behavioural changes:
	1/14		orinoco-carrier 
		Use netif_carrier_*() macros instead of homegrown
		'connected' variable.

	2/14		orinoco-printks 
		Update various printk()s and other cosmetic strings

	3/14		orinoco-delays
		Use mdelay() and ssleep() instead of outdated ways of
		delaying.

	4/14		orinoco-free-orinocodev
		Introduce free_orinocodev() function, to reduce noise
		in future diffs.

	5/14		orinoco-cleanup-hermes
		Assorted cleanups to low-level hardware access code

	6/14		orinoco-pci-updates
		Cleanup to initialization code for the PCI based
		orinoco devices.

	7/14		orinoco-modparm
		Use modern module_parm macros for orinoco module.

	8/14		orinoco-pccard-cleanups
		Cleanup to PCMCIA initialization code

	9/14		orinoco-void-ethersnap
		Trivial change to is_ethersnap() function to reduce
		future diff noise.

The next 4 patches start to intoduce real new functionality and
bug fixes:
	10/14		orinoco-no-ibss-any
		Disallow IBSS mode if no ESSID is set (too many
		firmwares break, otherwise)

	11/14		orinoco-late-tx-wake
		Delay waking the Tx queue, fixes problems on a number
		of firwmares

	12/14		orinoco-wep-updates
		Various updates to WEP setup code

	13/14		orinoco-update-firmware-detection
		Updates and bugfixes to firmware detection logic

And the final one, is another trivial one:
	14/14		orinoco-is-now-0.14alpha2
		Update version and changelog to reflect the above
		patches.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
