Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbTBTF1u>; Thu, 20 Feb 2003 00:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbTBTF1u>; Thu, 20 Feb 2003 00:27:50 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:54546 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S264877AbTBTF1t>;
	Thu, 20 Feb 2003 00:27:49 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A33E@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "''Christoph Hellwig' '" <hch@infradead.org>
Cc: "'Linux Kernel Mailing List '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>
Subject: RE: [PATCHSET] PC-9800 subarch. support for 2.5.61 (23/26) SCSI
Date: Thu, 20 Feb 2003 14:37:42 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for many advices about pc980155 driver.
I'm trying to cleanup it.

>> +int pc98_bios_param(struct block_device *bdev, int *ip)
> 
> This should _not_ be in sd.c but the lowlevel driver.
There is a specification for PC98 SCSI HA. So we can use this
function commonly across all HA (except for bad clones). I think, 
this is better than patching many drivers by same way. Is this a
bad idea?

>> +static spinlock_t wd_lock = SPIN_LOCK_UNLOCKED;
> 
> Where is this used?
I forgot to remove it.

Thanks,
Osamu Tomita

