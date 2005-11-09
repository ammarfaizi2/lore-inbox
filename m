Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVKIMxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVKIMxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 07:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVKIMxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 07:53:11 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:37535 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1750715AbVKIMxK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 07:53:10 -0500
Message-ID: <4371F134.4080004@bootc.net>
Date: Wed, 09 Nov 2005 12:53:08 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1 libata pata_via
References: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net> <1131419726.19575.5.camel@localhost.localdomain> <53BB7006-124E-4AE0-8A0B-AED3167D0E63@bootc.net>
In-Reply-To: <53BB7006-124E-4AE0-8A0B-AED3167D0E63@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot wrote:
> 
> On 8 Nov 2005, at 3:15, Alan Cox wrote:
> 
>> On Llu, 2005-11-07 at 17:32 +0000, Chris Boot wrote:
>>
>>> Hi all,
>>>
>>> Since I've only got a DVD drive on good ol' PATA, I thought I'd try
>>> Alan's latest VIA PATA driver for libata, to see where I got. Well,
>>> the machine simply doesn't boot, preferring to get stuck after
>>> detecting the drive. I've tried with and without
>>> libata.atapi_enabled=1 and get the same result in both cases. Here's
>>> my log with some SysRq output that might be useful:
>>
>>
>> Thanks for giving it a try. Can you also give me an lspci -v for
>> reference
> 
> 
[snip]

I got a little further with your -ide1 patch: it boots! However, it 
doesn't detect the drive at all:

[4294671.912000] ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [ALKA] -> 
GSI 20 (level, low) -> IRQ 177
[4294671.949000] PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1
[4294671.982000] ata5: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 
0xD000 irq 14
[4294672.017000] ata5: port disabled. ignoring.
[4294672.048000] scsi4 : pata_via
[4294672.078000] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 
0xD008 irq 15
[4294672.113000] ata6: port disabled. ignoring.
[4294672.145000] scsi5 : pata_via

I suppose it might be a bit much asking that an ATAPI drive work on a 
PATA bus with lilbata, but hey... ;-)

Do you think I should try the generic driver?

Cheers,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

