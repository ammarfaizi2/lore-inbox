Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282907AbRK0Txs>; Tue, 27 Nov 2001 14:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282920AbRK0Tx2>; Tue, 27 Nov 2001 14:53:28 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:64920 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282907AbRK0TxX>; Tue, 27 Nov 2001 14:53:23 -0500
Message-Id: <5.1.0.14.2.20011127193412.00acb450@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 27 Nov 2001 19:53:10 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Absence of PS/2 keyboard causes spurious IRQ7? - Was Re:
  'spurious 8259A interrupt: IRQ7'
Cc: martin@jtrix.com (Martin A. Brooks), lkml@patrickburleson.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <E168jk1-0001J7-00@the-village.bc.nu>
In-Reply-To: <1793.10.119.8.1.1006872608.squirrel@extranet.jtrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:01 27/11/01, Alan Cox wrote:
>With IO Apic support included ? If you are using an AMD/VIA combo chipset
>board that would explain it

I do use IO Apic on both my machines (one athlon/via kt133, one p4/i845) 
and as long as I have a PS/2 keyboard attached I NEVER see the spurious 
interrupt message on either system.

With a USB keyboard instead of a PS/2 keyboard the VIA box but not the i845 
box starts showing the spurious IRQ7. It appears during boot exactly once 
(always) and then occasionally during system run time. Usually associated 
with me loading/unloading the ntfs module during testing.

Also when using the USB keyboard I get keyboard: Timeout - AT keyboard not 
present?(f4) messages popping up from time to time. Usually accompanied by 
a spurious IRQ7 message.

So at least on my VIA box there seems to be a relationship between the lack 
of PS/2 keyboard and the IRQ7 messages.

Note, with my PS/2 keyboard (before I upgraded to USB one) I never saw 
either of the above messages.

I recently upgraded the i845 box to USB keyboard as well and while I do see 
the kyboard: Timeout messages I do not see any spurious interrupts.

Very odd.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

