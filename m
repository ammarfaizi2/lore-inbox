Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131649AbQKNXVp>; Tue, 14 Nov 2000 18:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131667AbQKNXVg>; Tue, 14 Nov 2000 18:21:36 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54029 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131649AbQKNXVX>;
	Tue, 14 Nov 2000 18:21:23 -0500
Message-ID: <3A11C1B6.E61FF9F6@mandrakesoft.com>
Date: Tue, 14 Nov 2000 17:50:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Aloni <karrde@callisto.yi.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test11-pre5
In-Reply-To: <Pine.LNX.4.21.0011150030030.26513-100000@callisto.yi.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
> 
> against: test11-pre5
> summery: dev_3c501.name shouldn't be NULL, or we get oops
> reason: Correct me if I'm wrong, but 3c501.c:init_module() calls
> net_init.c:register_netdev(&dev_3c501), which calls strchr(),
> {and might also,which might} dereference dev_3c501.name.

There is no dereferencing involved, and therefore no problem.

> struct net_device
> {
> 
>         /*
>          * This is the first field of the "visible" part of this structure
>          * (i.e. as seen by users in the "Space.c" file).  It is the name
>          * the interface.
>          */
>         char                    name[IFNAMSIZ];

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
