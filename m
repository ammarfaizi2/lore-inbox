Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVBVMYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVBVMYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVBVMYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:24:04 -0500
Received: from titan.server-plant.co.uk ([80.71.3.50]:44435 "EHLO
	titan.server-plant.co.uk") by vger.kernel.org with ESMTP
	id S262288AbVBVMXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:23:39 -0500
Message-ID: <5982.195.212.29.67.1109074991.squirrel@195.212.29.67>
In-Reply-To: <421B1F12.7050601@gmx.de>
References: <20041206185416.GE7153@smtp.west.cox.net>
    <Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
    <421B1F12.7050601@gmx.de>
Date: Tue, 22 Feb 2005 12:23:11 -0000 (GMT)
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII 
     Utah) PCI IRQ map
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Sebastian Heutling" <sheutlin@gmx.de>
Cc: "Meelis Roos" <mroos@linux.ee>, "Tom Rini" <trini@kernel.crashing.org>,
       "Sven Hartge" <hartge@ds9.gnuu.de>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Christian Kujau" <evil@g-house.de>, linuxppc-dev@ozlabs.org
User-Agent: SquirrelMail/1.4.3a-0.1.7.x
X-Mailer: SquirrelMail/1.4.3a-0.1.7.x
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Heutling said:
> Meelis Roos wrote:
>
>>> The PCI IRQ map for the old Motorola PowerStackII (Utah) boards was
>>> incorrect, but this breakage wasn't exposed until 2.5, and finally
>>> fixed
>>> until recently by Sebastian Heutling <sheutlin@gmx.de>.
>>
>>
>> Yesterday I finally got around to testing it. It seems the patch has
>> been applied in Linus's tree so I downloaded the latest BK and tried it.
>>
>> Still does not work for me but this time it's different. Before the
>> patch SCSI worked fine but PCI NICs caused hangs. Now I can't test PCI
>> NICs because even the onboard 53c825 SCSI hangs - seems it gets no
>> interrupts.
>>
>> It detects the HBA, tries device discovery, gets a timeout, ABORT,
>> timeout, TARGET RESET, timeout, BUS RESET, timeout, HOST RESET and
>> there it hangs.
>>
>> Does it work for anyone else on Powerstack II Pro4000 (Utah)?
>>
> It does work in 2.6.8 using backported patches (e.g. the debian 2.6.8
> kernel). But it doesn't work above that version because of other patches
> in arch/ppc/platforms/prep_pci.c and arch/ppc/platforms/prep_setup.c
> (made by Tom Rini?). I couldn't find out what exactly is causing this
> problem yet (because lack of time and the fact that my Powerstack is
> used as a router).

Ah, this could well be my fault.  Those patches were to improve support
of IBM RS/6000 PReP boxes.  Do those machines have residual data?  If
so, could anyone who has one send me the contents of /proc/residual?

Also, a full boot log when working and failing would be cool.

