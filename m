Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbSAULam>; Mon, 21 Jan 2002 06:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbSAULaW>; Mon, 21 Jan 2002 06:30:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61189 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284264AbSAULaR>;
	Mon, 21 Jan 2002 06:30:17 -0500
Date: Mon, 21 Jan 2002 12:29:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020121122954.Z27835@suse.de>
In-Reply-To: <Pine.LNX.4.40.0201201054011.7238-100000@blue1.dev.mcafeelabs.com> <Pine.LNX.4.10.10201201555040.12376-100000@master.linux-ide.org> <20020121114311.A24604@suse.cz> <20020121114830.W27835@suse.de> <20020121121456.A24656@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020121121456.A24656@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21 2002, Vojtech Pavlik wrote:
> I always thought it is like this (and this is what I still believe after
> having read the sprcification):
> 
> ---
> SET_MUTIPLE 16 sectors
> ---
> READ_MULTIPLE 24 sectors
> IRQ
> PIO transfer 16 sectors
> IRQ
> PIO transfer 8 sectors
> ---
> 
> Where am I wrong?

I agree completely, see previous mail.

> By the way, the device *isn't* required to support any lower multiple
> count than the maximum one it advertizes. Ugly.

Oh? That basically narrows down the multi count value from hdparm to a
boolean on-or-off. I'd be surprised to see any drives break with lower
multi count in real life, though..

-- 
Jens Axboe

