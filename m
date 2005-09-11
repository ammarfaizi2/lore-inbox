Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVIKRG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVIKRG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 13:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVIKRG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 13:06:27 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:5523 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750735AbVIKRG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 13:06:27 -0400
Message-ID: <43246410.9000803@free.fr>
Date: Sun, 11 Sep 2005 19:06:24 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH - Resend] PNPACPI: only parse device that have CRS method
References: <20050911165410.6383314168@rhn.tartu-labor>
In-Reply-To: <20050911165410.6383314168@rhn.tartu-labor>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Meelis

Meelis Roos wrote:
> mc> this patch blacklist device that don't have CRS method as there are
> mc> useless for pnp layer as they don't provide any resource.
> 
> I tried it on my laptop (Toshiba Satellite 1800-314). It removed one
> device from PNP bus, 00:0c, id = TOS6200, no options (as shown by 2.6.13).
> 
> I hoped it will notice something different about my SMCf010. It's
> onboard IRDA that is disabled by BIOS. But the device is still there
> with your patch and still does not work.
> 
> The background: it's disabled by BIOS. PNPBIOS could activate it
> (haven't tried since PNPACPI came). PNPACPI could not activate it -
> activate worked, resources showed resources but smsc-ircc2 got still no
> configuration (chip itself was not reprogrammed?). The speculation was
> that it's because of missing CRS in ACPI tables but this device did not
> disappear with your current patch.
> 
> Any ideas about getting it to work with PNPACPI - or should I just

You could try
http://marc.theaimsgroup.com/?l=linux-kernel&m=111827568001255&w=2 if 
you haven't yet tried it ?

 > declare my ACPI BIOS broken and revert to PNPBIOS on this laptop? Do you
 > want seome more ACPI debug info than last time?
 >
You could always use pnpacpi=no (or something like that) to disable 
pnpacpi and use pnpbios (IIRC this one worked).

cheers,

Matthieu
