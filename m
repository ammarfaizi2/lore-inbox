Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268231AbRGZQZf>; Thu, 26 Jul 2001 12:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268315AbRGZQZ0>; Thu, 26 Jul 2001 12:25:26 -0400
Received: from congress199.linuxsymposium.org ([209.151.18.199]:7429 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S267758AbRGZQZO>;
	Thu, 26 Jul 2001 12:25:14 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107261624.f6QGObT17752@lynx.adilger.int>
Subject: Re: [PATCH] 64 bit scsi read/write
To: kernel@ragnark.vestdata.no (Ragnar =?ISO-8859-1?Q?Kj=F8rstad?=)
Date: Thu, 26 Jul 2001 10:24:37 -0600 (MDT)
Cc: bcrl@redhat.com (Ben LaHaise), linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mike@bigstorage.com,
        kevin@bigstorage.com
In-Reply-To: <20010726041821.C19238@vestdata.no> from "Ragnar =?ISO-8859-1?Q?Kj=F8rstad"?= at Jul 26, 2001 04:18:21 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Ragnar writes:
> Theese are the messages from make install:
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-pre8/kernel/drivers/md/lvm-mod.o
> /lib/modules/2.4.6-pre8/kernel/drivers/md/linear.o
> /lib/modules/2.4.6-pre8/kernel/drivers/md/md.o
> /lib/modules/2.4.6-pre8/kernel/drivers/md/raid0.o
> /lib/modules/2.4.6-pre8/kernel/drivers/md/raid5.o
> depmod: 	__udivdi3
> depmod: 	__umoddi3

These drivers do division and/or modulus on block numbers, instead of
doing shift/mask.  Someone has to fix them.

Cheers, Andreas
-- 
Andreas Dilger                               Turbolinux filesystem development
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/
