Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131318AbRCSB0X>; Sun, 18 Mar 2001 20:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbRCSB0D>; Sun, 18 Mar 2001 20:26:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:10770 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131318AbRCSBZx>; Sun, 18 Mar 2001 20:25:53 -0500
Date: Sun, 18 Mar 2001 17:24:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <Andries.Brouwer@cwi.nl>
cc: <axboe@suse.de>, <alan@lxorguk.ukuu.org.uk>, <andre@linux-ide.org>,
        <linux-kernel@vger.kernel.org>, <p_gortmaker@yahoo.com>
Subject: Re: [PATCH] off-by-1 error in ide-probe (2.4.x)
In-Reply-To: <UTC200103190018.BAA09516.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.31.0103181723160.2981-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Mar 2001 Andries.Brouwer@cwi.nl wrote:
>
>     Agreed. That would be a trivially easy bug in the firmware, limiting to
>     255 sectors seems safer.
>
>             Linus
>
> Yes, possibly.
> I checked old standards, and see that "0 means 256 as a sector count"
> is already in ATA-1.

Yes. But we could have some silly bug in the Linux drivers too, if some
part of the driver reads back the sector count and doesn't do the 0==256
conversion. So let's not blame the disk quite yet. Although it would be
interesting to hear if the problem only happens for a specific disk or
manufacturer...

		Linus

