Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136580AbRAHG07>; Mon, 8 Jan 2001 01:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136605AbRAHG0t>; Mon, 8 Jan 2001 01:26:49 -0500
Received: from Cantor.suse.de ([194.112.123.193]:19728 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136580AbRAHG0g>;
	Mon, 8 Jan 2001 01:26:36 -0500
Date: Mon, 8 Jan 2001 07:26:34 +0100
From: Andi Kleen <ak@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
        david@linux.com, greearb@candelatech.com, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
Message-ID: <20010108072634.A29753@gruyere.muc.suse.de>
In-Reply-To: <20010107162905.B1804@metastasis.f00f.org> <Pine.LNX.4.10.10101070220410.4173-100000@Huntington-Beach.Blue-Labs.org> <20010108011308.A2575@metastasis.f00f.org> <200101071201.EAA01790@pizda.ninka.net> <20010108063214.A29026@gruyere.muc.suse.de> <20010108191209.B4682@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010108191209.B4682@metastasis.f00f.org>; from cw@f00f.org on Mon, Jan 08, 2001 at 07:12:09PM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 07:12:09PM +1300, Chris Wedgwood wrote:
> On Mon, Jan 08, 2001 at 06:32:14AM +0100, Andi Kleen wrote:
> 
>     I think it would be better to keep it. The ifa based alias
>     interface emulation adds minor overhead (currently it's only a
>     few lines of code, assuming we need named if addresses for other
>     reasons too, which we do) and removing it it would break a lot of
>     configuration scripts etc., for no really good gain.
> 
> It's ugly and deceptive -- eth0:0 is _not_ a separate device to eth0,
> so why pretend it is?

Who says that it names a device? It names interfaces.
There are good reasons to have names for ifas, and I see no really good
convincing reasons not to put these names into the interface name space.
(in addition it'll save a lot of people a lot of grief) 
When you're proposing a change that breaks thousands of configuration you
need a really good reason for it, and so far I cannot see one. It would 
be different if the older way needed lots of hard to maintain fragile code in 
the kernel, but that's really not the case. 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
