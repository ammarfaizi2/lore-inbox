Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280818AbRKGP06>; Wed, 7 Nov 2001 10:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280816AbRKGP0s>; Wed, 7 Nov 2001 10:26:48 -0500
Received: from smtp.kpnqwest.com ([193.242.92.8]:38929 "EHLO kpnqwest.com")
	by vger.kernel.org with ESMTP id <S280823AbRKGP0i>;
	Wed, 7 Nov 2001 10:26:38 -0500
Message-ID: <06601B69B526914CB62E1C7B1663B5CA436014@w2kexgvie02>
From: "Bene, Martin" <Martin.Bene@KPNQwest.com>
To: "'Roy Sigurd Karlsbakk'" <roy@karlsbakk.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: RAID question
Date: Wed, 7 Nov 2001 16:22:28 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roy,

> raid5: measuring checksumming speed
>    8regs     :  1480.800 MB/sec
>    32regs    :   711.200 MB/sec
>    pIII_sse  :  1570.400 MB/sec
>    pII_mmx   :  1787.200 MB/sec
>    p5_mmx    :  1904.000 MB/sec
> raid5: using function: pIII_sse (1570.400 MB/sec)
> 
> Why is raid5 using function pIII_sse when p5_MMX is way faster?

The sse version is prefered over the others and gets used regardless of
speed if it's available:

/* We force the use of the SSE xor block because it can write around L2.
   We may also be able to load into the L1 only depending on how the cpu
   deals with a load to a line that is being prefetched.  */

Bye, Martin
