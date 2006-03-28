Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWC1Ng5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWC1Ng5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWC1Ng5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:36:57 -0500
Received: from javad.com ([216.122.176.236]:53264 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S932203AbWC1Ng4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:36:56 -0500
From: Sergei Organov <osv@javad.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Artem B. Bityutskiy" <dedekind@yandex.ru>, <linux@horizon.com>,
       <kalin@thinrope.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Lifetime of flash memory
References: <20060326162100.9204.qmail@science.horizon.com>
	<4426C320.9010002@yandex.ru>
	<20060327161845.GA16775@csclub.uwaterloo.ca>
	<Pine.LNX.4.61.0603271242100.16721@chaos.analogic.com>
	<87acbb6vlj.fsf@javad.com>
	<Pine.LNX.4.61.0603280737210.21370@chaos.analogic.com>
Date: Tue, 28 Mar 2006 17:35:53 +0400
In-Reply-To: <Pine.LNX.4.61.0603280737210.21370@chaos.analogic.com>
	(linux-os@analogic.com's message of "Tue, 28 Mar 2006 07:55:32 -0500")
Message-ID: <87r74m669y.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> On Mon, 27 Mar 2006, Sergei Organov wrote:
[...]
> Huh? There is no ECC anywhere nor is it required.

Really?! Read *any* specification of NAND FLASH then.

> The flash RAM is the same kind of flash used in re-writable BIOS, etc.

No, it is not. NAND FLASH is used in CFs while NOR FLASH is used in
BIOSes.

> It requires that an entire page be erased (all bits set high) because
> the write only writes zeros. The write-procedure is a byte-at-a-time
> and results in a perfect copy being written for each byte. This
> procedure is hidden in devices that emulate hard-disks. The immediate
> read/writes are cached in internal static RAM and an ASIC manages
> everything so that the device looks like an IDE drive.

What FLASH technology do you think CF cards are based on? It seems you
think it's NOR FLASH, right? I believe you are wrong.

>> BTW, the actual block size could be rather easily found from outside, --
>> just compare random access write speed against sequential write speed
>> using different number of 512b sectors as a write unit. Increase number
>> of sectors in a write unit until you get a jump in random access write
>> performance, -- that will give you the number of sectors in the block.
>>
>
> Huh? The major time is the erase before the physical write, the entire
> physical page needs to be erased. That's why there is static-RAM buffering.
> It is quite unlikely that you will find a page size using any such
> method.

Once again, you seem to assume NOR FLASH, and AFAIK that's not the
case. For NAND FLASH block (128Kb) erase time is in order of 2ms, and
write time is about 20ms.

-- Sergei.
