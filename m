Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285189AbRLXSFW>; Mon, 24 Dec 2001 13:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285192AbRLXSFM>; Mon, 24 Dec 2001 13:05:12 -0500
Received: from gear.torque.net ([204.138.244.1]:41990 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S285189AbRLXSEx>;
	Mon, 24 Dec 2001 13:04:53 -0500
Message-ID: <3C276C8F.71C17948@torque.net>
Date: Mon, 24 Dec 2001 12:57:35 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Stanislav Meduna <stano@meduna.org>
Subject: Re: IDE CDROM locks the system hard on media error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am catalogizing my set of CDs and so I have tortured my CD drive
> with a bunch of less-than-optimal CDs. I had two hard lockups
> most probably connected to problematic media.
>
> The last message in log is
>
>  kernel: scsi0: ERROR on channel 0, id 0, lun 0,
>    CDB: Request Sense 00 00 00 40 00 
>  kernel: Current sd0b:00: sense key Medium Error
>  kernel: Additional sense indicates No seek complete
>  kernel:  I/O error: dev 0b:00, sector 504
>  kernel: ISOFS: unable to read i-node block
>
> Shortly (but not immediately, the kernel tried a bit more to get
> some data from the drive) after that the system froze - not even
> SysRq worked.
> 
> I am using vanilla 2.4.17, hdc=ide-scsi, my drive is Mitsumi CR-4804TE,
> motherboard is Abit BP6 SMP, Intel PIIX4 IDE controller.

Does turning off or restricting the DMA mode using either
one of these help?
    hdparm -d0 -c1 /dev/hdc 
    hdparm -d 1 -X 34 /dev/hdc

Doug Gilbert

