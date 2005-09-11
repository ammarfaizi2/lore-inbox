Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVIKQyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVIKQyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVIKQyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:54:13 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:19218 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S1750754AbVIKQyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:54:13 -0400
From: Meelis Roos <mroos@linux.ee>
To: castet.matthieu@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH - Resend] PNPACPI: only parse device that have CRS method
In-Reply-To: <4324030F.3090406@free.fr>
User-Agent: tin/1.7.10-20050815 ("Grimsay") (UNIX) (Linux/2.6.13 (i686))
Message-Id: <20050911165410.6383314168@rhn.tartu-labor>
Date: Sun, 11 Sep 2005 19:54:10 +0300 (EEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mc> this patch blacklist device that don't have CRS method as there are
mc> useless for pnp layer as they don't provide any resource.

I tried it on my laptop (Toshiba Satellite 1800-314). It removed one
device from PNP bus, 00:0c, id = TOS6200, no options (as shown by 2.6.13).

I hoped it will notice something different about my SMCf010. It's
onboard IRDA that is disabled by BIOS. But the device is still there
with your patch and still does not work.

The background: it's disabled by BIOS. PNPBIOS could activate it
(haven't tried since PNPACPI came). PNPACPI could not activate it -
activate worked, resources showed resources but smsc-ircc2 got still no
configuration (chip itself was not reprogrammed?). The speculation was
that it's because of missing CRS in ACPI tables but this device did not
disappear with your current patch.

Any ideas about getting it to work with PNPACPI - or should I just
declare my ACPI BIOS broken and revert to PNPBIOS on this laptop? Do you
want seome more ACPI debug info than last time?

-- 
Meelis Roos
