Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVHQFnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVHQFnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 01:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbVHQFnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 01:43:37 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:10902 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1750893AbVHQFng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 01:43:36 -0400
In-Reply-To: <20050816.203312.77701192.davem@davemloft.net>
References: <20050816.203312.77701192.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>,
       "Gala Kumar K.-galak" <galak@freescale.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Zachary Amsden <zach@vmware.com>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h> 
Date: Wed, 17 Aug 2005 00:43:37 -0500
To: "David S. Miller" <davem@davemloft.net>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 16, 2005, at 10:33 PM, David S. Miller wrote:

> From: Paul Mackerras <paulus@samba.org>
> Date: Wed, 17 Aug 2005 11:38:20 +1000
>
>
>> Kumar Gala writes:
>>
>>
>>> Made <asm/segment.h> a dummy include like it is in ppc64 and removed
>>>
> any
>
>>> users if it in arch/ppc.
>>>
>>
>> Why can't we just delete asm-ppc/segment.h (and asm-ppc64/segment.h
>> too, for that matter) entirely?
>>
>
> I concur, in fact we should really kill that thing off entirely.

I'm all for killing it off entirely but got some feedback that on  
i386 segment.h can be included by userspace programs.

Here is the in kernel consumers that are outside of arch specific  
directories:

./drivers/char/mxser.c:#include <asm/segment.h>
./drivers/isdn/hisax/hisax.h:#include <asm/segment.h>
./drivers/media/video/adv7170.c:#include <asm/segment.h>
./drivers/media/video/adv7175.c:#include <asm/segment.h>
./drivers/media/video/bt819.c:#include <asm/segment.h>
./drivers/media/video/bt856.c:#include <asm/segment.h>
./drivers/media/video/saa7111.c:#include <asm/segment.h>
./drivers/media/video/saa7114.c:#include <asm/segment.h>
./drivers/media/video/saa7185.c:#include <asm/segment.h>
./drivers/serial/68328serial.c:#include <asm/segment.h>
./drivers/serial/crisv10.c:#include <asm/segment.h>
./drivers/serial/icom.c:#include <asm/segment.h>
./drivers/serial/mcfserial.c:#include <asm/segment.h>
./drivers/video/q40fb.c:#include <asm/segment.h>
./include/linux/isdn.h:#include <asm/segment.h>
./sound/oss/os.h:#include <asm/segment.h>

- kumar

