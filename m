Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVBVMBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVBVMBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVBVMBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:01:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:17639 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262273AbVBVMBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:01:00 -0500
X-Authenticated: #19846908
Message-ID: <421B1F12.7050601@gmx.de>
Date: Tue, 22 Feb 2005 13:01:22 +0100
From: Sebastian Heutling <sheutlin@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, Christian Kujau <evil@g-house.de>,
       Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah)
 PCI IRQ map
References: <20041206185416.GE7153@smtp.west.cox.net> <Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:

>> The PCI IRQ map for the old Motorola PowerStackII (Utah) boards was
>> incorrect, but this breakage wasn't exposed until 2.5, and finally fixed
>> until recently by Sebastian Heutling <sheutlin@gmx.de>.
>
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
> timeout, TARGET RESET, timeout, BUS RESET, timeout, HOST RESET and 
> there it hangs.
>
> Does it work for anyone else on Powerstack II Pro4000 (Utah)?
>
It does work in 2.6.8 using backported patches (e.g. the debian 2.6.8 
kernel). But it doesn't work above that version because of other patches 
in arch/ppc/platforms/prep_pci.c and arch/ppc/platforms/prep_setup.c 
(made by Tom Rini?). I couldn't find out what exactly is causing this 
problem yet (because lack of time and the fact that my Powerstack is 
used as a router).

Basti
