Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEQso>; Fri, 5 Jan 2001 11:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEQse>; Fri, 5 Jan 2001 11:48:34 -0500
Received: from tamqfl1-ar1-128-154.dsl.gtei.net ([4.33.128.154]:7164 "EHLO
	linus.southpark") by vger.kernel.org with ESMTP id <S129183AbRAEQsW>;
	Fri, 5 Jan 2001 11:48:22 -0500
Message-ID: <3A55FAC9.9EB4C967@leoninedev.com>
Date: Fri, 05 Jan 2001 11:48:09 -0500
From: Bryan Mayland <bmayland@leoninedev.com>
Organization: Leonine Development, Inc.
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: kraxel@goldbach.in-berlin.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VESA framebuffer w/ MTRR locks 2.4.0 on init
In-Reply-To: <E14EZMf-0007vp-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > 1)  The amount of video memory is being incorrectly reported my the VESA call
> > used in arch/i386/video.S (INT 10h AX=4f00h).  My Dell Inspiron 3200 (NeoMagic
> > video) returns that it has 31 64k blocks of video memory, instead of the
> > correct 32.  This means that vesafb thinks that I've got 1984k of video ram,
>
> You have 31. The last one is used for audio buffering

    Dough!  I normally use ywrap scrolling, the memory thing means that I get a big
"black hole" every time I get down to that last 64k of memory, and before the
pointer to the console's display resets back to "top" of the memory region.  The
only way I've found to get around this is to force the size of the video memory.
Does this mean that there's a problem with the display adapter that it wraps reads
of video memory at the 2048k boundary?  Is the 64k used by the Crystal 4232 and/or
OPL3?  If so, why doesn't listening to sounds screw with my fbcon?

Bry

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
