Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131822AbRBAXum>; Thu, 1 Feb 2001 18:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132040AbRBAXud>; Thu, 1 Feb 2001 18:50:33 -0500
Received: from [206.112.104.8] ([206.112.104.8]:1796 "EHLO
	mercury.illtel.denver.co.us") by vger.kernel.org with ESMTP
	id <S131911AbRBAXuS>; Thu, 1 Feb 2001 18:50:18 -0500
Date: Thu, 1 Feb 2001 15:50:54 -0800 (PST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Serial device with very large buffer
In-Reply-To: <E14OTPp-0005MY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10102011546290.948-100000@mercury>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Alan Cox wrote:

> >   I also propose to increase the size of flip buffer to 640 bytes (so the
> > flipping won't occur every time in the middle of the full buffer), however
> > I understand that it's a rather drastic change for such a simple goal, and
> > not everyone will agree that it's worth the trouble:
> 
> Going to a 1K flip buffer would make sense IMHO for high speed devices too

1K flip buffer makes the tty_struct exceed 4096 bytes, and I don't think,
it's a good idea to change the allocation mechanism for it.

-- 
Alex

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
