Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285605AbRLRGLV>; Tue, 18 Dec 2001 01:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285604AbRLRGLD>; Tue, 18 Dec 2001 01:11:03 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:36531 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S285605AbRLRGKm>; Tue, 18 Dec 2001 01:10:42 -0500
Date: Tue, 18 Dec 2001 08:11:33 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] bouncefix-2.5.1-A2
In-Reply-To: <Pine.LNX.4.33.0112171207001.5773-200000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112180811020.23023-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Ingo Molnar wrote:

>
> okay, there was another bug as well, this time in the loopback driver: it
> did not set up its own bounce limit. This happens because the loopback
> driver is a special driver that is not governed by the normal elevator,
> thus it does not call blk_init_queue(). So the attached patch has two
> fixes:
>
>  - call blk_queue_bounce_limit() from loop.c
>  - it fixes the off-by-one bounce-limit bugs in blkdev.h
>
> does this fix your system?

Yep dead on, thanks.

Regards,
	Zwane Mwaikambo


