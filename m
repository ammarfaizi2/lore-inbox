Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVCPGcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVCPGcP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 01:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVCPGcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 01:32:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:478 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262535AbVCPGcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 01:32:08 -0500
Date: Tue, 15 Mar 2005 22:31:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Leo Li <leoli@freescale.com>,
       Alexandre Bastos <alebas@televes.com>,
       "Balasaygun, Oray (Oray)" <oray@lucent.com>
Subject: Re: [PATCH] ppc32: Update 8260_io/fcc_enet.c to function again
Message-Id: <20050315223143.229275b6.akpm@osdl.org>
In-Reply-To: <20050315182537.GW8345@smtp.west.cox.net>
References: <20050315182537.GW8345@smtp.west.cox.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> wrote:
>
> There's too many things in here that've sat too long (I'd been hoping to
>  just delete the driver, but that hasn't happened yet, so).  A cobbled
>  together list of changes is:
> 
>  - Update MDIO support for workqueues.
>  - Make use of <linux/mii.h>
>  - Add RPX6 support.
>  - Comment out set_multicast_list (broken).
>  - Rework tx_ring stuff so we have tx_free, not tx_Full/n_pkts.
>  - Other PHY updates/fixes.
>  - Leo Li: Rework FCC clock configuration, make it easier.
>  - 2.4 : VLAN header room, other misc bits.
>  - Kill MII_REG_NNN in favor of defines from <linux/mii.h>
>  - DM9161 PHY support (2.4, Myself & alebas@televes.com)
>  - PQ2ADS and PQ2FADS support bits (Myself & alebas@televes.com
> 
>  From: Leo Li <leoli@freescale.com>
>  Signed-off-by: Tom Rini <trini@kernel.crashing.org>
>  Signed-off-by: Alexandre Bastos <alebas@televes.com>

That's unfortunate - Oray sent a patch in just a few days ago which also
fixes up this driver.  See

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm3/broken-out/ppc-8260-fcc-ethernet-driver-cannot-read-lxt971-phy-id.patch

What should we do?
