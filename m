Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130673AbRALWYk>; Fri, 12 Jan 2001 17:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132461AbRALWYa>; Fri, 12 Jan 2001 17:24:30 -0500
Received: from zeus.kernel.org ([209.10.41.242]:16349 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130673AbRALWYW>;
	Fri, 12 Jan 2001 17:24:22 -0500
Message-ID: <3A5F66AF.8050602@interactive.net>
Date: Fri, 12 Jan 2001 15:18:55 -0500
From: "A.P.R., a.k.a. Stupendous Man" <apr@interactive.net>
Organization: Me, organized?
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010110
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bug report on 2.4.0 release
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is to report a possible 2.4.0 bug in either the kernel or
in pppd regarding wakeup after an apmsleep command.

The problem is as follows:

After successful return from an apmsleep command, issued the night
before, ppp does not seem to work. The fix is to rmmod slhc, ppp_generic,
and ppp_ttysync and then insmod them again. Then everything works as expected.
Note that I use rp-pppoe so this is ppp over an ethernet card for DSL.

The errors I get from ppp version 2.4.0 are:

   Jan 12 11:55:44 manic pppd[6173]: No response to 3 echo-requests
   Jan 12 11:55:44 manic pppd[6173]: Serial link appears to be disconnected.

Note that just bringing down and restarting my eth0 card does not solve the problem,
so I do not believe it is an ethernet card wakeup issue.

Note that this works just fine under kernel version 2.2.18 without the need
to rmmod and insmod anything.

My machine info: Asus p3bf motherboard, 500 MHz PIII PC, RH 7.0 + kernel 2.4.0,
ppp-2.4.0-2.rpm.

-- tony
------------

Surrender to the void.
			-- John Lennon

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
