Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUHGUn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUHGUn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 16:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUHGUn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 16:43:26 -0400
Received: from 216-99-218-29.dsl.aracnet.com ([216.99.218.29]:22665 "EHLO
	tabla.groveronline.com") by vger.kernel.org with ESMTP
	id S264373AbUHGUnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 16:43:25 -0400
Message-ID: <41153EE2.2060608@groveronline.com>
Date: Sat, 07 Aug 2004 13:43:14 -0700
From: Andy Grover <andy@groveronline.com>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] pirq_enable_irq cleanup
References: <20040804181457.GA30739@groveronline.com> <1091797385.16288.24.camel@localhost.localdomain>
In-Reply-To: <1091797385.16288.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2004-08-04 at 19:14, agrover wrote:
>>This is a cleanup of pirq_enable_irq. I couldn't understand this function easily 
>>so I cleaned it up.
>>
>>- Hoisted Via quirk to top -- shouldn't break anything but who knows - can someone 
>>with this chipset test?
>>- Hoisted legacy IDE check too.
> This looks odd (its hard to read it in diff format in this case). The
> IDE check is only meant to be done if we look for an IRQ and find none.
> This tells us the device is only connected for legacy mode.

> The VIA one is fairly simple. After the IRQ has been identified or
> selected the VIA needs the "true" PCI IRQ number in the IRQ_LINE
> register because internal V-Bus devices are routed via IRQ line not via
> IRQ pin as the PCI spec says.

Thanks for the explanation.

So perhaps do you think there's any alternative ways we can make this 
function understandable? I gotta believe there's a way for it to do what 
it needs to without 5 layers of nested if()s.

Regards -- Andy

