Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTJMEsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 00:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbTJMEsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 00:48:13 -0400
Received: from [61.11.60.89] ([61.11.60.89]:54278 "EHLO
	gateway.prodigylabs.net") by vger.kernel.org with ESMTP
	id S261384AbTJMEsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 00:48:11 -0400
Message-ID: <002701c39117$bd8214c0$0dc809c0@prashanth>
From: "Prashanth A Pandit" <prashanth@prodigylabs.com>
To: <linux-kernel@vger.kernel.org>
References: <000601c38ee7$89ff37e0$0dc809c0@prashanth> <3F869565.A5F8C80@toughguy.net>
Subject: Re: problem mounting CD writer in 2.4.20
Date: Mon, 13 Oct 2003 04:52:43 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, i did created an image of ext2 filesystem using following commands:

dd if=/dev/zero of=cd.img bs=1k count=4k
mke2fs cd.img
mount -o loop cd.img /mnt/tmp
cp ./* /mnt/tmp
umount /mnt/tmp

then i used 'cdrecord' as follows:
cdrecord dev=0,0,0 -data -multi cd.img

to use the CD on some other OS, i must use ISO9660 fs right? in which case,
i will go with 'mkisofs' instaed of 'mke2fs'. please tell me where am i
going wrong. this is first time am using CD writer.

thanks & regards,
- prashanth

----- Original Message -----
From: Raj <obelix123@toughguy.net>
To: Prashanth A Pandit <prashanth@prodigylabs.com>
Sent: Friday, October 10, 2003 4:47 PM
Subject: Re: problem mounting CD writer in 2.4.20


> > Output of mount /dev/scd0 /mnt/cdrom -text2
>
> Are u sure u have a CD which has an EXT2 filesystem on it ???? ;-)
> Or is it iso9660 which is the default CD format ?
>

