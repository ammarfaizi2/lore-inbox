Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVBVIhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVBVIhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 03:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVBVIhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 03:37:15 -0500
Received: from math.ut.ee ([193.40.36.2]:51329 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262248AbVBVIhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 03:37:10 -0500
Date: Tue, 22 Feb 2005 10:36:36 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, Christian Kujau <evil@g-house.de>,
       Sebastian Heutling <sheutlin@gmx.de>, Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah)
 PCI IRQ map
In-Reply-To: <20041206185416.GE7153@smtp.west.cox.net>
Message-ID: <Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
References: <20041206185416.GE7153@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The PCI IRQ map for the old Motorola PowerStackII (Utah) boards was
> incorrect, but this breakage wasn't exposed until 2.5, and finally fixed
> until recently by Sebastian Heutling <sheutlin@gmx.de>.

Yesterday I finally got around to testing it. It seems the patch has 
been applied in Linus's tree so I downloaded the latest BK and tried it.

Still does not work for me but this time it's different. Before the 
patch SCSI worked fine but PCI NICs caused hangs. Now I can't test PCI 
NICs because even the onboard 53c825 SCSI hangs - seems it gets no 
interrupts.

It detects the HBA, tries device discovery, gets a timeout, ABORT, 
timeout, TARGET RESET, timeout, BUS RESET, timeout, HOST RESET and there 
it hangs.

Does it work for anyone else on Powerstack II Pro4000 (Utah)?

-- 
Meelis Roos (mroos@linux.ee)
