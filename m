Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268333AbRG3Gap>; Mon, 30 Jul 2001 02:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268343AbRG3Gae>; Mon, 30 Jul 2001 02:30:34 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:32265 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S268333AbRG3GaV>; Mon, 30 Jul 2001 02:30:21 -0400
Date: Mon, 30 Jul 2001 08:31:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Arnvid Karstad <arnvid@karstad.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems compiling 2.4.7 with DAC960
Message-ID: <20010730083153.B1981@suse.de>
In-Reply-To: <20010730073901.A59C.ARNVID@karstad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010730073901.A59C.ARNVID@karstad.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30 2001, Arnvid Karstad wrote:
> Hiya,
> 
> I can't seem to be getting 2.4.7 to compile on one of our boxes.
> I get this error:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.7/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c DAC960.c
> DAC960.c: In function `DAC960_ProcessRequest':
> DAC960.c:2771: structure has no member named `sem'
> make[3]: *** [DAC960.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.4.7/drivers/block'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.4.7/drivers/block'
> make[1]: *** [_subdir_block] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.7/drivers'
> make: *** [_dir_drivers] Error 2
> [root@x linux]# 
> 
> I get the same error when trying to compile it as a module..
> Is it broken, or is something else broken?

General hint: search the archives before posting, maybe someone else
already did and someone just might have posted a fix. This subject has
come up several times now :-)

But -> get 2.4.8-pre2, it includes updates to DAC960 to make it work
with the new completion interface.

-- 
Jens Axboe

