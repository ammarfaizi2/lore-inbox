Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136890AbRAHGMh>; Mon, 8 Jan 2001 01:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137075AbRAHGM1>; Mon, 8 Jan 2001 01:12:27 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:11526
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S136890AbRAHGMM>; Mon, 8 Jan 2001 01:12:12 -0500
Date: Mon, 8 Jan 2001 19:12:09 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, david@linux.com,
        greearb@candelatech.com, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
Message-ID: <20010108191209.B4682@metastasis.f00f.org>
In-Reply-To: <20010107162905.B1804@metastasis.f00f.org> <Pine.LNX.4.10.10101070220410.4173-100000@Huntington-Beach.Blue-Labs.org> <20010108011308.A2575@metastasis.f00f.org> <200101071201.EAA01790@pizda.ninka.net> <20010108063214.A29026@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010108063214.A29026@gruyere.muc.suse.de>; from ak@suse.de on Mon, Jan 08, 2001 at 06:32:14AM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 06:32:14AM +0100, Andi Kleen wrote:

    I think it would be better to keep it. The ifa based alias
    interface emulation adds minor overhead (currently it's only a
    few lines of code, assuming we need named if addresses for other
    reasons too, which we do) and removing it it would break a lot of
    configuration scripts etc., for no really good gain.

It's ugly and deceptive -- eth0:0 is _not_ a separate device to eth0,
so why pretend it is?

Yes, FIXING this wart will break stuff, that is part of the reason we
have development cycles. Applications that break need fixing anyhow,
as DaveM says BSD support multiple addresses per interface anyhow, so
perhaps not many applications will break at all -- I've not really
checked.

2.5.x seems like an excellent time to FIX this. I guess the final
decision is that of DaveM and Alexey.



  --cw (These are mine opinions alone, but they should be everyones)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
