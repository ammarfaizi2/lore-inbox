Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVBVS05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVBVS05 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 13:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVBVS05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:26:57 -0500
Received: from pop.gmx.de ([213.165.64.20]:13969 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261270AbVBVS0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:26:53 -0500
X-Authenticated: #19846908
Message-ID: <421B79AD.60508@gmx.de>
Date: Tue, 22 Feb 2005 19:27:57 +0100
From: Sebastian Heutling <sheutlin@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Leigh Brown <leigh@solinno.co.uk>
CC: Meelis Roos <mroos@linux.ee>, Tom Rini <trini@kernel.crashing.org>,
       Sven Hartge <hartge@ds9.gnuu.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christian Kujau <evil@g-house.de>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII   
   Utah) PCI IRQ map
References: <20041206185416.GE7153@smtp.west.cox.net>    <Pine.SOC.4.61.0502221031230.6097@math.ut.ee>    <421B1F12.7050601@gmx.de> <5982.195.212.29.67.1109074991.squirrel@195.212.29.67>
In-Reply-To: <5982.195.212.29.67.1109074991.squirrel@195.212.29.67>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leigh Brown wrote:

>Sebastian Heutling said:
>  
>
>>Meelis Roos wrote:
>>
>>    
>>
>>>>The PCI IRQ map for the old Motorola PowerStackII (Utah) boards was
>>>>incorrect, but this breakage wasn't exposed until 2.5, and finally
>>>>fixed
>>>>until recently by Sebastian Heutling <sheutlin@gmx.de>.
>>>>        
>>>>
>>>Yesterday I finally got around to testing it. It seems the patch has
>>>been applied in Linus's tree so I downloaded the latest BK and tried it.
>>>
>>>Still does not work for me but this time it's different. Before the
>>>patch SCSI worked fine but PCI NICs caused hangs. Now I can't test PCI
>>>NICs because even the onboard 53c825 SCSI hangs - seems it gets no
>>>interrupts.
>>>
>>>It detects the HBA, tries device discovery, gets a timeout, ABORT,
>>>timeout, TARGET RESET, timeout, BUS RESET, timeout, HOST RESET and
>>>there it hangs.
>>>
>>>Does it work for anyone else on Powerstack II Pro4000 (Utah)?
>>>
>>>      
>>>
>>It does work in 2.6.8 using backported patches (e.g. the debian 2.6.8
>>kernel). But it doesn't work above that version because of other patches
>>in arch/ppc/platforms/prep_pci.c and arch/ppc/platforms/prep_setup.c
>>(made by Tom Rini?). I couldn't find out what exactly is causing this
>>problem yet (because lack of time and the fact that my Powerstack is
>>used as a router).
>>    
>>
>
>Ah, this could well be my fault.  Those patches were to improve support
>of IBM RS/6000 PReP boxes.  Do those machines have residual data?  If
>so, could anyone who has one send me the contents of /proc/residual?
>
>Also, a full boot log when working and failing would be cool.
>  
>
No, the PowerstackII Pro4000 (Utah) has no residual. I couldn't see 
anything unusal in the bootlogs except that
neither IDE nor SCSI interrupts occour (timeouts for SCSI and lost 
interrupts for IDE). I assume other PCI-devices have a similar problem. 
I will try to extract some bootlogs in the next days but I think they 
won't help.

Basti

