Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265315AbRGEPKI>; Thu, 5 Jul 2001 11:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265319AbRGEPJ7>; Thu, 5 Jul 2001 11:09:59 -0400
Received: from home.paris.trader.com ([195.68.19.162]:31208 "EHLO
	smtp-gw.netclub.com") by vger.kernel.org with ESMTP
	id <S265315AbRGEPJv>; Thu, 5 Jul 2001 11:09:51 -0400
Message-ID: <3B4483E8.2C31AC01@trader.com>
Date: Thu, 05 Jul 2001 17:12:40 +0200
From: Joseph Bueno <joseph.bueno@trader.com>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nick@guardiandigital.com
CC: Peter Zaitsev <pz@spylog.ru>, linux-kernel@vger.kernel.org
Subject: Re: Is  Swapping on software RAID1 possible  in linux 2.4 ?
In-Reply-To: <1011478953412.20010705152412@spylog.ru> <3B447FAD.1E4724C9@guardiandigital.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick DeClario wrote:
> 
> Just out of curiousity what are the advantages to having a RAID1 swap
> partition?  Setting the swap priority to 0 (pri=0) in the fstab of all
> the swap partitions on your system should have the same effect as doing
> it with RAID but without the overhead, right?  RAID1 would also mirror
> your swap.  Why would you want that?
> 
> Regards,
>         -Nick
> 
Hi,

Setting swap priority to 0 is equivalent to RAID0 (striping) not RAID1 (mirroring).

Mirroring your swap partition is important because if the disk containing
your swap fails, your system is dead. If you want to keep your system running
even if one disk fails you need to mirror ALL your active partitions including
swap.
If you only mirror your data partitions, your are only protected against data
loss in case of a disk crash (assuming you shutdown gracefully before it panics
while it tries to read/write  on a crashed swap partition and leave your data in
some inconsistent state).

Regards
--
Joseph Bueno
