Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129226AbQK3OEZ>; Thu, 30 Nov 2000 09:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129391AbQK3OEQ>; Thu, 30 Nov 2000 09:04:16 -0500
Received: from lipta.cendio.se ([193.180.23.53]:20743 "EHLO lipta.cendio.se")
        by vger.kernel.org with ESMTP id <S129226AbQK3OEB>;
        Thu, 30 Nov 2000 09:04:01 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: USB doesn't work with 440MX chipset, PCI IRQ problem?
In-Reply-To: <Pine.LNX.4.21.0011300501500.8081-100000@server.serve.me.nl> <E141KOp-0006mI-00@the-village.bc.nu>
From: Marcus Sundberg <marcus@cendio.se>
Date: 30 Nov 2000 14:33:33 +0100
In-Reply-To: alan@lxorguk.ukuu.org.uk's message of "Thu, 30 Nov 2000 03:28:41 +0000 (GMT)"
Message-ID: <veelztfutu.fsf@lipta.cendio.se>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox) writes:

> > >     9:       3134          XT-PIC  3c574_cs
> > >    11:          1          XT-PIC  Ricoh Co Ltd RL5c475, usb-uhci
> > 
> > Your videocard is also at 11. Could be an issue if the USB driver hates
> > sharing IRQ's.
> 
> Other than a boot time lockup bug which is now fixed it should be fine

USB with shared interrupts on 440MX works fine with 2.2.18pre here:

  4:      82375          XT-PIC  serial
  8:          1          XT-PIC  rtc
 11:    2051785          XT-PIC  i82365, usb-uhci, eth0, eth1, Intel 440MX

Someone at Toshiba must have been very drunk when doing the PCI
routing on this otherwise nice laptop. ;)

//Marcus
-- 
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
