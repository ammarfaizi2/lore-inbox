Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136679AbREIRHc>; Wed, 9 May 2001 13:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136744AbREIRHW>; Wed, 9 May 2001 13:07:22 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:23630 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136679AbREIRHM>; Wed, 9 May 2001 13:07:12 -0400
Message-ID: <3AF9799E.FA8C0D61@redhat.com>
Date: Wed, 09 May 2001 13:08:46 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benedict Bridgwater <bennyb@ntplx.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine
In-Reply-To: <E14xXJc-0002mc-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > setup all possible boot devices, only devices non-essential to the boot
> > process (sound cards, modems, crap like that) get left unconfigured.  Not
> 
> It only has to do minimal setup on them. If the BIOS calls are polled then
> assigning an IRQ is quite optional

The only way a motherboard BIOS would know if the PCI BIOS used polling
methods instead of interrupt methods is if it was a built in device.  For all
non-built in devices, it can't assume it won't need an interrupt if the card
uses interrupts at all.  I find it extremely unlikely that there exists a
motherboard BIOS that *doesn't* at least assign the I/O space area and the IRQ
for all bootable devices on the system, regardless of PnPOS settings.  Name
one concrete example of a motherboard BIOS that doesn't and I'll recant.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
