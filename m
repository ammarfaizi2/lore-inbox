Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVKSBHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVKSBHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVKSBHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:07:49 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:54205 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1751184AbVKSBHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:07:48 -0500
Message-ID: <437E7ADB.5080200@shadowconnect.com>
Date: Sat, 19 Nov 2005 02:07:39 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
References: <4379AADD.5000600@shadowconnect.com>	<20051115.132836.41612515.davem@davemloft.net>	<437B254E.9040909@shadowconnect.com> <20051116.111843.23450955.davem@davemloft.net>
In-Reply-To: <20051116.111843.23450955.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

David S. Miller wrote:
> From: Markus Lidel <Markus.Lidel@shadowconnect.com>
> Date: Wed, 16 Nov 2005 13:25:50 +0100
>>>This should be detected at runtime, and that is easily done.
>>>You can use the PCI device to get at the firmware device
>>>node, and use that to look for a firmware device node property
>>>that identifies it as a card from Sun.
>>>Usually the "name" property has some identifying string in it.
>>>Sometimes there is a property with the string "fcode" in it and you
>>>could look for that as well.
>>OK, i'll look at it... Thanks for the hint!
> Actually, my idea won't work if the card is used in a non-Sparc
> system.  Do these cards have PCI subsystem vendor or device ID's that
> identify it as a Sun card?

Here's the output of lspci:

0003:01:03.0 Memory controller: Adaptec (formerly DPT) Domino RAID Engine 
(rev 02)
         Subsystem: Adaptec (formerly DPT) Domino RAID Engine
         Flags: bus master, medium devsel, latency 32, IRQ 0082efe0
         BIST result: 00
         Memory at 000001c980100000 (32-bit, non-prefetchable) [size=64K]
         Memory at 000001c988000000 (32-bit, prefetchable) [size=128M]

0003:01:04.0 I2O: Adaptec (formerly DPT) SmartRAID V Controller (rev 03)
         Subsystem: Adaptec (formerly DPT) SmartRAID V Controller
         Flags: bus master, medium devsel, latency 1, IRQ 0082ef80
         BIST result: 00
         Memory at 000001c990000000 (32-bit, non-prefetchable) [size=2M]
         I/O ports at 0000000002010400 [size=256]
         Expansion ROM at 0000000080000000 [disabled] [size=32K]

As it looks it's equal to the "Intel" based cards...

Don't think it will work then, right?



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
