Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132533AbRAHJGt>; Mon, 8 Jan 2001 04:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135621AbRAHJGi>; Mon, 8 Jan 2001 04:06:38 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:10406 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132533AbRAHJGc>; Mon, 8 Jan 2001 04:06:32 -0500
Message-ID: <3A598474.3A69C684@uow.edu.au>
Date: Mon, 08 Jan 2001 20:12:20 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: timw@splhi.com
CC: Christian Loth <chris@gidayu.max.uni-duisburg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: DHCP Problems with 3com 3c905C Tornado
In-Reply-To: <20010104123139.A15097@gidayu.max.uni-duisburg.de> <3A58725F.A1E3CD37@uow.edu.au>,
		<3A58725F.A1E3CD37@uow.edu.au>; from andrewm@uow.edu.au on Mon, Jan 08, 2001 at 12:42:55AM +1100 <20010107230226.A2074@scutter.internal.splhi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Wright wrote:
> 
> Sounds somewhat familiar. The pump that came with RedHat 6.2 never worked
> correctly at work, but dhcpcd worked just fine (we don't have static IP
> addresses, but there are fewer machines than there are addresses in the pool,
> so effectively, we do :-). The odd thing is that I (mis?)understood in this
> case that dhcpcd was not working either (unless I'm confusing this with a
> different thread). Suffice to say that newer versions of pump seem to work
> much better, at least for me.

No, you're not confused.  Someone did mention that dhcpcd was
playing up.

Obviously, something changed between 2.2.14 and more current
kernels which broke pump.  I don't believe it's a driver change
because it also affects the 3c90x driver.  I don't have a theory
as to why this affects the 3com NICs though.  But I'm assuming
that whatever broke pump also broke dhcpcd.

I note that with 3c59x in 2.4.0, pump-0.7.3 basically freezes up.
It spits out a single bootp packet then goes to lunch.  I got
bored waiting after ten minutes. So an upgrade is definitely needed.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
