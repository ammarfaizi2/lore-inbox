Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129607AbRAWJQE>; Tue, 23 Jan 2001 04:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRAWJQA>; Tue, 23 Jan 2001 04:16:00 -0500
Received: from expanse.dds.nl ([194.109.10.118]:33041 "EHLO expanse.dds.nl")
	by vger.kernel.org with ESMTP id <S129446AbRAWHya>;
	Tue, 23 Jan 2001 02:54:30 -0500
Date: Tue, 23 Jan 2001 08:54:18 +0100
From: Ookhoi <ookhoi@dds.nl>
To: linux-kernel@vger.kernel.org
Subject: bootp starts before network device?
Message-ID: <20010123085418.U21704@ookhoi.dds.nl>
Reply-To: ookhoi@dds.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.14i
X-Uptime: 5:14pm  up 56 days,  6:26, 24 users,  load average: 0.00, 0.04, 0.09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I try to boot my vaio c1ve with an usb floppy drive and a kernel with
bootp and nfs root support. Unfortunately, it doesn't work, and the
reason for that seemes to be that bootp starts before the nic is
detected.

It says: IP-Config: No network devices available.

a few lines below that the nic (3com 575) is detected. 
Of course it fails to do the nfs mount.

This is with kernel 2.4.1-pre9. 

I've used root nfs and bootp a lot with older kernels (2.3, 2.4-test),
but older kernels wont boot on the vaio.

Is there a way to delay bootp, or move the nic detection up? Should I
send more info (.config)?

Tia.

		Ookhoi

PS, also tried to mount root image from floppy, but that fails too. The
floppy drive gets detected (usb support in the kernel), but it doesn't
seem to connect /dev/sda to it (the fdd is available via /dev/sda
according to the Internet). I have scsi support (disk and generic).
Maybe someone has a suggestion on this too?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
