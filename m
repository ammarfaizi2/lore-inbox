Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbQLASEf>; Fri, 1 Dec 2000 13:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129351AbQLASEZ>; Fri, 1 Dec 2000 13:04:25 -0500
Received: from post-11.mail.nl.demon.net ([194.159.73.21]:36102 "EHLO
	post.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id <S129465AbQLASEG>; Fri, 1 Dec 2000 13:04:06 -0500
To: Matthew Kirkwood <matthew@hairy.beasts.org>,
        "Theodore Y Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        vpnd@sunsite.auc.dk
From: folkert@vanheusden.com
Subject: Re: /dev/random probs in 2.4test(12-pre3)
Date: Fri, 1 Dec 2000 17:33:16 GMT
X-Mailer: www.webmail.nl.demon.net
X-Originating-IP: 212.115.175.146
Message-Id: <E141u3g-0006vY-00@post.mail.nl.demon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen that happen with kernel version 2.2.16!

> Hi,
> 
> It looks like the random driver in 2.4test will return a
> short read, rather than blocking.  This is breaking vpnd
> (http://sunsite.dk/vpnd/) which breaks with "failed to
> gather random data" or similar.
> 
> Here's a sample strace:
> 
> open("/dev/random", O_RDONLY)           = 3
> read(3, "q\321Nu\204\251^\234i\254\350\370\363\"\305\366R\2708V"..., 72) = 29
> close(3)                                = 0
> 
> Have the semantics of the device changed, or is vpnd doing
> something wrong?
> 
> Matthew.
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: vpnd-unsubscribe@sunsite.auc.dk
> For additional commands, e-mail: vpnd-help@sunsite.auc.dk
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
