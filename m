Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129684AbQL2Lwx>; Fri, 29 Dec 2000 06:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQL2Lwo>; Fri, 29 Dec 2000 06:52:44 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2566 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129684AbQL2Lwa>; Fri, 29 Dec 2000 06:52:30 -0500
Subject: Re: kernel BUG at buffer.c:765
To: summer@os2.ami.com.au (John Summerfield)
Date: Fri, 29 Dec 2000 11:23:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200012290052.IAA08785@dugite.os2.ami.com.au> from "John Summerfield" at Dec 29, 2000 08:52:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14BxdP-00056q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ll_rw_block: device 08:00: only 2048-char blocks implemented (1024)
> kernel BUG at buffer.c:765!
> invalid operand: 0000

Known problem. Its been there for a long time in 2.3.x. File system access
for FAT type files to the media is also still broken.

> Dec 28 15:10:13 dugite kernel: SCSI device sda: 310352 2048-byte hdwr sectors (636 MB)
> Dec 28 15:10:13 dugite kernel: sda: Write Protect is off
> Dec 28 15:10:13 dugite kernel:  sda: sda1

Same as mine.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
