Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268251AbRGWOyP>; Mon, 23 Jul 2001 10:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268252AbRGWOx4>; Mon, 23 Jul 2001 10:53:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43021 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S268251AbRGWOxv>;
	Mon, 23 Jul 2001 10:53:51 -0400
Date: Mon, 23 Jul 2001 16:53:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Jan Just Keijser <janjust@cisco.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.7: DAC960.c no longer builds
Message-ID: <20010723165347.F313@suse.de>
In-Reply-To: <3B5C27BD.A81DF676@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B5C27BD.A81DF676@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23 2001, Jan Just Keijser wrote:
> Hi all,
> 
> just grabbed the linux 2.4.7 sources and started compiling; it barfs on
> the DAC960.c module (which I need, actually):
> 
> gcc -D__KERNEL__ -I/local/janjust/src/linux-2.4.7/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2
> -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe  -march=i686
> -DMODULE -DMODVERSIONS -include
> /local/janjust/src/linux-2.4.7/include/linux/modversions.h
> -DEXPORT_SYMTAB -c DAC960.c
> DAC960.c: In function `DAC960_ProcessRequest':
> DAC960.c:2771: structure has no member named `sem'
> make[2]: *** [DAC960.o] Error 1
> 
> 
> This member has indeed been removed from
> $TOPDIR/include/linux/blkdev.h...

See archive, I posted a patch to fix this.

-- 
Jens Axboe

