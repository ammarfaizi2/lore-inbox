Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUF3Lwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUF3Lwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 07:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266632AbUF3Lwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 07:52:54 -0400
Received: from [213.146.154.40] ([213.146.154.40]:47761 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266627AbUF3Lww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 07:52:52 -0400
Date: Wed, 30 Jun 2004 12:52:49 +0100 (BST)
From: jsimmons@pentafluge.infradead.org
To: Paul Mundt <lethal@linux-sh.org>
cc: Eric Lammerts <eric@lammerts.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asiliantfb fixes
In-Reply-To: <20040630031755.GF29025@linux-sh.org>
Message-ID: <Pine.LNX.4.56.0406301252220.23967@pentafluge.infradead.org>
References: <Pine.LNX.4.58.0406292217520.5837@ally.lammerts.org>
 <20040630031755.GF29025@linux-sh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 NO_REAL_NAME           From: does not include a real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The below fix is missing. It needs to be applied.

--- linux-2.6.7/drivers/video/asiliantfb.c.orig 2004-06-28 
22:03:38.000000000 -0400
+++ linux-2.6.7/drivers/video/asiliantfb.c      2004-06-28 
22:04:28.000000000 -0400
@@ -571,7 +571,7 @@
        }

        pci_write_config_dword(dp, 4, 0x02800083);
-       writeb(3, addr + 0x400784);
+       writeb(3, p->screen_base + 0x400784);

        init_asiliant(p, addr);


On Tue, 29 Jun 2004, Paul Mundt wrote:

> On Tue, Jun 29, 2004 at 10:41:12PM -0400, Eric Lammerts wrote:
> > this patch fixes the asiliantfb driver. A call to the init function
> > was missing so it was never actually used. The other fix is in the
> > init function writing somewhere using a physical address instead of a
> > virtual address.
> > 
> The asiliantfb_init() stuff is already fixed in current BK.
> 
> 
