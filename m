Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130689AbQKQF5J>; Fri, 17 Nov 2000 00:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131748AbQKQF47>; Fri, 17 Nov 2000 00:56:59 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26129 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130689AbQKQF4u>;
	Fri, 17 Nov 2000 00:56:50 -0500
Message-ID: <3A14C167.5A9144A9@mandrakesoft.com>
Date: Fri, 17 Nov 2000 00:25:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Pete Clements <clem@clem.digital.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.0-test11-pre6 fails compile (dev.c)
In-Reply-To: <200011170256.VAA10669@clem.digital.net> <14868.41234.444045.421346@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> On Thursday November 16, clem@clem.digital.net wrote:
> > FYI:
> >
> > gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test11/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o dev.o dev.c
> > dev.c: In function `run_sbin_hotplug':
> > dev.c:2736: `hotplug_path' undeclared (first use in this function)
> > dev.c:2736: (Each undeclared identifier is reported only once
> > dev.c:2736: for each function it appears in.)
> > make[3]: *** [dev.o] Error 1
> > make[3]: Leaving directory `/sda3/usr/src/linux-2.4.0-test11/net/core'
> > make[2]: *** [first_rule] Error 2

> The following works for me.... and even looks right.

Thanks for taking care of one of my "fix after applying" items :)

Looks ok to me, though I prefer that #endif include a comment following
it that names the cpp symbol it encloses.  Applied...

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
