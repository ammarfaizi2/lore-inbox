Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbUKSS30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUKSS30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 13:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbUKSS3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 13:29:23 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:9429 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261522AbUKSS3M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 13:29:12 -0500
Message-ID: <419E3B7A.4000904@free.fr>
Date: Fri, 19 Nov 2004 19:29:14 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       "Li, Shaohua" <shaohua.li@intel.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr> <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee> <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0411191934070.29328@math.ut.ee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
>> Could you send me the result of : "for i in /sys/bus/pnp/devices/*; do 
>> cat $i/id $i/options; done" in order to see if other devices have 
>> missing resources ?
> 
> 
> PNP0c01
> PNP0200
> PNP0800
> PNP0c04
> PNP0303
> PNP0f13
> PNP0b00
> PNP0c02
> PNP0700
> port 0x3f0-0x3f0, align 0x0, size 0x6, 16-bit address decoding
> port 0x3f7-0x3f7, align 0x0, size 0x1, 16-bit address decoding
> irq 6 High-Edge
> dma 2 8-bit compatible
floppy : seem ok
> PNP0501
> Dependent: 01 - Priority acceptable
>    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 02 - Priority acceptable
>    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 03 - Priority acceptable
>    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 04 - Priority acceptable
>    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
serial miss irq
> SMCf010
> Dependent: 01 - Priority acceptable
>    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 02 - Priority acceptable
>    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 03 - Priority acceptable
>    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 04 - Priority acceptable
>    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
irda : miss io,irq,dma
> PNP0401
> Dependent: 01 - Priority acceptable
>    port 0x378-0x378, align 0x0, size 0x3, 16-bit address decoding
>    port 0x778-0x778, align 0x0, size 0x3, 16-bit address decoding
>    irq 7 High-Edge
> Dependent: 02 - Priority acceptable
>    port 0x278-0x278, align 0x0, size 0x3, 16-bit address decoding
>    port 0x678-0x678, align 0x0, size 0x3, 16-bit address decoding
>    irq 5 High-Edge
> Dependent: 03 - Priority acceptable
>    port 0x3bc-0x3bc, align 0x0, size 0x3, 16-bit address decoding
>    port 0x7bc-0x7bc, align 0x0, size 0x3, 16-bit address decoding
>    irq 7 High-Edge
parallel port: miss dma
> TOS6200
> 

Could it be an acpi parsing problem ?
Is there a easy way to use ACPI_DUMP_RESOURCE_LIST in order to find all 
the resource find by acpi in order to see if it is an acpi problem or a 
pnpacpi problem ?

Matthieu


PS : I CC the message to acpi people : look 
http://marc.theaimsgroup.com/?t=110075024500002&r=1&w=2 for the begining.
