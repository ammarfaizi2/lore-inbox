Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133087AbQLIAXE>; Fri, 8 Dec 2000 19:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133110AbQLIAWy>; Fri, 8 Dec 2000 19:22:54 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26387 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133087AbQLIAWo>; Fri, 8 Dec 2000 19:22:44 -0500
Subject: Re: io_request_lock question (2.2)
To: mjacob@feral.com
Date: Fri, 8 Dec 2000 23:54:31 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), baettig@scs.ch,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSF.4.21.0012081017560.29052-100000@beppo.feral.com> from "Matthew Jacob" at Dec 08, 2000 10:22:22 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144XLU-0004eG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, and I believe that this is what's broken about the SCSI midlayer. The the
> io_request_lock cannot be completely released in a SCSI HBA because the flags

You can drop it with spin_unlock_irq and that is fine. I do that with no problems
in the I2O scsi driver for example

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
