Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129745AbQKPKhZ>; Thu, 16 Nov 2000 05:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbQKPKhP>; Thu, 16 Nov 2000 05:37:15 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:30663 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129745AbQKPKhC>; Thu, 16 Nov 2000 05:37:02 -0500
Message-ID: <3A13B1B0.6370E96@uow.edu.au>
Date: Thu, 16 Nov 2000 21:06:40 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Samium Gromoff <_deepfire@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: testXX and PPPD 2.4.0-release
In-Reply-To: <E13w5s0-0001WY-00@f11.mail.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff wrote:
> 
>          DESCRIPTION:
>      Happen on 2.4.0-testXX, doesnt on 2.2.X
>      pppd 2.4.0-b2,b4,release, ppp async in kernel
>      Sportster 14400 Vi (if that hell does matter)
>       AND! UART 16450!
>      I`ve described such a problem to PPP maintainers
>    about half-year ago, but got nothing.
> 
>      Now it looks like that this problem is /tolerable/
>   in 2.4.0-testn; n>7, even when in older tests i was     just a small hell.
> 
>          PROBLEM ITSELF:
>     ~12.5% of small file transfers stalls at beginning,
>     when modem lights still flashes and ppp0 interface
>     error count significantly grow. it looks like
>     data is there, but ppp refuses to take it.

Try disabling PPP compression.  I've observed link failures
when using BSD compression against certain dial access
gateways.

In /etc/ppp/options:

nobsdcomp
deflate 0,0
noaccomp
noccp
nodeflate
nopcomp
nopredictor1
novjccomp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
