Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132056AbRARQxu>; Thu, 18 Jan 2001 11:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132294AbRARQxk>; Thu, 18 Jan 2001 11:53:40 -0500
Received: from mail.crc.dk ([130.226.184.8]:44294 "EHLO mail.crc.dk")
	by vger.kernel.org with ESMTP id <S132056AbRARQxa>;
	Thu, 18 Jan 2001 11:53:30 -0500
Message-ID: <3A671F45.292A9270@crc.dk>
Date: Thu, 18 Jan 2001 17:52:21 +0100
From: Mogens Kjaer <mk@crc.dk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: da, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: nfs client problem in kernel 2.4.0
In-Reply-To: <3A6466E3.AB55716@crc.dk> <shsy9wb334a.fsf@charged.uio.no> <shsu26z32lg.fsf@charged.uio.no> <3A66E248.8A1E6A85@crc.dk> <shsg0igvo19.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

> It comes from the SGI. The NFS client just considers it all a cookie,
> and passes it on to glibc. We probably shouldn't do that, as indeed
> the cookie is not guaranteed to be 32-bit signed, but it's what we
> always did for 2.2.x.

So what do I do to get it to work?

I could patch glibc so that it treats the -1/4294967295 as a special
case, but...

(I actually did this, but updating /lib/libc.so on a running system
turned out to be a really, Really, REALLY bad idea :-(( ).

Before ruining my machine it worked by prepending LD_LIBRARY_PATH to
the test program, so the idea works.

Mogens
-- 
Mogens Kjaer, Carlsberg Laboratory, Dept. of Chemistry
Gamle Carlsberg Vej 10, DK-2500 Valby, Denmark
Phone: +45 33 27 53 25, Fax: +45 33 27 47 08
Email: mk@crc.dk Homepage: http://www.crc.dk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
