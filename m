Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129090AbQJ3PA6>; Mon, 30 Oct 2000 10:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129043AbQJ3PAs>; Mon, 30 Oct 2000 10:00:48 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:39048 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129033AbQJ3PAg>; Mon, 30 Oct 2000 10:00:36 -0500
Message-ID: <39FD8D0B.B6C0C772@uow.edu.au>
Date: Tue, 31 Oct 2000 02:00:27 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kumon@flab.fujitsu.co.jp
CC: dean gaudet <dean-list-linux-kernel@arctic.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was: 
 Strange performance behavior of 2.4.0-test9)
In-Reply-To: <39FB02D5.9AF89277@uow.edu.au>,
		<39F957BC.4289FF10@uow.edu.au>
		<39F92187.A7621A09@timpanogas.org>
		<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
		<20001027094613.A18382@gruyere.muc.suse.de>
		<200010271257.VAA24374@asami.proc.flab.fujitsu.co.jp>
		<39FAF4C6.3BB04774@uow.edu.au>
		<39FB02D5.9AF89277@uow.edu.au> <200010300927.SAA05368@asami.proc.flab.fujitsu.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kumon@flab.fujitsu.co.jp wrote:
> 
> Andrew Morton writes:
>  >
>  > I agree with me.  Could you please test the scalability
>  > of this?
> 
> Here is the result, measured on 8-way profusion.

Thank you!

> Andrew posted two paches, so called P1 and P2.

Was `P2' the shorter one?   It looks like it.

>                 Req/s
> test10-pre5:    2255    bad performance
> ----
> test9+P2:       5243
> test10-pre5+P1: 5187
> test10-pre5+P2: 5258
> 
> P2 may be a little bit better.

I'd be interested in seeing the -DSINGLE_LISTEN_UNSERIALIZED_ACCEPT
figures.

Dean,  it looks like the same problem will occur with flock()-based
serialisation.  Does Apache/Linux ever use that option?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
