Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129201AbQJ1QSS>; Sat, 28 Oct 2000 12:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129327AbQJ1QSI>; Sat, 28 Oct 2000 12:18:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25360 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129201AbQJ1QR6>; Sat, 28 Oct 2000 12:17:58 -0400
Subject: Re: question on SMP and read()/write()
To: Oliver.Neukum@lrz.uni-muenchen.de (Oliver Neukum)
Date: Sat, 28 Oct 2000 17:19:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00102816313507.00773@ghanima> from "Oliver Neukum" at Oct 28, 2000 04:31:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pYhV-0005Po-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've noticed that sys_read() and sys_write() don't grab the big kernel lock.
> As file descriptors may be shared, must device drivers provide SMP safe
> read() and write() methods ?

Yes. This is true in 2.2 as well although the inode lock provides some protection
on writes.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
