Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131060AbQLIAfE>; Fri, 8 Dec 2000 19:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131557AbQLIAeo>; Fri, 8 Dec 2000 19:34:44 -0500
Received: from feral.com ([192.67.166.1]:46167 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S131060AbQLIAef>;
	Fri, 8 Dec 2000 19:34:35 -0500
Date: Fri, 8 Dec 2000 16:03:58 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: baettig@scs.ch, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock question (2.2)
In-Reply-To: <E144XLU-0004eG-00@the-village.bc.nu>
Message-ID: <Pine.BSF.4.21.0012081603110.72881-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2000, Alan Cox wrote:

> > Yes, and I believe that this is what's broken about the SCSI midlayer. The the
> > io_request_lock cannot be completely released in a SCSI HBA because the flags
> 
> You can drop it with spin_unlock_irq and that is fine. I do that with no
> problems in the I2O scsi driver for example

I am (like, I think I *finally* got locking sorta right in my QLogic driver),
but doesn't this still leave ints blocked for this CPU at least?

-matt


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
