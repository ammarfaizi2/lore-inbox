Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131290AbRCRX3A>; Sun, 18 Mar 2001 18:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131309AbRCRX2u>; Sun, 18 Mar 2001 18:28:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:29967 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131290AbRCRX2p>; Sun, 18 Mar 2001 18:28:45 -0500
Date: Sun, 18 Mar 2001 15:27:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Paul Gortmaker <p_gortmaker@yahoo.com>, <alan@lxorguk.ukuu.org.uk>,
        <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] off-by-1 error in ide-probe (2.4.x)
In-Reply-To: <20010318223558.L29105@suse.de>
Message-ID: <Pine.LNX.4.31.0103181527140.2798-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Mar 2001, Jens Axboe wrote:
>
> The 256 is _not_ a bug in the driver, it's more likely a bug in your
> drive. 256 is a perfectly legal transfer size. That said, maybe it is
> a good idea to leave it at 255 just for safety on drives not handling
> 0 sectors == 128kB transfer.

Agreed. That would be a trivially easy bug in the firmware, limiting to
255 sectors seems safer.

		Linus

