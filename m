Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131211AbRACMVF>; Wed, 3 Jan 2001 07:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131309AbRACMUy>; Wed, 3 Jan 2001 07:20:54 -0500
Received: from colorfullife.com ([216.156.138.34]:41232 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131211AbRACMUk>;
	Wed, 3 Jan 2001 07:20:40 -0500
Message-ID: <3A5311F6.A0FA300C@colorfullife.com>
Date: Wed, 03 Jan 2001 12:50:14 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: srwalter@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] in __switch_to with 2.4.0-prerelease
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> EIP: 0010:[__switch_to+33/180]
> Code:  00 0c 08 60 00 00 00 b0
> 	89 ca 08 60 4f 73 08 60 4f 73 08 74 

These asm instructions look wrong to me:
00 0c 08 --> add %cl, (%eax, %ecx, 1)
60	 --> pusha

Perhaps someone else overwrote random memory, and __switch_to crashed
later. Could you run

$objdump --disassemble-all --reloc \
	linux/arch/i386/kernel/process.o > dis.txt

and send us the disassembly of __switch_to?

And please attach the second oops as well.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
