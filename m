Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVBXH5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVBXH5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVBXH5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:57:40 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.27]:50923 "EHLO smtp4.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261942AbVBXH5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:57:09 -0500
X-ME-UUID: 20050224075659633.018201C003C8@mwinf0407.wanadoo.fr
Date: Thu, 24 Feb 2005 08:47:28 +0100
To: Meelis Roos <mroos@linux.ee>
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       Sven Hartge <hartge@ds9.gnuu.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christian Kujau <evil@g-house.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah) PCI IRQ map
Message-ID: <20050224074728.GA31434@pegasos>
References: <20041206185416.GE7153@smtp.west.cox.net> <Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 10:36:36AM +0200, Meelis Roos wrote:
> >The PCI IRQ map for the old Motorola PowerStackII (Utah) boards was
> >incorrect, but this breakage wasn't exposed until 2.5, and finally fixed
> >until recently by Sebastian Heutling <sheutlin@gmx.de>.
> 
> Yesterday I finally got around to testing it. It seems the patch has 
> been applied in Linus's tree so I downloaded the latest BK and tried it.
> 
> Still does not work for me but this time it's different. Before the 
> patch SCSI worked fine but PCI NICs caused hangs. Now I can't test PCI 
> NICs because even the onboard 53c825 SCSI hangs - seems it gets no 
> interrupts.
> 
> It detects the HBA, tries device discovery, gets a timeout, ABORT, 
> timeout, TARGET RESET, timeout, BUS RESET, timeout, HOST RESET and there 
> it hangs.
> 
> Does it work for anyone else on Powerstack II Pro4000 (Utah)?

Can you try : 

  http://people.debian.org/~luther/d-i/images/daily/powerpc/netboot/vmlinuz-prep.initrd

It works for me, and the kernel (2.6.8) has the irqs patched, but not the scsi
stuff touched, i think.

Friendly,

Sven Luther

