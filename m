Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130650AbQLPDFT>; Fri, 15 Dec 2000 22:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQLPDFK>; Fri, 15 Dec 2000 22:05:10 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:13842 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S129183AbQLPDFC>; Fri, 15 Dec 2000 22:05:02 -0500
Date: Sat, 16 Dec 2000 10:31:10 +0800
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
Message-Id: <200012160231.eBG2VAC30774@silk.corp.fedex.com>
To: linux-kernel@silk.corp.fedex.com
Subject: mga_dma.c, i810_dma.c error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the following errors compiling the kernel 2.4.0-test12

mga_dma.c: In function `mga_irq_install':
mga_dma.c:821: structure has no member named `next'
make[3]: *** [mga_dma.o] Error 1
make[3]: Leaving directory `/u2/src/linux-2.4.0/drivers/char/drm'


i810_dma.c: In function `i810_irq_install':
i810_dma.c:927: structure has no member named `next'
make[3]: *** [i810_dma.o] Error 1
make[3]: Leaving directory `/u2/src/linux-2.4.0/drivers/char/drm'


commented out the following in i810_dma.c and mga_dma.c to make it work ...

//dev->tq.next        = NULL;


Don't know enough as to whether this is sufficent. Need advice.


Thanks,
Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
