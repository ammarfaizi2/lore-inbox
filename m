Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129558AbRBKUAT>; Sun, 11 Feb 2001 15:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbRBKT77>; Sun, 11 Feb 2001 14:59:59 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15878 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129609AbRBKT7w>;
	Sun, 11 Feb 2001 14:59:52 -0500
Message-ID: <3A86EF11.20C17FD8@mandrakesoft.com>
Date: Sun, 11 Feb 2001 14:59:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Nick Urbanik <nicku@vtc.edu.hk>,
        Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre3 compile error in 6pack.c
In-Reply-To: <E14S04y-0004Tb-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > 2.4.2-pre3 doesn't compile with 6pack as a module; I had to disable it;
> > now it compiles (and so far, works fine).
> 
> It has a slight dependancy on -ac right now.
> 
> KMALLOC_MAXSIZE is the alloc size limit - 131072. It checks this as kmalloc
> now panics if called with an oversize request

Would it be costly/reasonable to have kmalloc -not- panic if given a
too-large size?  Principle of Least Surprises says it should return NULL
at the very least.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
