Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSIDT5O>; Wed, 4 Sep 2002 15:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSIDT5O>; Wed, 4 Sep 2002 15:57:14 -0400
Received: from m86.net195-132-236.noos.fr ([195.132.236.86]:41601 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S315279AbSIDT5N>;
	Wed, 4 Sep 2002 15:57:13 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Craig Arsenault <penguin@wombat.ca>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Tom Rini <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>
Subject: Re: consequences of lowering "MAX_LOW_MEM"?
Date: Wed, 4 Sep 2002 22:02:27 +0200
Message-Id: <20020904200227.30104@192.168.4.1>
In-Reply-To: <Pine.LNX.4.44L.0209041453060.8359-100000@tabmow.ca.nortel.com>
References: <Pine.LNX.4.44L.0209041453060.8359-100000@tabmow.ca.nortel.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> >I think you'll find yourself with no virtual address space left to
>> >do vmalloc / fixmap / kmap type stuff. Or at least you would on i386,
>> >I presume it's the same for ppc. Sounds like you may have left
>> >yourself enough space for fixmap & kmap, but any calls to vmalloc
>> >will probably fail ?
>>
>> Yes, same problem on PPC, you'll run out of virtual space quite
>> quickly for vmalloc and ioremap. Stuff a video board with lots
>> of VRAM or any PCI card exposing large MMIO regions into your
>> machines and it will probably not even boot.
>>
>> Ben.
>>
>
>Ben,
>  But doesn't using Matt's suggestion and moving both MAX_LOW_MEM and
>changing KERNELBASE take care of this?  It's an embedded board with no
>video, but it does have one PCI Mezzanine Card (PMC) on it.

Yes, Matt's suggestion would work, though I never tried lowering
KERNELBASE. I don't think the kernel supports lowering it below
0x80000000 btw.

Ben.


