Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130780AbQKJObf>; Fri, 10 Nov 2000 09:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131008AbQKJObZ>; Fri, 10 Nov 2000 09:31:25 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47109 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130780AbQKJObO>;
	Fri, 10 Nov 2000 09:31:14 -0500
Message-ID: <3A0C066D.BB6B0220@mandrakesoft.com>
Date: Fri, 10 Nov 2000 09:30:05 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Panin <pazke@orbita.don.sitek.net>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] NIC drivers check_region() removal continues
In-Reply-To: <20001110142957.A8245@debian>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin wrote:
> 
> Hi all,
> 
> new net drivers patchset (against 2.4.0-test11-pre1) attached.
> 
> Modifications: check_region() removal, passing dev->name to
> request_region() & request_irq() etc.
> 
> Drivers affected: 3c501.c, 3c503.c, 3c505.c, 82596.c, eth16i.c, hp.c,
> hp-plus.c, ibmlana.c, ne2.c, seeq8005.c, smc-mca.c, smc-ultra.c,
> smc-ultra32.c

Most patches applied, thanks.  Comments:

3c505.c:  You must abort if dma_mem_alloc return value is null, not just
print a message.
82596.c:  Not applied.  My moving the "if checksum & 0x100" line, you
make the code comments incorrect.
eth16i.c:  Your diff was not created in the main linux directory...
seeq8005.c:  Applied, but you forgot dev->name in request_region

-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
