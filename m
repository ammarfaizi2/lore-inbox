Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130467AbQKINKD>; Thu, 9 Nov 2000 08:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130458AbQKINJq>; Thu, 9 Nov 2000 08:09:46 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28164 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129636AbQKINJb>;
	Thu, 9 Nov 2000 08:09:31 -0500
Message-ID: <3A0AA1DD.C2C5BA1C@mandrakesoft.com>
Date: Thu, 09 Nov 2000 08:08:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Panin <pazke@orbita.don.sitek.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media/radio [check_region() removal... ]
In-Reply-To: <Pine.LNX.4.21.0011090056470.22998-200000@tricky> <3A09EC3A.82324C57@mandrakesoft.com> <20001109160652.A1953@debian>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin wrote:
> 1) how about drivers requesting 2 (or more) irq for one device ?
> AFAIK some PowerMac net drivers do it (bmac.c for example).

Should be fine..  If the driver distinguishes between the irqs, maybe
you should do "eth0-rx dma", "eth0-tx dma", etc.


> 2) i found that some net drivers (3c527.c, sk_mca.c) use io region and
> don't call request_region() at all. Should they be fixed ?

Probably...  but there may be a reason for that, too. 
drivers/net/atp.c, for example, does not use request_region because it
uses the standard parallel ports.  (ideally, of course, it should use
the parport API...)

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
