Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSIAQfT>; Sun, 1 Sep 2002 12:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSIAQfT>; Sun, 1 Sep 2002 12:35:19 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:3200 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S317253AbSIAQfS>;
	Sun, 1 Sep 2002 12:35:18 -0400
Date: Sun, 1 Sep 2002 11:31:42 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.33-bk testing
In-Reply-To: <200209011159.NAA15370@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0209011126030.1166-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Sep 2002, Mikael Pettersson wrote:

> I was able to get 2.5.33 (even with your patch) to corrupt data
> in a few seconds: writes (with dd) put corrupted data on the
> media, and reads (again with dd) returns data that doesn't
> match what's on the media.

I don't know why I didn't see the corruption the first time around.  
However, I repeated the tests with Linus' floppy update and saw the same 
thing you did.
dd if=/dev/fd0 of=floppyimage
produced corrupt output, as did a dd write to floppy command.

> The patch below is an update of the floppy workarounds patch
> I've been maintaining since the problems began in 2.5.13.
> With this patch I'm able to reliably read and write to the
> raw /dev/fd0 device. I'm not suggesting that my hack to
> bdev->bd_block_size is the correct fix, but maybe someone who
> understands the block I/O system can see what's going on and
> do a proper fix.

Thanks.  Adding your workaround produced correct outputs.  I hope we can 
some other eyes on the code and get it integrated into mainline.

