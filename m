Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVCPIBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVCPIBt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 03:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVCPIBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 03:01:49 -0500
Received: from [212.163.42.137] ([212.163.42.137]:46096 "HELO televes.com")
	by vger.kernel.org with SMTP id S262292AbVCPIBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 03:01:46 -0500
Message-ID: <51DB8827D393D411BB69003048003F46FDCFDE@tvesntr>
From: Bastos Fernandez Alexandre <ALEBAS@televes.com>
To: "'Andrew Morton'" <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Leo Li <leoli@freescale.com>,
       Bastos Fernandez Alexandre <ALEBAS@televes.com>,
       "Balasaygun, Oray (Oray)" <oray@lucent.com>
Subject: RE: [PATCH] ppc32: Update 8260_io/fcc_enet.c to function again
Date: Wed, 16 Mar 2005 09:00:51 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What can we do?
Has Oray's patch been commited? Or not yet?

I suggest commiting all the changes in this driver from linuxppc tree to
linux tree
and after this ask Oray to test again the driver and submmit new patch.
Or ask Oray to submmit changes patch to linuxppc 

Best regards,

Alex

> -----Original Message-----
> From:	Andrew Morton [SMTP:akpm@osdl.org]
> Sent:	Wednesday, March 16, 2005 7:32 AM
> To:	Tom Rini
> Cc:	linux-kernel@vger.kernel.org; Leo Li; Alexandre Bastos; Balasaygun,
> Oray (Oray)
> Subject:	Re: [PATCH] ppc32: Update 8260_io/fcc_enet.c to function
> again
> 
> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> > There's too many things in here that've sat too long (I'd been hoping to
> >  just delete the driver, but that hasn't happened yet, so).  A cobbled
> >  together list of changes is:
> > 
> >  - Update MDIO support for workqueues.
> >  - Make use of <linux/mii.h>
> >  - Add RPX6 support.
> >  - Comment out set_multicast_list (broken).
> >  - Rework tx_ring stuff so we have tx_free, not tx_Full/n_pkts.
> >  - Other PHY updates/fixes.
> >  - Leo Li: Rework FCC clock configuration, make it easier.
> >  - 2.4 : VLAN header room, other misc bits.
> >  - Kill MII_REG_NNN in favor of defines from <linux/mii.h>
> >  - DM9161 PHY support (2.4, Myself & alebas@televes.com)
> >  - PQ2ADS and PQ2FADS support bits (Myself & alebas@televes.com
> > 
> >  From: Leo Li <leoli@freescale.com>
> >  Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> >  Signed-off-by: Alexandre Bastos <alebas@televes.com>
> 
> That's unfortunate - Oray sent a patch in just a few days ago which also
> fixes up this driver.  See
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.1
> 1-mm3/broken-out/ppc-8260-fcc-ethernet-driver-cannot-read-lxt971-phy-id.pa
> tch
> 
> What should we do?
