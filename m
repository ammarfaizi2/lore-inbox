Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143981AbRAHPXN>; Mon, 8 Jan 2001 10:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144089AbRAHPXC>; Mon, 8 Jan 2001 10:23:02 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:22278 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S143981AbRAHPWu>;
	Mon, 8 Jan 2001 10:22:50 -0500
Message-ID: <3A59EA1F.AEAD08A6@candelatech.com>
Date: Mon, 08 Jan 2001 09:26:07 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hashed device lookup (New Benchmarks)
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com> <20010107042959.A14330@gruyere.muc.suse.de> <3A580B31.7998C783@candelatech.com> <20010107062744.A15198@gruyere.muc.suse.de> <3A58249F.86DD52BC@candelatech.com> <3A597665.4B68C39@candelatech.com> <200101080700.XAA10037@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    Date:        Mon, 08 Jan 2001 01:12:21 -0700
>    From: Ben Greear <greearb@candelatech.com>
> 
>    http://grok.yi.org/~greear/hashed_dev.png
>    (If you can't get to it, let me know and I'll email it to you...some
>     cable modem networks have I firewalled.)
> 
> It just seems that this shows that the implementation of ifconfig can
> be improved, since "ip" can do the same thing several orders of
> magnitude better (ie. non-quadratic system time complexity).
> 
> This is the argument I started with when this thread began, so my
> position hasn't changed, it has in fact been well supported by your
> tests :-)

I don't argue that ifconfig shouldn't be fixed, but the hash speeds up
ip by about 2X too.  Is that not useful enough?  ip seems to be implemented
pretty efficient, so if the hash helps it significantly then maybe it
can help other efficient programs too.  Notice that it is the system
(ie kernel) time that stays remarkably flat with the hash + ip graph.

Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
