Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWCMTw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWCMTw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWCMTw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:52:59 -0500
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:63950 "EHLO
	localhost") by vger.kernel.org with ESMTP id S932394AbWCMTw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:52:58 -0500
Message-ID: <4415CD91.5050200@free.fr>
Date: Mon, 13 Mar 2006 20:52:49 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA patch for 2.6.16-rc5
References: <1141054370.3089.0.camel@localhost.localdomain>	 <pan.2006.02.27.20.46.14.26813@free.fr>	 <1141086963.3089.26.camel@localhost.localdomain> <4404D05C.8070407@free.fr> <1141231247.23170.0.camel@localhost.localdomain> <44061F96.80900@free.fr>
In-Reply-To: <44061F96.80900@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

matthieu castet wrote:
> Hi Alan
> 
> Alan Cox wrote:
> 
>> On Maw, 2006-02-28 at 23:36 +0100, matthieu castet wrote:
>>
>>> for the SIL680 I have a 100Mhz clock instead of a 133Mhz with ide/pci 
>>> driver [1]
>>
>>
>>
>> Fixed (missing break in switch)
>>
>>
>>> The ATAPI doesn't seem to work fine with VIA.
>>
>>
>>
>> Still investigating
>>
> If it can help you, I attach a log with debug enabled.
> 
Ok, I think I have a hint.

The drive that is failling is the secondary slave [1].
When I try to change xfermode with hdparm -X, it take some times (10 s) 
and I found an error in the kernel log.
But even with that error, it seem the xfermode is changed.

What happen with libata if we lose an interrupt ?


Matthieu




[1]
/dev/hdd:

ATAPI CD-ROM, with removable media
         Model Number:       CD-RW   CDR-6S48
         Serial Number:
         Firmware Revision:  SSG5
Standards:
         Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
         Supported: CD-ROM ATAPI-2
Configuration:
         DRQ response: 50us.
         Packet size: 12 bytes
Capabilities:
         LBA, IORDY(cannot be disabled)
         DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=227ns  IORDY flow control=120ns

[2]
hdd: lost interrupt
hdd: CHECK for good STATUS
