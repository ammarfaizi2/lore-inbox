Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135583AbRDSHue>; Thu, 19 Apr 2001 03:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135588AbRDSHuY>; Thu, 19 Apr 2001 03:50:24 -0400
Received: from denise.shiny.it ([194.20.232.1]:26593 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S135583AbRDSHuF>;
	Thu, 19 Apr 2001 03:50:05 -0400
Message-ID: <XFMail.010419094948.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010418230335.A17216@win.tue.nl>
Date: Thu, 19 Apr 2001 09:49:48 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Guest section DW <dwguest@win.tue.nl>
Subject: Re: I can eject a mounted CD
Cc: lna@bigfoot.com, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > Right, so I'll check what eject(1) does. It might eject the disk even if it
>> > failed to unmount.
>>
>> It shouldn't be able to. But check and see what happens.
>
> (1) There are many different programs all called eject(1).
> I find at least four of them on this machine.
>
> (2) I missed the start of the discussion; if this is a SCSI cdrom then
> many eject programs will use raw SCSI commands and the kernel does not
> try to parse raw SCSI commands so does not know that it is ejecting
> a mounted cdrom.

Yes, eject(1) (version 2.0.2, I don't remember the author) sends a SCSI
command to eject the disk, but it's broken because it doesn't even try to
umount the partition. It gets confused by my unusual fstab. I'll fix it as
soon as I have some spare time.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

