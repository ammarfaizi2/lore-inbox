Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSGCQtV>; Wed, 3 Jul 2002 12:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSGCQtP>; Wed, 3 Jul 2002 12:49:15 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:54237 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317189AbSGCQrz>; Wed, 3 Jul 2002 12:47:55 -0400
Date: Wed, 3 Jul 2002 03:01:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Oliver Xymoron <oxymoron@waste.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020703010102.GB112@elf.ucw.cz>
References: <Pine.LNX.4.44.0206251146440.9420-100000@waste.org> <Pine.LNX.4.33.0206251140060.8496-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0206251140060.8496-100000@geena.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [ We could also create a swap interface that we skip over when we notify 
> these interfaces. Then we walk the tree and save state to the swap 
> devices. Then, tell the swap devices to suspend, which can notify the 
> devices to actually go to sleep....maybe..]

No.

swsusp works like this

	stop all devices
	save state
	atomically copy memory into my_big_buffer
	start all devices
	write my_big_buffer into swap
	poweroff

It does not need explicit knowledge of where swap is. And I believe it
is reasonable that way.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
