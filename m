Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVAWRba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVAWRba (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 12:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVAWRba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 12:31:30 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:36051 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261334AbVAWRbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 12:31:24 -0500
Message-ID: <41F3DFF5.9050806@upb.de>
Date: Sun, 23 Jan 2005 18:33:41 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: de, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 more picky about IDE drives than 2.4 ?
References: <csv3ss$a4m$1@sea.gmane.org> <58cb370e0501230850185b007f@mail.gmail.com>
In-Reply-To: <58cb370e0501230850185b007f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>i have many problems with kernel 2.6.10 since it won't run stable with
>>an IDE-device. It's an internal IDE-RAID subsystem. The DMA is
>>frequently disabled, and even writes/reads fail and the kernel reports
>>I/O-Errors for many sectors. The RAID-device doesn't report any errors
>>it it's own event-log. You can have a closer look at the error-messages
>>below.
>>
>>I'm mailing to the LKML, since i haven't been abled to reproduce the
>>problem with a kernel 2.4 bases system, but it randomly happens with 2.6
>>kernels. Let's take the latest Knoppix as an example (it comes with both
>>kernels):
>>- if i boot kernel 2.4, i can stress test the harddisk as much as i
>>want. the kernel does report any problem and it doesn't disable DMA well
>>- if i boot kernel 2.6, after a while, there are the error-message below
>>in the log. "hdparm -k1" doesn't help, the kernel will disable DMA mode.
>>There was a also a bigger problems for two times now, where the kernel
>>refused to write to the devide, due to the I/O-Errors below. I'm very
>>sad, that i haven't the log-lines prior to the I/O-Errors.
> 
> You didn't give any information about your hardware (controller type,
> drives used etc).  Please read REPORTING-BUGS in the kernel source
> directory.  Also please find last working kernel version (2.5 or 2.6).

The hardware used was a Intel 440GX Chipset (PIIX southbridge, max 
UDMA33), and a Sis 755 (SiS964 soutbridge, max UDMA133). The drive is an 
EasyRAID R5A.

http://www.easyraid.com/index.php?Products:easyRAID_R5A

>>I testes the RAID-subsystem with two different PC-systems. Always the
>>same result: 2.4 works, 2.6 does not. It's hard for me to reproduce the
>>Errors through. I'm still writing an application to reliably reproduce
>>them :-( Does anybody know a good stress-test perhaps? Sequential
>>reading doesn't seem to do the trick.
>>
>>What changes have been applied to the IDE subsystem from kernel 2.4 to
>>kernel 2.6? What may cause this different behaviour? What does
>>"status=0x51" mean? And why is "error=0x00" although the Error-Bit in
>>the status-byte has been set. (i guess this is what status=0x51 means).
>>
>>How can the behaviour of kernel 2.6 be reverted to the behaviour of
>>kernel 2.4? I already tried "hda=nowerr" in the append-line, but it
>>doesn't help either. Is it a Bug of kernel 2.6, or should i smash the
>>manufactures doors, to make them release a firmware-update of the
>>RAID-subsystem since it reports strange values to the OS?
> 
> Dunno, I don't have a magic ball... ;)

So i guess you will not know The R5A, and the Problems of Kernel 2.6 
seems to be controller independant (Intel and SiS testen).
