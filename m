Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbUKTMBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbUKTMBW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 07:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUKTL7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 06:59:25 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:32231 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262767AbUKTL5r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 06:57:47 -0500
Message-ID: <419F313C.1010708@free.fr>
Date: Sat, 20 Nov 2004 12:57:48 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [ACPI] Re: [PATCH] smsc-ircc2: Add PnP support.
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr> <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee> <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee> <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee> <20041120114327.GA11797@sci.fi>
In-Reply-To: <20041120114327.GA11797@sci.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Syrjälä wrote:
> On Sat, Nov 20, 2004 at 01:09:36AM +0200, Meelis Roos wrote:
> 
>>I tried it with pnpbios (acpi=off) and it started to work after auto and 
>>activate (but not with auto alone):
>>
>>nartsiss:/# modprobe smsc-ircc2
>>found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
>>smsc_superio_flat(): IrDA not enabled
>>smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, irq: 0, mode: 0x02
>>FATAL: Error inserting smsc_ircc2 
>>(/lib/modules/2.6.10-rc2/kernel/drivers/net/irda/smsc-ircc2.ko): No such 
>>device
>>nartsiss:/# echo activate > resources
>>pnp: Device 00:0f activated.
>>nartsiss:/# modprobe smsc-ircc2
>>found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
>>smsc_superio_flat(): fir: 0x2e8, sir: 0x100, dma: 03, irq: 5, mode: 0x0e
>>SMsC IrDA Controller found
>> IrCC version 2.0, firport 0x2e8, sirport 0x100 dma=3, irq=5
>>No transceiver found. Defaulting to Fast pin select
>>IrDA: Registered device irda0
> 
> 
> It is using the legacy probe instead of the pnp probe. Did you actually 
> apply the pnp patch?
> 
No he doesn't use the pnp patch : only latest snapshot for the stable 
Linux kernel.

But there is still the problem with pnpacpi that is needed to fixed.

> I'm not entirely sure what has been discussed since somebody removed 
> me from the CC list...
> 

