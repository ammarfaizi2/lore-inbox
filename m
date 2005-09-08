Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVIHJhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVIHJhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 05:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVIHJhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 05:37:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60895 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751227AbVIHJhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 05:37:09 -0400
Message-ID: <4320060F.8010704@volny.cz>
Date: Thu, 08 Sep 2005 11:36:15 +0200
From: Miloslav Trmac <mitr@volny.cz>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wistron laptop button driver
References: <431E4E28.5020604@volny.cz> <84144f02050907234365616f@mail.gmail.com>
In-Reply-To: <84144f02050907234365616f@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 9/7/05, Miloslav Trmac <mitr@volny.cz> wrote:
> 
>>+static int __init map_bios(void)
>>+{
>>+     static const unsigned char __initdata signature[]
>>+             = { 0x42, 0x21, 0x55, 0x30 };
>>+
>>+     void __iomem *base;
>>+     size_t offset;
>>+     uint32_t entry_point;
>>+
>>+     base = ioremap(0xF0000, 0x10000); /* Can't fail */
> 
> How come? ioremap can return NULL if, for example, we run out of memory.
Not with these values:
> 	/*
> 	 * Don't remap the low PCI/ISA area, it's always mapped..
> 	 */
> 	if (phys_addr >= ISA_START_ADDRESS && last_addr < ISA_END_ADDRESS)
> 		return (void __iomem *) phys_to_virt(phys_addr);

	Mirek
