Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132067AbQLIAx4>; Fri, 8 Dec 2000 19:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132996AbQLIAxr>; Fri, 8 Dec 2000 19:53:47 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9220 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132067AbQLIAxf>; Fri, 8 Dec 2000 19:53:35 -0500
Subject: Re: io_request_lock question (2.2)
To: mjacob@feral.com
Date: Sat, 9 Dec 2000 00:25:15 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), baettig@scs.ch,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSF.4.21.0012081603110.72881-100000@beppo.feral.com> from "Matthew Jacob" at Dec 08, 2000 04:03:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144XpF-0004iW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You can drop it with spin_unlock_irq and that is fine. I do that with no
> > problems in the I2O scsi driver for example
> 
> I am (like, I think I *finally* got locking sorta right in my QLogic driver),
> but doesn't this still leave ints blocked for this CPU at least?

spin_unlock_irq unconditionally enables

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
