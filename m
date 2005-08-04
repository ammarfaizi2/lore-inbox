Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVHDQJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVHDQJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVHDQJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:09:42 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:56463 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262595AbVHDQIS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:08:18 -0400
Message-ID: <42F23D70.5010201@free.fr>
Date: Thu, 04 Aug 2005 18:08:16 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: acpi-devel@lists.sourceforge.net, Shaohua Li <shaohua.li@intel.com>,
       Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: [PATCH] PNPACPI: fix types when decoding ACPI resources
 [resend]
References: <200508020955.54844.bjorn.helgaas@hp.com> <200508031541.53777.bjorn.helgaas@hp.com> <42F20C5B.3020506@free.fr> <200508040957.55485.bjorn.helgaas@hp.com>
In-Reply-To: <200508040957.55485.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> On Thursday 04 August 2005 6:38 am, matthieu castet wrote:
> 
>>Bjorn Helgaas wrote:
>>
>>>On Wednesday 03 August 2005 3:16 pm, matthieu castet wrote:
>>>
>>>>Bjorn Helgaas wrote:
>>>>
>>>>>	drivers/char/hpet.c
>>>>>		This probably should be converted to PNP.  I'll
>>>>>		look into doing this.
>>>>
>>>>IIRC, I am not sure that the pnp layer was able to pass the 64 bits 
>>>>memory adress for hpet correctly. But it would be nice if it works.
>>>
>>>You're right, this was broken.  But I've been pushing a PNPACPI
>>>patch to fix this.
>>>
>>
>>Yes but is ACPI_RSTYPE_ADDRESS64 possible on 32 bit machine ?
> 
> 
> I can't think of a case where that would make sense, but I don't
> actually know the answer.
> 
> 
>>In this case your patch won't work as res->mem_resource[i].start and 
>>res->mem_resource[i].end are unsigned long, and 64 bit value won't fit.
> 
> 
> True.  But fixing that would be pretty far-reaching (changing struct
> resource), so I'm not worried until it is shown to be a problem.
> 
Ok, may be you could add a BUG_ON(sizeof(long)==4) for 
ACPI_RSTYPE_ADDRESS64.

Matthieu

