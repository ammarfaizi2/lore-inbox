Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281748AbRLGOwd>; Fri, 7 Dec 2001 09:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRLGOw3>; Fri, 7 Dec 2001 09:52:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61957 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281748AbRLGOwR>;
	Fri, 7 Dec 2001 09:52:17 -0500
Date: Fri, 7 Dec 2001 15:52:06 +0100
From: Jens Axboe <axboe@suse.de>
To: "Martin A. Brooks" <martin@jtrix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1pre6 compile error
Message-ID: <20011207145206.GH12017@suse.de>
In-Reply-To: <1007722213.24166.2.camel@unhygienix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1007722213.24166.2.camel@unhygienix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07 2001, Martin A. Brooks wrote:
> gcc -D__KERNEL__ -I/home/martin/kernel-a-day-club/linux/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686    -c -o ps2esdi.o ps2esdi.c
> ps2esdi.c: In function `do_ps2esdi_request':
> ps2esdi.c:498: switch quantity not an integer
> ps2esdi.c:500: warning: unreachable code at beginning of switch
> statement
> make[3]: *** [ps2esdi.o] Error 1

Please take a look at the rq->cmd -> rq->flags changes. Then understand
them. Then fix ps2 and send me a diff, thanks.

:-)

-- 
Jens Axboe

