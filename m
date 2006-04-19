Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWDSTye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWDSTye (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWDSTye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:54:34 -0400
Received: from spirit.analogic.com ([204.178.40.4]:22791 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751210AbWDSTyd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:54:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <1145474625.3085.101.camel@laptopd505.fenrus.org>
x-originalarrivaltime: 19 Apr 2006 19:54:32.0401 (UTC) FILETIME=[139ABC10:01C663EB]
Content-class: urn:content-classes:message
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated oni386
Date: Wed, 19 Apr 2006 15:54:32 -0400
Message-ID: <Pine.LNX.4.61.0604191550240.28667@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated oni386
Thread-Index: AcZj6xOki98pL18cTx+YiVAwMGxn9w==
References: <20060418220715.GO11582@stusta.de> <20060419051355.GI4825@rhun.haifa.ibm.com> <20060419180724.GD25047@stusta.de> <Pine.LNX.4.61.0604191415590.28421@chaos.analogic.com> <1145474625.3085.101.camel@laptopd505.fenrus.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Adrian Bunk" <bunk@stusta.de>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Apr 2006, Arjan van de Ven wrote:

> On Wed, 2006-04-19 at 14:21 -0400, linux-os (Dick Johnson) wrote:
>> On Wed, 19 Apr 2006, Adrian Bunk wrote:
>>
>>> On Wed, Apr 19, 2006 at 08:13:55AM +0300, Muli Ben-Yehuda wrote:
>>>> On Wed, Apr 19, 2006 at 12:07:15AM +0200, Adrian Bunk wrote:
>>>>> virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated
>>>>> on i386.
>>>>
>>>> You should probably update Documentation/ while you're at it.
>>>
>>> Which file under Documentation/ are you referring to?
>>>
>>>> Also, IIRC Xen uses virt_to_phys to return guest physical addresses
>>>> and virt_to_bus to return machine physical addresses, so the
>>>> difference is useful at least in some scenarios.
>>>
>>> Solving this should be easy.
>>>
>>> And this still doesn't make it right for architecture independent
>>> drivers to use virt_to_bus/bus_to_virt.
>>
>> Then what would you use to return the proper bus address to put
>> into a DMA scatter list and, conversely, how would you convert
>> those bus addresses into something a virtual mode CPU could
>> access?  These macros used to be the link that made such driver
>> coding architecture independent. You cannot just claim that
>> one can't make such conversions anymore. The CPU uses virtual
>> addresses and the DMA uses physical (bus) addresses. Do we
>> throw away DMA altogether?
>
> since a long time the kernel has proper dma mapping API's for this, in
> 2.4 it's pci specific in 2.6 it's generic and bus agnostic.
>

Yeah. Somebody finally let you put a NULL in place of the PCI
structure pointer so you didn't have to write a lot of dummy
code. Now, on ix86 devices, instead of |= PAGE_OFFSET or inverse,
one needs to add all that PCI code. Go figure. Bloatware.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
