Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWDSSVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWDSSVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWDSSVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:21:14 -0400
Received: from spirit.analogic.com ([204.178.40.4]:53256 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750944AbWDSSVN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:21:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <20060419180724.GD25047@stusta.de>
x-originalarrivaltime: 19 Apr 2006 18:21:12.0171 (UTC) FILETIME=[099B73B0:01C663DE]
Content-class: urn:content-classes:message
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Date: Wed, 19 Apr 2006 14:21:12 -0400
Message-ID: <Pine.LNX.4.61.0604191415590.28421@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Thread-Index: AcZj3gmioSzxIBIrQYSUoIbveewcIw==
References: <20060418220715.GO11582@stusta.de> <20060419051355.GI4825@rhun.haifa.ibm.com> <20060419180724.GD25047@stusta.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Apr 2006, Adrian Bunk wrote:

> On Wed, Apr 19, 2006 at 08:13:55AM +0300, Muli Ben-Yehuda wrote:
>> On Wed, Apr 19, 2006 at 12:07:15AM +0200, Adrian Bunk wrote:
>>> virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated
>>> on i386.
>>
>> You should probably update Documentation/ while you're at it.
>
> Which file under Documentation/ are you referring to?
>
>> Also, IIRC Xen uses virt_to_phys to return guest physical addresses
>> and virt_to_bus to return machine physical addresses, so the
>> difference is useful at least in some scenarios.
>
> Solving this should be easy.
>
> And this still doesn't make it right for architecture independent
> drivers to use virt_to_bus/bus_to_virt.

Then what would you use to return the proper bus address to put
into a DMA scatter list and, conversely, how would you convert
those bus addresses into something a virtual mode CPU could
access?  These macros used to be the link that made such driver
coding architecture independent. You cannot just claim that
one can't make such conversions anymore. The CPU uses virtual
addresses and the DMA uses physical (bus) addresses. Do we
throw away DMA altogether?

>
>> Cheers,
>> Muli
>
> cu
> Adrian
>
> --
>
>       "Is there not promise of rain?" Ling Tan asked suddenly out
>        of the darkness. There had been need of rain for many days.
>       "Only a promise," Lao Er said.
>                                       Pearl S. Buck - Dragon Seed
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
