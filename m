Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129860AbRAEQwf>; Fri, 5 Jan 2001 11:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbRAEQwZ>; Fri, 5 Jan 2001 11:52:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30726 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129860AbRAEQwR>; Fri, 5 Jan 2001 11:52:17 -0500
Subject: Re: [PATCH] VESA framebuffer w/ MTRR locks 2.4.0 on init
To: bmayland@leoninedev.com (Bryan Mayland)
Date: Fri, 5 Jan 2001 16:54:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kraxel@goldbach.in-berlin.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A55FAC9.9EB4C967@leoninedev.com> from "Bryan Mayland" at Jan 05, 2001 11:48:09 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ea7x-00081J-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Dough!  I normally use ywrap scrolling, the memory thing means that I get a big
> "black hole" every time I get down to that last 64k of memory, and before the
> pointer to the console's display resets back to "top" of the memory region.  The
> only way I've found to get around this is to force the size of the video memory.
> Does this mean that there's a problem with the display adapter that it wraps reads
> of video memory at the 2048k boundary?  Is the 64k used by the Crystal 4232 and/or
> OPL3?  If so, why doesn't listening to sounds screw with my fbcon?

Its used on the chip for the onboard audio. See drivers/sound/nm256*. If you
have other sound chips then it is probably not needed.

yywrap is a hack rather than generally safe feature and its not guaranteed that
your videoram wraps neatly. Really the driver should have spotted the hole I
guess.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
