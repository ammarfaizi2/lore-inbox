Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291331AbSBHBVX>; Thu, 7 Feb 2002 20:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291345AbSBHBVN>; Thu, 7 Feb 2002 20:21:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6664 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291331AbSBHBVB>;
	Thu, 7 Feb 2002 20:21:01 -0500
Message-ID: <3C6327F5.56C5F809@mandrakesoft.com>
Date: Thu, 07 Feb 2002 20:20:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jay Estabrook <Jay.Estabrook@compaq.com>, andrea@suse.de,
        frival@zk3.dec.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Alpha update for 2.5.3
In-Reply-To: <20020207211329.A861@jurassic.park.msu.ru> <20020207165949.A3759@are.twiddle.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First comment, the below is what Ingo suggested for
sched_find_first_zero_bit.  Note that this version is -before- the bit
array changed from [I believe] 140 to 100 bits.

Second comment, some of the bits in your patch are in 2.5.3-pre3.  [but
drivers/ide/ide-dma.c does not compile for me, unrelated to alpha...]

> static inline int sched_find_first_zero_bit(unsigned long *b)
> {
>         unsigned long rt;
> 
>         rt = b[0] & b[1];
>         if (unlikely(rt != -1UL))
>                 return find_first_zero_bit(b, MAX_RT_PRIO);
> 
>         return ffz(b[2]) + MAX_RT_PRIO;
> }


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
