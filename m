Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVA3PTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVA3PTk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 10:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVA3PTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 10:19:40 -0500
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:60312 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S261711AbVA3PTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 10:19:32 -0500
Message-ID: <313680C9A886D511A06000204840E1CF0A6475C5@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.10-rc3  Log Buffer question - booting without console .
	..
Date: Sun, 30 Jan 2005 10:18:44 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> My kernel command line is:
>  console=ttyCPM0,115200 panic=3 root=/dev/ram debug log_buf_len=128 KB 
> Also I have:
> CONFIG_LOG_BUF_SHIFT=16
> and
> CONFIG_DEBUG_KERNEL=y (the drivers info part only)
> in .config
> Also I have commented out the console_init() call to prevent serial driver
> from hanging (this is my CPM  problem, which I can not solve so far  )
>  - this allows booting to continue ...
> 
> In my Log Buf I see (after the board soft reboots by itself in a while) I
> see first my debug printk-s  from __init start_kernel() (main.c):
> ....
> after acpi_early_init
> <<<<<===  this is my last debug printk from __init start_kernel() (main.c)
> <6>checking if image is initramfs...it isn't (no cpio magic);looks like an
> initrd.
> <4>Freeing initrd memory: 1202k freed.
> <7>DEV: registering device: ID = 'platform'.
> <7>bus type 'platform' registered.
> .....
> Then log buffer lists many more registered devices 
> .....
> showing at the end :  
> 
> <6>HDLC support module revision 1.17.
> <6>elevator: using anticipatory as default io scheduler.
> <5>physmap flash device: 4000000 at 8000000
> ............... 
> .................
> And nothing more  - I do not see there in the log buffer:
> 
> RAMDISK: Compressed image found at block 0  
> 
> neither I see in the log buffer any indication of OOPS or kernel panic ...
> 
> 
> but the board clearly reboots !
> 
> Werner - could you kindly tell me why Log Buffer looks incomplete and why
> I do not see what caused the reboot there.?
> 
> Any suggestions how to make Log Buffer complete ?
> 
> Thanks,
> Best Regards,
> Alex
