Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKIAaY>; Wed, 8 Nov 2000 19:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQKIAaR>; Wed, 8 Nov 2000 19:30:17 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:49161 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S129097AbQKIAaJ>; Wed, 8 Nov 2000 19:30:09 -0500
Date: Thu, 9 Nov 2000 01:29:46 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] media/radio [check_region() removal... ]
In-Reply-To: <3A09EC3A.82324C57@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0011090124350.23238-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000, Jeff Garzik wrote:

> Patch looks generally ok.  Some of the whitespace/formatting changes are
> questionable, I usually leave that up to the maintainer unless it is
> very gratuitously opposite to CodingStyle.
>

These drivers seem to be unmantained :)
Anyway if this is a problem I can undo these changes ...

> Some of the driver messages ("foo version 1.0") are purposefully printed
> -after-, not before, the device is probed and registered.  Your patch
> gets this wrong in at least one place.
>

Yes... I wasn't sure about this... can undo...

> Finally, a word to you, Alan, and others doing request_region work:  it
> is more informative to pass the device name (minor, etc.) into
> request_region.  Ditto for request_irq.  Many (most, except net?)
> drivers use board/chip name instead of registered interface name.  If
> you can use the interface name for request_region or request_irq, use
> it... it allows differentiation between multiple boards of the same
> type.  That's especially when looking at ISA regions in /proc/ioports,
> or interrupt counts in /proc/interrupts.
> 
> 	Jeff

Agree... but in this case it's less important until radio drivers
supports multiple boards...

thanks
--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
