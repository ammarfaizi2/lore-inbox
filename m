Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313719AbSDPPvR>; Tue, 16 Apr 2002 11:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313722AbSDPPue>; Tue, 16 Apr 2002 11:50:34 -0400
Received: from hera.cwi.nl ([192.16.191.8]:64675 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S313719AbSDPPsx>;
	Tue, 16 Apr 2002 11:48:53 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 16 Apr 2002 17:48:44 +0200 (MEST)
Message-Id: <UTC200204161548.g3GFmiD07271.aeb@smtp.cwi.nl>
To: DCox@SnapServer.com, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net, mdharm-usb@one-eyed-alien.net
Subject: [NEW] A SDDR-09 driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A moment ago I have made available on ftp.XX.kernel.org
under linux/kernel/people/aeb/sddr09.c a new SDDR-09 driver,
namely one that not only reads but also writes.

It works for me.

Will submit some version for inclusion in 2.5 next week
or so. Feedback is welcome.

Andries

[On the site mentioned one finds sddr09.c and sddr09.h.
Now that I think about it, there are a few other small
changes nearby:

diff -r /linux/2.5/linux-2.5.8/linux/drivers/usb/storage/initializers.h ./initializers.h
39a40
> #include <linux/config.h>
44a46,49
> 
> #ifdef CONFIG_USB_STORAGE_SDDR09
> int sddr09_init(struct us_data *us);
> #endif

diff -r /linux/2.5/linux-2.5.8/linux/drivers/usb/storage/unusual_devs.h ./unusual_devs.h
133d132
< #endif
139c138
<               US_SC_SCSI, US_PR_DPCM_USB, NULL, 
---
>               US_SC_SCSI, US_PR_DPCM_USB, sddr09_init,
140a140
> #endif

]
