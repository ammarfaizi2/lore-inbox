Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRABXHf>; Tue, 2 Jan 2001 18:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRABXHZ>; Tue, 2 Jan 2001 18:07:25 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:14089 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129562AbRABXHG> convert rfc822-to-8bit; Tue, 2 Jan 2001 18:07:06 -0500
Date: Tue, 2 Jan 2001 22:27:43 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Hakan Lennestal <hakanl@cdt.luth.se>, Andre Hedrick <andre@linux-ide.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Chipsets, DVD-RAM, and timeouts.... 
In-Reply-To: <Pine.LNX.4.10.10101021038410.25012-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101022222320.612-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Linus Torvalds wrote:

> So why are the IBM drives picked on? I thought this was a hpt366 problem,
> and possibly has only shown up with IBM drives so far.
>
> It sounds like the proper fix would be to not enable ata66 by default.

It's a combination of chipset and drive that causes the problems. I've
been using ata66 with the same controller on a different drive
(FUJITSU MPE3136AT) for some time now, and it's been rock solid. It's only
the IBM DTLA drive that's been a problem on this controller.

There may be other drives which show the same problems, and perhaps we
should have an ata66 whitelist rather than a blacklist. But it's not just
a simple case that the controller can't do ata66 properly.

Highpoint made changes in their 1.26¹ BIOS to correctly support the IBM
DTLA drives. If we can get access to information about what they had to
change, we ought to be able to get it to work on those drives reliably.

-- 
dwmw2

¹ish



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
