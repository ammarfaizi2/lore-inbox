Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKWRWP>; Thu, 23 Nov 2000 12:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129351AbQKWRWF>; Thu, 23 Nov 2000 12:22:05 -0500
Received: from atbode61.informatik.tu-muenchen.de ([131.159.1.165]:36994 "EHLO
        atbode61.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
        id <S129153AbQKWRV7>; Thu, 23 Nov 2000 12:21:59 -0500
Date: Thu, 23 Nov 2000 17:49:52 +0100
From: Georg Acher <acher@in.tum.de>
To: Rui Sousa <rsousa@grad.physics.sunysb.edu>
Cc: Michael Elkins <me@sigpipe.org>, usb@in.tum.de,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel 2.4.0-test11-ac1 hang with usb-uhci and emu10k1
Message-ID: <20001123174952.B7591@in.tum.de>
Mail-Followup-To: Rui Sousa <rsousa@grad.physics.sunysb.edu>,
        Michael Elkins <me@sigpipe.org>, usb@in.tum.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001123020203.A30491@toesinperil.com> <Pine.LNX.4.21.0011231028030.17678-100000@grad.physics.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <Pine.LNX.4.21.0011231028030.17678-100000@grad.physics.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 04:35:33PM +0000, Rui Sousa wrote:
> On Thu, 23 Nov 2000, Michael Elkins wrote:
> 
> Usb controller is sharing a interrupt with the emu10k1.
> For what I know the emu10k1 driver doesn't have any problem
> sharing irq's, so I would blame the usb driver...

usb-uhci doesn't also have any problem with sharing irqs:

> cat /proc/interrupts
 10:    5597981          XT-PIC  aic7xxx, eth0, usb-uhci

Hm, no one left to blame...
I would debug it as follows:
Place various printks in the initialization code (reset_hc(), start_hc() and
alloc_uhci) and find out after which printk it hangs. Then it would be
possible to investigate this further...

-- 
         Georg Acher, acher@in.tum.de         
         http://www.in.tum.de/~acher/
          "Oh no, not again !" The bowl of petunias          
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
