Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130875AbQK3Ggg>; Thu, 30 Nov 2000 01:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132081AbQK3Gg0>; Thu, 30 Nov 2000 01:36:26 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:44806 "EHLO
        smtp.lax.megapath.net") by vger.kernel.org with ESMTP
        id <S130875AbQK3GgW>; Thu, 30 Nov 2000 01:36:22 -0500
Message-ID: <3A25ED97.3010900@megapathdsl.net>
Date: Wed, 29 Nov 2000 22:03:03 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001127
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Igmar Palsenberg <maillist@chello.nl>,
        Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: USB doesn't work with 440MX chipset, PCI IRQ problem?
In-Reply-To: <E141KOp-0006mI-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported a similar problem.  In my case, the interrupt
sharing is between two Cardbus cards (3c575 and a Belkin
BusPort Mobile).  My network locks up with eth0 errors.
So, do you believe this is the same bug or something else?
My machine seems to be sharing the interrupt to four devices?

#> more interrupts
            CPU0
   0:    4476120          XT-PIC  timer
   1:      26191          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   4:          5          XT-PIC  serial
   5:       2400          XT-PIC  CS4236+
  11:      21589          XT-PIC  Texas Instruments PCI1131 (#2), Texas 
Instruments PCI1131, eth0, usb-ohci
  12:      73011          XT-PIC  PS/2 Mouse
  14:     194203          XT-PIC  ide0
  15:       7951          XT-PIC  ide1
NMI:          0
ERR:          0



Alan Cox wrote:

>>>     9:       3134          XT-PIC  3c574_cs
>>>    11:          1          XT-PIC  Ricoh Co Ltd RL5c475, usb-uhci
>> 
>> Your videocard is also at 11. Could be an issue if the USB driver hates
>> sharing IRQ's.
> 
> 
> Other than a boot time lockup bug which is now fixed it should be fine
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
